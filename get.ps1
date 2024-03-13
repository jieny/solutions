clear-host

Write-Host "`n   Prerequisites" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
Write-Host -NoNewline "   Checking Must be elevated to higher authority".PadRight(75)
if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
	Write-Host "OK".PadLeft(8) -ForegroundColor Green
} else {
	Write-Host "Failed".PadLeft(8) -ForegroundColor Red
	return
}

<#
	.Available servers
	.可用的服务器

	Usage:
	用法：

       Only one URL address must be added in front of the, number, multiple addresses do not need to be added, example:
       只有一个 URL 地址必须在前面添加 , 号，多地址不用添加，示例：

	$Script:PreServerList = @(
        "https://fengyi.tel/download/solutions/latest.zip"
		"https://github.com/ilikeyi/Solutions/Update/latest.zip"
	)
#>
$Script:PreServerList = @(
	"https://github.com/ilikeyi/Solutions/raw/main/latest.zip"
	"https://fengyi.tel/download/solutions/latest.zip"
)

<#
    .临时存放路径
#>
$RandomGuid = [guid]::NewGuid()
$Temp_Main_Path = Join-Path -Path $env:TEMP -ChildPath $RandomGuid -ErrorAction SilentlyContinue
New-Item -Path $Temp_Main_Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

Function Test_Available_Disk
{
	param
	(
		[string]$Path
	)

	try {
		New-Item -Path $Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

		$RandomGuid = [guid]::NewGuid()
		$test_tmp_filename = "writetest-$($RandomGuid)"
		$test_filename = Join-Path -Path $Path -ChildPath $test_tmp_filename -ErrorAction SilentlyContinue

		[io.file]::OpenWrite($test_filename).close()

		if (Test-Path $test_filename -PathType Leaf)
		{
			Remove-Item $test_filename -ErrorAction SilentlyContinue
			return $true
		}
		$false
	} catch {
		return $false
	}
}

Function Test_URI
{
	Param
	(
		[Parameter(Position=0,Mandatory,HelpMessage="HTTP or HTTPS")]
		[ValidatePattern( "^(http|https)://" )]
		[Alias("url")]
		[string]$URI,
		[Parameter(ParameterSetName="Detail")]
		[Switch]$Detail,
		[ValidateScript({$_ -ge 0})]
		[int]$Timeout = 30
	)
	Process
	{
		Try
		{
			$paramHash = @{
				UseBasicParsing = $True
				DisableKeepAlive = $True
				Uri = $uri
				Method = 'Head'
				ErrorAction = 'stop'
				TimeoutSec = $Timeout
			}
			$test = Invoke-WebRequest @paramHash
			if ($Detail) {
				$test.BaseResponse | Select-Object ResponseURI,ContentLength,ContentType,LastModified, @{Name="Status";Expression={$Test.StatusCode}}
			} else {
				if ($test.statuscode -ne 200) { $False } else { $True }
			}
		} Catch {
			write-verbose -message $_.exception
			if ($Detail) {
				$objProp = [ordered]@{
					ResponseURI = $uri
					ContentLength = $null
					ContentType = $null
					LastModified = $null
					Status = 404
				}
				New-Object -TypeName psobject -Property $objProp
			} else { $False }
		}
	}
}

Function Get_Arch_Path
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path -Path "$($Path)\$($arm64)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($arm64)" -ErrorAction SilentlyContinue
			}
		}
		"AMD64" {
			if (Test-Path -Path "$($Path)\$($AMD64)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($AMD64)" -ErrorAction SilentlyContinue
			}
		}
		"x86" {
			if (Test-Path -Path "$($Path)\$($x86)" -PathType Container) {
				return Convert-Path -Path "$($Path)\$($x86)" -ErrorAction SilentlyContinue
			}
		}
	}

	return $Path
}

