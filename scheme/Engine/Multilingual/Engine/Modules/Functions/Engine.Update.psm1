<#
 .Synopsis
  Update

 .Description
  Update Feature Modules
#>

<#
	.Current version
	.当前版本
#>
$Global:ProductVersion = "1.0.0.2"

<#
	.Update minimum version requirements
	.更新最低版本要求
#>
$Global:chkLocalver    = "1.0.0.0"

<#
	.Update the connection to the server
	.更新连接到服务器
#>
$ServerList = @(
	("$($Global:AuthorURL)",
	 "/download/solutions/update/Multilingual/latest.xml"),
	("https://github.com",
	 "/ilikeyi/solutions/raw/main/update/Multilingual/latest.xml")
)

<#
	.Update the user interface
	.更新用户界面
#>
Function Update
{
	param
	(
		[switch]$Force,
		[switch]$Quit,
		[switch]$IsProcess
	)
	if ($Quit) { $Global:QUIT = $true }

	Logo -Title $($lang.Update)
	$ServerTest     = $false
	$IsCorrectAuVer = $false

	<#
		.Disabled IE first-launch configuration
		.禁用 IE 首次启动配置
	#>
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2 -ErrorAction SilentlyContinue

	Write-Host "   $($lang.UpdateCheckServerStatus -f $($ServerList.Count))
   ---------------------------------------------------"

	foreach ($list in $ServerList | Sort-Object { Get-Random } ) {
		$fullurl = $list[0] + $list[1]
		Write-Host "   * $($lang.UpdateServerAddress -f $($list[0]))"
		if (TestURI $fullurl) {
			$versionxmlloc = $fullurl
			$ServerTest = $true
			Write-Host "   - $($lang.UpdateServeravailable)" -ForegroundColor Green
			break
		} else {
			Write-Host "   - $($lang.UpdateServerUnavailable)`n" -ForegroundColor Red
		}
	}

	if ($ServerTest) {
		Write-Host "   ---------------------------------------------------"
		Write-Host "   - $($lang.UpdatePriority)" -ForegroundColor Green
	} else {
		Write-Host "   - $($lang.UpdateServerTestFailed)" -ForegroundColor Red
		Write-Host "   ---------------------------------------------------"

		ImportModules
		If ($Force) {
			return
		} else {
			ToMainpage -wait 2
		}
	}

	Write-host "`n   $($lang.UpdateQueryingUpdate)"

	$error.Clear()
	$time = Measure-Command { Invoke-WebRequest -Uri $versionxmlloc -ErrorAction SilentlyContinue }

	if ($error.Count -eq 0) {
		Write-Host "`n   $($lang.UpdateQueryingTime -f $($time.TotalMilliseconds))"
	} else {
		Write-host "`n   $($lang.UpdateConnectFailed)"

		ImportModules
		If ($Force) {
			return
		} else {
			ToMainpage -wait 2
		}
	}

	$getSerVer = (Invoke-WebRequest -Uri $versionxmlloc -UseBasicParsing -Body $body -Method:Get -Headers $head -ContentType "application/xml" -TimeoutSec 15 -ErrorAction:stop)
	$chkRemovever = ([xml]$getSerVer.Content).versioninfo.version.minau
	$PPocess = "$PSScriptRoot\Post.Processing.bat"
	$PsPocess = "$PSScriptRoot\Post.Processing.ps1"

	If ([String]::IsNullOrEmpty($chkRemovever)) {
		$IsCorrectAuVer = $false
	} else {
		if ($Global:chkLocalver.Replace('.', '') -ge $chkRemovever.Replace('.', '')) {
			$IsCorrectAuVer = $true
		} else {
			$IsCorrectAuVer = $false
		}
	}

	if ($IsCorrectAuVer) {
		Write-Host "`n   $($lang.UpdateMinimumVersion -f $($Global:chkLocalver))"
		$IsUpdateAvailable = $false
		$url = ([xml]$getSerVer.Content).versioninfo.download.url
		$output = "$PSScriptRoot\..\..\..\latest.zip"

		if (([xml]$getSerVer.Content).versioninfo.version.version.Replace('.', '') -gt $Global:ProductVersion.Replace('.', '')) {
			$IsUpdateAvailable = $true
		} else {
			$IsUpdateAvailable = $false
		}

		if ($IsUpdateAvailable) {
			Write-host "`n   $($lang.UpdateVerifyAvailable)
   ---------------------------------------------------"

			Write-Host "   * $($lang.UpdateDownloadAddress)$($url)"
			if (TestURI $url) {
				Write-Host "   - $($lang.UpdateAvailable)" -ForegroundColor Green
				Write-Host "   ---------------------------------------------------"
			} else {
				Write-Host "   - $($lang.UpdateUnavailable)" -ForegroundColor Red
				Write-Host "   ---------------------------------------------------"
				ImportModules
				If ($Force) {
					return
				} else {
					ToMainpage -wait 2
				}
			}

			Write-host "`n   $($lang.UpdateCurrent)$($Global:ProductVersion)
   $($lang.UpdateLatest)$(([xml]$getSerVer.Content).versioninfo.version.version)

   $(([xml]$getSerVer.Content).versioninfo.changelog.title)
   $('-' * (([xml]$getSerVer.Content).versioninfo.changelog.title).Length)
$(([xml]$getSerVer.Content).versioninfo.changelog.'#text')"

			Write-host "   $($lang.UpdateNewLatest)`n" -ForegroundColor Green
			If ($Force) {
				$title = "   $($lang.UpdateForce)"
				$start_time = Get-Date
				remove-item -path $output -force -ErrorAction SilentlyContinue
				Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction SilentlyContinue
				Write-Host "`n   $($lang.UpdateTimeUsed)$((Get-Date).Subtract($start_time).Seconds) (s)"
			} else {
				$title = "$($lang.UpdateInstall)"
				$message = "$($lang.UpdateInstallSel)"
				$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
				$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
				$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
				$prompt=$host.ui.PromptForChoice($title, $message, $options, 0)
				Switch ($prompt)
				{
					0 {
						$start_time = Get-Date
						remove-item -path $output -force -ErrorAction SilentlyContinue
						Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction SilentlyContinue
						Write-Host "`n   $($lang.UpdateTimeUsed)$((Get-Date).Subtract($start_time).Seconds) (s)"
					}
					1 {
						Write-Host "`n   $($lang.UserCancel)"
						ImportModules
						ToMainpage -wait 2
					}
				}
			}

			if ((Test-Path $output -PathType Leaf)) {
				Write-Host "`n   $($lang.UpdateUnpacking)$output"
				Archive -filename $output -to "$PSScriptRoot\..\..\..\"
				ImportModules
				Write-Host "`n   * $($lang.UpdatePostProc)"
				if ($IsProcess) {
					Write-Host "   - $($lang.UpdateNotExecuted)" -ForegroundColor red
				} else {
					if ((Test-Path $PPocess -PathType Leaf)) {
						Start-Process -FilePath $PPocess -wait -WindowStyle Minimized
						remove-item -path $PPocess -force
						Write-Host "   - $($lang.Done)`n" -ForegroundColor Green
					} else {
						Write-Host "   - $($lang.UpdateNoPost)" -ForegroundColor red
					}
					if ((Test-Path $PsPocess -PathType Leaf)) {
						Start-Process powershell -ArgumentList "-file $($PsPocess)" -Wait -WindowStyle Minimized
						remove-item -path $PsPocess -force
						Write-Host "   - $($lang.Done)`n" -ForegroundColor Green
					} else {
						Write-Host "   - $($lang.UpdateNoPost)`n" -ForegroundColor red
					}
					ImportModules
					Write-host "`n   $($Global:UniqueID)'s Solutions $($lang.UpdateDone)`n"
				}
			} else {
				Write-host "`n   $($lang.UpdateUpdateStop)"
			}
			remove-item -path $output -force -ErrorAction SilentlyContinue
		} else {
			Write-host "   $($lang.UpdateNoUpdateAvailable -f $($Global:UniqueID))"
		}
	} else {
		Write-host "   $($lang.UpdateNotSatisfied -f $($Global:chkLocalver), $($Global:UniqueID))"
	}

	ImportModules
	If ($Force) {
		return
	} else {
		ToMainpage -wait 2
	}
}

