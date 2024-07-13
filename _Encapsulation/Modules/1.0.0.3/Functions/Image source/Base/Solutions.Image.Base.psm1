﻿<#
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
	.Mount check
	.挂载检查
#>
Function Image_Mount_Check
{
	param
	(
		$MountFileName,
		$Index
	)

	Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
	if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		Write-Host "   $($lang.Mounted)"
	} else {
		Write-Host "   $($lang.NotMounted)"
		if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
			<#
				.强行卸载，不保存
				.Forcibly uninstall, do not save
			#>
			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)80" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Dismount-WindowsImage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -Discard" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -Discard -ErrorAction SilentlyContinue | Out-Null
			Image_Mount_Force_Del -NewPath "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"
			Write-Host "   $($lang.Done)" -ForegroundColor Green
		}
		Check_Folder -chkpath "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"

		if (Test-Path $MountFileName -PathType Leaf) {
			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)81" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Mount-WindowsImage -ImagePath ""$($MountFileName)"" -Index ""$($Index)"" -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount""" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Write-Host "   $($lang.Mount)".PadRight(28) -NoNewline
			try {
				Mount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Mount.log" -ImagePath "$($MountFileName)" -Index $Index -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | Out-Null
				Write-Host $lang.Done -ForegroundColor Green
			} catch {
				Write-Host $lang.SelectFromError -ForegroundColor Red
				Write-Host "   $($_)" -ForegroundColor Yellow
			}
		} else {
			Write-Host "   $($lang.NoInstallImage)"
			Write-host "   $($MountFileName)" -ForegroundColor Red
		}
	}
}

<#
	.Forcibly clean up mounted
	.强行清理已挂载
#>
Function Image_Mount_Force_Del
{
	param
	(
		$NewPath
	)

	<#
		.再次判断是否存在挂载目录，解决无法卸载问题
		.Determine whether there is a mount directory again, and solve the problem of not being able to unmount
	#>
	if (Test-Path $NewPath -PathType Container) {
		<#
			.For the first time, to clean up the directory task, use the system's own command to clean up the directory instead of using the delete command
			.第一次，清理目录任务，使用系统自带命令清理目录，而不是使用删除命令
		#>
		dism /cleanup-wim | Out-Null
		Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null

		if (Test-Path $NewPath -PathType Container) {
			If ($Null -eq (Get-ChildItem -Force "$($NewPath)")) {
				Remove-Item $NewPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
			} else {
				dism /cleanup-wim | Out-Null
				Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null
			}
		}

		<#
			.After cleaning, judge whether the cleaning is successful, if it is found that the cleaning is not completed, repair command
			.清理后，判断是否清理成功，如果发现到未清理完成，执行修复命令
		#>
		if (Test-Path $NewPath -PathType Container) {
			If ($Null -eq (Get-ChildItem -Force $NewPath)) {
				Dism /cleanup-wim | Out-Null
				Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null
				TakeownFolder -path $NewPath
				Remove-Item $NewPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
			} else {
				<#
					.The second time, remount
					.第二次，重新挂载
				#>
				dism /cleanup-wim | Out-Null
				Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null
				dism /Unmount-Wim /Mountdir:"""$($NewPath)""" /Discard | Out-Null
	
				if (Test-Path $NewPath -PathType Container) {
					dism /cleanup-wim | Out-Null
					Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null

					dism /Online /Cleanup-Image /RestoreHealth /Source:"""$($NewPath)""" /LimitAccess | Out-Null
					dism /Unmount-Wim /Mountdir:"""$($NewPath)""" /Discard | Out-Null
					dism /Unmount-Image /MountDir:"""$($NewPath)""" /discard | Out-Null
				}
			}
		}
		
		<#
			.For the third time, if it fails, delete it forcibly.
			.第三次，不行就强行删除。
		#>
		if (Test-Path $NewPath -PathType Container) {
			If ($Null -eq (Get-ChildItem -Force $NewPath)) {
				Dism /cleanup-wim | Out-Null
				Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null
				TakeownFolder -path $NewPath
				Remove-Item $NewPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
			} else {
				Dism /cleanup-wim | Out-Null
				Clear-WindowsCorruptMountPoint -LogPath "$(Get_Mount_To_Logs)\Clear.log" -ErrorAction SilentlyContinue | Out-Null
				Dism /ScratchDir:"""$(Get_Mount_To_Temp)""" /LogPath:"$(Get_Mount_To_Logs)\Clear.log" /Unmount-Image /MountDir:"""$($NewPath)""" /discard

				if (Test-Path $NewPath -PathType Container) {
					Remove_Tree $NewPath
				}
			}
		}
		
		<#
			.For the fourth time, four but three, it went on strike.
			.第四次，四不过三，罢工了。
		#>
		if (Test-Path $NewPath -PathType Container) {
			If ($Null -eq (Get-ChildItem -Force $NewPath)) {
				TakeownFolder -path $NewPath
				Remove-Item $NewPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
			} else {
				Write-Host "`n   $($lang.UnmountFailed)" -ForegroundColor Red
				start-process "timeout.exe" -argumentlist "/t 6 /nobreak" -wait -nonewwindow
			}
		}
	}
}