Function Join_MainFolder
{
	param
	(
		[string]$Path
	)
	if ($Path.EndsWith('\'))
	{
		return $Path
	} else {
		return "$Path\"
	}
}

Function Get_Zip
{
	param
	(
		$Run
	)

	$Local_Zip_Path = @(
		"${env:ProgramFiles}\7-Zip\$($Run)"
		"${env:ProgramFiles(x86)}\7-Zip\$($Run)"
		"$(Get_Arch_Path -Path "$($Temp_Main_Path)\7zPacker")\$($Run)"
	)

	ForEach ($item in $Local_Zip_Path) {
		if (Test-Path -Path $item -PathType leaf) {
			return $item
		}
	}

	return $False
}

Function Archive
{
	param
	(
		$filename,
		$to
	)

	$filename = Convert-Path $filename -ErrorAction SilentlyContinue

	if (Test-Path -Path $to -PathType leaf) {
		$to = Convert-Path $to -ErrorAction SilentlyContinue
	}

	Write-Host "   $($filename)"
	Write-host "   $($to)"
	Write-Host "   Unpacking".PadRight(28) -NoNewline

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$arguments = @(
			"x",
			"-r",
			"-tzip",
			$filename,
			"-o""$($to)""",
			"-y";
		)

		Start-Process -FilePath $Verify_Install_Path -ArgumentList $Arguments -Wait -WindowStyle Minimized

		Write-Host "     Done`n" -ForegroundColor Green
	} else {
		Expand-Archive -LiteralPath $filename -DestinationPath $to -force
		Write-Host "     Done`n" -ForegroundColor Green
	}
}

<#
	.验证可用磁盘大小
#>
Function Verify_Available_Size
{
	param
	(
		[string]$Disk,
		[int]$Size
	)

	$TempCheckVerify = $false

	Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object { ((Join_MainFolder -Path $Disk) -eq $_.Root) } | ForEach-Object {
		if ($_.Free -gt (Convert_Size -From GB -To Bytes $Size)) {
			$TempCheckVerify = $True
		} else {
			$TempCheckVerify = $false
		}
	}

	return $TempCheckVerify
}

<#
	.转换磁盘空间大小
#>
Function Convert_Size
{
	param
	(
		[validateset("Bytes","KB","MB","GB","TB")]
		[string]$From,
		[validateset("Bytes","KB","MB","GB","TB")]
		[string]$To,
		[Parameter(Mandatory=$true)]
		[double]$Value,
		[int]$Precision = 4
	)
	switch($From) {
		"Bytes" { $value = $Value }
		"KB" { $value = $Value * 1024 }
		"MB" { $value = $Value * 1024 * 1024 }
		"GB" { $value = $Value * 1024 * 1024 * 1024 }
		"TB" { $value = $Value * 1024 * 1024 * 1024 * 1024 }
	}
	switch ($To) {
		"Bytes" { return $value }
		"KB" { $Value = $Value/1KB }
		"MB" { $Value = $Value/1MB }
		"GB" { $Value = $Value/1GB }
		"TB" { $Value = $Value/1TB }
	}

	return [Math]::Round($value,$Precision,[MidPointRounding]::AwayFromZero)
}

<#
	.自动选择磁盘
#>
Function Install_Init_Disk_To
{
	<#
		.搜索磁盘条件，排除系统盘
	#>
	$drives = Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | Where-Object { -not ((Join_MainFolder -Path $env:SystemDrive) -eq $_.Root) } | Select-Object -ExpandProperty 'Root'

	<#
		.搜索磁盘条件，排除系统盘
	#>
	$FlagsSearchNewDisk = $False
	ForEach ($item in $drives) {
		if (Test_Available_Disk -Path $item) {
			$FlagsSearchNewDisk = $True

			if (Verify_Available_Size -Disk $item -Size "1") {
				return $item
			}
		}
	}

	<#
		.未找到可用磁盘，初始化：当前系统盘
	#>
	if (-not ($FlagsSearchNewDisk)) {
		return Join_MainFolder -Path $env:SystemDrive
	}
}

Function TestArchive {
	param
	(
		$Path
	)

	Add-Type -Assembly System.IO.Compression.FileSystem -ErrorAction Stop

	Try {
		$zipFile = [System.IO.Compression.ZipFile]::OpenRead($Path)
		Return $true
	} Catch {
		Return $false
	} Finally {
		If ($zipFile) {
			Try {$zipFile.Dispose()} Catch {}
		}
	}
}

$New_Root_Disk = Install_Init_Disk_To
$New_Root_Disk_Full_Solutions = Join-Path -Path $New_Root_Disk -ChildPath "YiSolutions" -ErrorAction SilentlyContinue

if((Get-ChildItem $New_Root_Disk_Full_Solutions -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
	write-host "`n   There was a problem downloading Yi's Solutions" -ForegroundColor Yellow
	write-host "`n   Error message: " -ForegroundColor Yellow
	Write-Host "   $('-' * 80)"
	Write-host "   There is a file in the directory, please delete it manually and try again.`n" -ForegroundColor Red
	Write-host "   Path: " -NoNewline
	Write-host "$($New_Root_Disk_Full_Solutions)`n" -ForegroundColor Green
} else {
	Write-Host "`n`n   * Automatically download from available servers" -ForegroundColor Green
	Write-Host "   $('-' * 80)"

	ForEach ($item in $Script:PreServerList) {
		write-host "   Connection address: " -NoNewline -ForegroundColor Yellow
		write-host $item -ForegroundColor Green

		if (Test_URI $item) {
			Write-Host "   Address available" -ForegroundColor Green

			$NewFileName = [IO.Path]::GetFileName($item)
			$NewFilePath = Join-Path -Path $Temp_Main_Path -ChildPath $NewFileName -ErrorAction SilentlyContinue

			<#
				.删除旧文件
				.Delete old files
			#>
			remove-item -path $NewFilePath -Force -ErrorAction SilentlyContinue

			Invoke-WebRequest -Uri $item -OutFile $NewFilePath -ErrorAction SilentlyContinue | Out-Null

			if (Test-Path -Path $NewFilePath -PathType leaf) {
				Add-Type -AssemblyName System.IO.Compression.FileSystem

				if (TestArchive -Path $NewFilePath) {
					Archive -filename $NewFilePath -to $New_Root_Disk_Full_Solutions

					$Route_PS = Join-Path -Path $New_Root_Disk_Full_Solutions -ChildPath "_Encapsulation\Modules\Router\Yi.ps1" -ErrorAction SilentlyContinue
					if (Test-Path -Path $Route_PS -PathType leaf) {
						powershell -file $Route_PS -Add
					}

					$Solutions_PS = Join-Path -Path $New_Root_Disk_Full_Solutions -ChildPath "_Encapsulation\_Sip.ps1" -ErrorAction SilentlyContinue
					if (Test-Path -Path $Solutions_PS -PathType leaf) {
						powershell -file $Solutions_PS
					}

					break
				} else {
					remove-item -path $NewFilePath -Force -ErrorAction SilentlyContinue

					write-host "   File format error."
				}
			} else {
				write-host "   Download failed."
			}
		} else {
			Write-Host "   Address not available`n" -ForegroundColor Red
		}
	}
}

<#
    .Clean up temporarily generated files
    .清理临时生成的文件
#>
remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null