<#
	.Unzip
	.解压缩
#>
Function Archive
{
	param
	(
		$filename,
		$to
	)

	Convert-Path $filename -ErrorAction SilentlyContinue | Out-Null

	if (Compressing) {
		Write-host "   - $($lang.UseZip -f $($Global:Zip))"
		$arguments = "x ""-r"" ""-tzip"" ""$filename"" ""-o$to"" ""-y""";
		Start-Process $Global:Zip "$arguments" -Wait -WindowStyle Minimized
	} else {
		Write-host "    - $($lang.UseOSZip)"
		Expand-Archive -LiteralPath $filename -DestinationPath $to -force
	}
}

<#
	.Get compression software
	.获取压缩软件
#>
Function Compressing
{
	if (Test-Path "$env:ProgramFiles\7-Zip\7z.exe") {
		$Global:Zip = "$env:ProgramFiles\7-Zip\7z.exe"
		return $true
	}

	if (Test-Path "$env:ProgramFiles(x86)\7-Zip\7z.exe") {
		$Global:Zip = "$env:ProgramFiles(x86)\7-Zip\7z.exe"
		return $true
	}

	if (Test-Path "$(GetArchitecturePacker -Path "$($Global:UniqueMainFolder)\Engine\AIO\7zPacker")\7z.exe") {
		$Global:Zip = "$(GetArchitecturePacker -Path "$($Global:UniqueMainFolder)\Engine\AIO\7zPacker")\7z.exe"
		return $true
	}
	return $false
}

