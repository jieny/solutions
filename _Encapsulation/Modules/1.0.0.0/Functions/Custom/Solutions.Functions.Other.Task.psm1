<#
	.用户自定义函数起始
#>

<#
	.空任务
#>
Function Other_Tasks_Empty
{
	
}

<#
	.清理解决方案 Yi 目录
#>
Function Other_Tasks_Delete_Folder_Yi
{
	Write-Host "   Other_Tasks_Delete_Folder_Yi" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	$Local_Regedit_File_System = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Yi"
	Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Green
	Write-host "   $($lang.Del)".PadRight(28) -NoNewline
	if (Test-Path $Local_Regedit_File_System -PathType Container) {
		Remove_Tree -Path $Local_Regedit_File_System

		if (Test-Path $Local_Regedit_File_System -PathType Container) {
			Write-Host "$($lang.Del), $($lang.Failed)" -ForegroundColor Red
		} else {
			Write-Host $lang.Done -ForegroundColor Green
		}
	} else {
		Write-Host $lang.NoInstallImage -ForegroundColor Red
	}
}

<#
	.添加测试目录
#>
Function Other_Tasks_Add_Test_Folder
{
	Write-Host "   Other_Tasks_Add_Test_Folder" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	$RandomGuid = [guid]::NewGuid()
	$Local_Regedit_File_System = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\$($RandomGuid)"

	Check_Folder -chkpath $Local_Regedit_File_System
	Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Green

	Write-Host "   $($lang.Done)" -ForegroundColor Green
}

<#
	.Other tasks, global search Function, search condition: Other_Tasks_*, please refer to Dev.Log.xlsx for calling parameters
	.其它任务，全局搜索 Function，搜索条件：Other_Tasks_*，需要调用参数请参阅 Dev.Log.xlsx
#>
<#
	.TPM 2.0 检查
#>
Function Other_Tasks_TPM
{
	Write-Host "   Other_Tasks_TPM" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "   $($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"
	if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		$Local_Regedit_File_System = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows\System32\Config\SYSTEM"

		Write-Host "`n   $($lang.SelFile)"
		Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Green
		if (Test-Path -Path $Local_Regedit_File_System -PathType Leaf) {
			$RandomGuid = [guid]::NewGuid()

			Write-Host "`n   $($lang.Select_Path)"
			Write-Host "   HKLM:\$($RandomGuid)"

			New-PSDrive -PSProvider Registry -Name OtherTasksTPM -Root HKLM -ErrorAction SilentlyContinue | Out-Null

			Start-Process reg -ArgumentList "Load ""HKLM\$($RandomGuid)"" ""$($Local_Regedit_File_System)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue

			if (Test-Path -Path "HKLM:\$($RandomGuid)" -PathType Container) {
				if((Test-Path -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig") -ne $true) {
					New-Item "HKLM:\$($RandomGuid)\Setup\LabConfig" -force -ea SilentlyContinue | Out-Null
				}

				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig" -Name "BypassCPUCheck" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig" -Name "BypassStorageCheck" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig" -Name "BypassRAMCheck" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig" -Name "BypassTPMCheck" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\Setup\LabConfig" -Name "BypassSecureBootCheck" -Value 1 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null

				[gc]::collect()

				Start-Process reg -ArgumentList "unload ""HKLM\$($RandomGuid)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue

				if (Test-Path -Path "HKLM:\$($RandomGuid)" -PathType Container) {
					for ($i = 0; $i -lt 5; $i++) {
						Start-Process reg -ArgumentList "unload ""HKLM\$($RandomGuid)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
						Start-Sleep -Seconds 5
					}
				}

				Remove-PSDrive -Name OtherTasksTPM
				Write-Host "   $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   $($lang.AddTo), $($lang.Failed)`n" -ForegroundColor Red
			}
		} else {
			Write-Host "`n   $($lang.NoInstallImage)"
			Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Red
		}
	} else {
		Write-host "`n   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
	}
}

<#
	.修改 boot.wim 支持安装于 REFS 分区
#>
Function Other_Tasks_REFS
{
	Write-Host "   Other_Tasks_REFS" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "   $($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"
	if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		$Local_Regedit_File_System = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows\System32\Config\SYSTEM"

		Write-Host "`n   $($lang.SelFile)"
		Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Green
		if (Test-Path -Path $Local_Regedit_File_System -PathType Leaf) {
			$RandomGuid = [guid]::NewGuid()

			Write-Host "`n   $($lang.Select_Path)"
			Write-Host "   HKLM:\$($RandomGuid)"

			New-PSDrive -PSProvider Registry -Name OtherTasksREFS -Root HKLM -ErrorAction SilentlyContinue | Out-Null

			Start-Process reg -ArgumentList "Load ""HKLM\$($RandomGuid)"" ""$($Local_Regedit_File_System)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue

			if (Test-Path -Path "HKLM:\$($RandomGuid)" -PathType Container) {
				if((Test-Path -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748") -ne $true) {
					New-Item "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -force -ea SilentlyContinue | Out-Null
				}

				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -Name 'EnabledState' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -Name 'EnabledStateOptions' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -Name 'Variant' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -Name 'VariantPayload' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null
				New-ItemProperty -LiteralPath "HKLM:\$($RandomGuid)\ControlSet001\Control\FeatureManagement\Overrides\8\3689412748" -Name 'VariantPayloadKind' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue | Out-Null

				[gc]::collect()

				Start-Process reg -ArgumentList "unload ""HKLM\$($RandomGuid)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue

				if (Test-Path -Path "HKLM:\$($RandomGuid)" -PathType Container) {
					for ($i = 0; $i -lt 5; $i++) {
						Start-Process reg -ArgumentList "unload ""HKLM\$($RandomGuid)""" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
						Start-Sleep -Seconds 5
					}
				}

				Remove-PSDrive -Name OtherTasksREFS
				Write-Host "   $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   $($lang.AddTo), $($lang.Failed)`n" -ForegroundColor Red
			}
		} else {
			Write-Host "`n   $($lang.NoInstallImage)"
			Write-host "   $($Local_Regedit_File_System)" -ForegroundColor Red
		}
	} else {
		Write-host "`n   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
	}
}

<#
	.强行格式化盘符：卷标名
#>
Function Other_Tasks_Format_Disk_Volume_Name_RAMDISK
{
	Write-Host "   Other_Tasks_Format_Disk_Volume_Name_RAMDISK" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	<#
		.获取 RAMDISK 卷标名
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "RAMDisk_Volume_Label" -ErrorAction SilentlyContinue) {
		$GetRegRAMDISKVolumeLabel = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "RAMDisk_Volume_Label" -ErrorAction SilentlyContinue

		Get-CimInstance -Class Win32_LogicalDisk -ErrorAction SilentlyContinue | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | ForEach-Object {
			if ($_.VolumeName -eq $GetRegRAMDISKVolumeLabel) {
				$SearchNewLicense = $_.DeviceID.Replace(":", "")
				Write-host "   $($lang.MatchMode): $($SearchNewLicense) ( $($_.VolumeName) )"

		 		Format-Volume -DriveLetter $SearchNewLicense -NewFileSystemLabel $GetRegRAMDISKVolumeLabel
				Write-Host "   $($lang.Done)" -ForegroundColor Green
			}
		}
	} else {
		Write-Host "   $($lang.UpdateUnavailable)" -ForegroundColor Red
	}
}

<#
	.完成后暂停
#>
Function Other_Tasks_Pause
{
	Write-Host "   Other_Tasks_Pause" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Get_Next
	Write-Host "   $($lang.Done)" -ForegroundColor Green
}