<#
	.Read the image source mount status from the system
	.从系统里读取映像源挂载状态
#>
Function Image_Get_Mount_Status
{
	param
	(
		[switch]$Silent
	)

	ForEach ($item in $Global:Image_Rule) {
		if ($item.Main.Suffix -eq "wim") {
			Image_Get_Mount_Status_New -ImageMaster $item.Main.ImageFileName -ImageName $item.Main.ImageFileName -ImageFile "$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)" -Silent $Silent

			if ($item.Expand.Count -gt 0) {
				ForEach ($Expand in $item.Expand) {
					Image_Get_Mount_Status_New -ImageMaster $item.Main.ImageFileName -ImageName $Expand.ImageFileName -ImageFile "$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)" -Silent $Silent
				}
			}
		}
	}
}

Function Image_Get_Mount_Status_New
{
	param
	(
		$ImageMaster,
		$ImageName,
		$ImageFile,
		$Silent
	)

	<#
		.标记：全局：匹配的是否已挂载
	#>
	New-Variable -Scope global -Name "Mark_Is_Mount_$($ImageMaster)_$($ImageName)" -Value $False -Force
 
	<#
		.标记：判断是否合法
	#>
	New-Variable -Name "Mark_Is_Legal_Sources_$($ImageMaster)_$($ImageName)" -Value $False -Force

	<#
		.判断 ISO 主要来源是否存在文件
	#>
	if (Test-Path $ImageFile -PathType leaf -ErrorAction SilentlyContinue) {
		if ($Silent) {
		} else {
			<#
				.自动选择主键
			#>
			if ($Global:Primary_Key_Image.ImageFileName -eq $ImageName) {
				Write-Host "   [*]" -NoNewline -ForegroundColor Green
			} else {
				Write-Host "      " -NoNewline
			}

			Write-Host " $($ImageName)".PadRight(8) -NoNewline -ForegroundColor Yellow
		}

		<#
			.Get all mounted images from the current system that match the current one
			.从当前系统里获取所有已挂载镜像与当前匹配
		#>
		$MarkErrorMounted = $False
		try {
			<#
				.标记是否捕捉到事件
			#>
			Get-WindowsImage -Mounted -ErrorAction SilentlyContinue | ForEach-Object {
				<#
					.判断文件路径与当前是否一致
				#>
				if ($_.ImagePath -eq $ImageFile) {
					$ImageIndexNew = $_.ImageIndex

					switch ($_.MountStatus) {
						"Invalid" {
							$MarkErrorMounted = $True
							New-Variable -Scope global -Name "Mark_Is_Mount_$($ImageMaster)_$($ImageName)" -Value $True -Force

							if (-not $Silent) {
								Write-Host "   $($lang.MountedIndex): $($ImageName)" -NoNewline -ForegroundColor Yellow

								if (Test-Path -Path "$($Global:Mount_To_Route)\$($ImageMaster)\$($ImageName)\Mount" -PathType Container) {
									if((Get-ChildItem "$($Global:Mount_To_Route)\$($ImageMaster)\$($ImageName)\Mount" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
										Write-Host "    $($lang.MountedIndexError)" -ForegroundColor Red
									} else {
										Write-Host "    $($lang.NotMounted)" -ForegroundColor Red
									}
								} else {
									Write-Host "    $($lang.NotMounted)" -ForegroundColor Red
								}
							}
						}
						"NeedsRemount" {
							$MarkErrorMounted = $True
							New-Variable -Scope global -Name "Mark_Is_Mount_$($ImageMaster)_$($ImageName)" -Value $True -Force

							if (-not $Silent) {
								Write-Host "   $($lang.MountedIndex): $($ImageName)" -NoNewline -ForegroundColor Yellow

								if (Test-Path -Path "$($Global:Mount_To_Route)\$($ImageMaster)\$($ImageName)\Mount" -PathType Container) {
									if((Get-ChildItem "$($Global:Mount_To_Route)\$($ImageMaster)\$($ImageName)\Mount" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
										Write-Host "    $($lang.MountedIndexError)" -ForegroundColor Red
									} else {
										Write-Host "    $($lang.NotMounted)" -ForegroundColor Red
									}
								} else {
									Write-Host "    $($lang.NotMounted)" -ForegroundColor Red
								}
							}
						}
						"Ok" {
							$MarkErrorMounted = $True
							New-Variable -Name "Mark_Is_Legal_Sources_$($ImageMaster)_$($ImageName)" -Value $True -Force
							New-Variable -Scope global -Name "Mark_Is_Mount_$($ImageMaster)_$($ImageName)" -Value $True -Force

							if (-not $Silent) {
								Write-Host "   $($lang.MountedIndex): $($ImageIndexNew)" -NoNewline -ForegroundColor Yellow

								if (Test-Path -Path "$($Global:Mount_To_Route)\$($ImageMaster)\$($ImageName)\Mount" -PathType Container) {
									Write-Host "    $($lang.MountedIndexSuccess)" -ForegroundColor Green
								} else {
									Write-Host "    $($lang.NotMounted)" -ForegroundColor Red
								}
							}
						}
						Default {
							$MarkErrorMounted = $True
							New-Variable -Scope global -Name "Mark_Is_Mount_$($ImageMaster)_$($ImageName)" -Value $True -Force

							if (-not $Silent) {
								Write-Host "   $($lang.MountedIndexError)" -ForegroundColor Red
							}
						}
					}
				}
			}
		} catch {
			if (-not $Silent) {
				Write-Host "   $($lang.MountedIndexError)" -ForegroundColor Green
			}
		}

		if ($MarkErrorMounted) {

		} else {
			if (-not $Silent) {
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}
		}
	}
}

<#
	.获取当前是否已挂载后，返回索引号
#>
Function Image_Get_Mount_Index
{
	$MarkErrorMounted = $False
	$Index = ""

	<#
		.判断 ISO 主要来源是否存在文件
	#>
	if (Test-Path $Global:Primary_Key_Image.FullPath -PathType leaf -ErrorAction SilentlyContinue) {
		<#
			.Get all mounted images from the current system that match the current one
			.从当前系统里获取所有已挂载镜像与当前匹配
		#>
		Get-WindowsImage -Mounted -ErrorAction SilentlyContinue | ForEach-Object {
			<#
				.判断文件路径与当前是否一致
			#>
			if ($_.ImagePath -eq $Global:Primary_Key_Image.FullPath) {
				$MarkErrorMounted = $True
				$Index = $_.ImageIndex
			}
		}
	}

	if ($MarkErrorMounted) {
		return $Index
	} else {
		return "Not"
	}
}

function Get_Mount_To_Logs
{
	$Temp_New_Temp_Path = "$($Global:LogsSaveFolder)\$($Global:LogSaveTo)"

	if (Test_Available_Disk -Path $Temp_New_Temp_Path) {
		Check_Folder -chkpath $Temp_New_Temp_Path

		return $Temp_New_Temp_Path
	}

	$Local_Temp_Main_Path = "$($env:userprofile)\AppData\Local\Temp\Logs"
	Check_Folder -chkpath $Local_Temp_Main_Path
	return $Local_Temp_Main_Path
}

function Get_Mount_To_Temp
{
	$RandomGuid = [guid]::NewGuid()
	$Temp_New_Temp_Path = "$($Global:Mount_To_RouteTemp)\$($RandomGuid)"

	if (Test_Available_Disk -Path $Temp_New_Temp_Path) {
		Check_Folder -chkpath $Temp_New_Temp_Path

		return $Temp_New_Temp_Path
	}

	$Local_Temp_Main_Path = "$($env:userprofile)\AppData\Local\Temp\$($RandomGuid)"
	Check_Folder -chkpath $Local_Temp_Main_Path
	return $Local_Temp_Main_Path
}

function Get-RandomHexNumber
{
	param
	( 
		[int]$length = 20,
		[string]$chars = "0123456789"
	)

	$bytes = new-object "System.Byte[]" $length
	$rnd = new-object System.Security.Cryptography.RNGCryptoServiceProvider
	$rnd.GetBytes($bytes)
	$result = ""

	1..$length | ForEach-Object {
		$result += $chars[ $bytes[$_] % $chars.Length ]	
	}

	return $result
}