<#
	.Processing: clean up packages by architecture
	.处理：按架构清理软件包
#>
Function ArchitecturePacker
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path "$Path\arm64" -PathType Container) {
				RemoveTree -Path "$Path\AMD64"
				RemoveTree -Path "$Path\x86"
			} else {
				if (Test-Path "$Path\AMD64" -PathType Container) {
					RemoveTree -Path "$Path\arm64"
					RemoveTree -Path "$Path\x86"
				} else {
					if (Test-Path "$Path\x86" -PathType Container) {
						RemoveTree -Path "$Path\arm64"
						RemoveTree -Path "$Path\AMD64"
					}
				}
			}
		}
		"AMD64" {
			if (Test-Path "$Path\AMD64" -PathType Container) {
				RemoveTree -Path "$Path\arm64"
				RemoveTree -Path "$Path\x86"
			} else {
				if (Test-Path "$Path\x86" -PathType Container) {
					RemoveTree -Path "$Path\arm64"
					RemoveTree -Path "$Path\AMD64"
				}
			}
		}
		"x86" {
			RemoveTree -Path "$Path\arm64"
			RemoveTree -Path "$Path\AMD64"
		}
	}
}

<#
	.Clean up the interface
	.清理接口
#>
Function GetArchitecturePacker
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path "$Path\arm64" -PathType Container) {
				return "$Path\arm64"
			} else {
				if (Test-Path "$Path\AMD64" -PathType Container) {
					return "$Path\AMD64"
				} else {
					if (Test-Path "$Path\x86" -PathType Container) {
						return "$Path\x86"
					} else {
						return $Path
					}
				}
			}
		}
		"AMD64" {
			if (Test-Path "$Path\AMD64" -PathType Container) {
				return "$Path\AMD64"
			} else {
				if (Test-Path "$Path\x86" -PathType Container) {
					return "$Path\x86"
				} else {
					return $Path
				}
			}
		}
		"x86" {
			if (Test-Path "$Path\x86" -PathType Container) {
				return "$Path\x86"
			} else {
				return $Path
			}
		}
	}
}

<#
	.Test if the URL address is available
	.测试 URL 地址是否可用
#>
Function TestURI
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

Export-ModuleMember -Variable "$($Global:ProductVersion)"
Export-ModuleMember -Variable "$($Global:chkLocalver)"
Export-ModuleMember -Function "Update"
Export-ModuleMember -Function "ArchitecturePacker"
Export-ModuleMember -Function "Archive"
Export-ModuleMember -Function "Compressing"
Export-ModuleMember -Function "GetArchitecturePacker"
Export-ModuleMember -Function "TestURI"