Function inBox_Apps_Menu
{
	Logo -Title $lang.InboxAppsManager
	Write-Host "   $($lang.Dashboard)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "   $($lang.MountImageTo) " -NoNewline
	if (Test-Path $Global:Mount_To_Route -PathType Container) {
		Write-Host $Global:Mount_To_Route -ForegroundColor Green
	} else {
		Write-Host $Global:Mount_To_Route -ForegroundColor Yellow
	}

	Write-Host "   $($lang.MainImageFolder) " -NoNewline
	if (Test-Path $Global:Image_source -PathType Container) {
		Write-Host $Global:Image_source -ForegroundColor Green
	} else {
		Write-Host $Global:Image_source -ForegroundColor Red
		Write-host "   $('-' * 80)"
		Write-Host "   $($lang.NoInstallImage)" -ForegroundColor Red

		ToWait -wait 2
		inBox_Apps_Menu
	}

	Image_Get_Mount_Status

	<#
		.先决条件
	#>
	<#
		.判断是否选择 Install, Boot, WinRE
	#>
	if (-not (Image_Is_Select_IAB)) {
		Write-Host "`n   $($lang.InboxAppsManager)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
		return
	}

	<#
		.判断挂载合法性
	#>
	if (-not (Verify_Is_Current_Same)) {
		Write-Host "`n   $($lang.InboxAppsManager)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
			Write-Host "   $($lang.MountedIndexError)" -ForegroundColor Red
		} else {
			Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
			Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
		}

		return
	}

	<#
		.仅支持 Install 时
	#>
	if (-not (Image_Is_Select_Install)) {
		Write-Host "`n   $($lang.InboxAppsManager)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-Host "   $($lang.BootProcess -f "install")" -ForegroundColor Red
		return
	}

	Write-Host "`n   $($lang.Menu)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if (Verify_Is_Current_Same) {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.StepOne -ForegroundColor Green
	} else {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.StepOne -ForegroundColor Red
	}

	if (Verify_Is_Current_Same) {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.StepTwo)$($lang.AddTo)" -ForegroundColor Green
	} else {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.StepTwo)$($lang.AddTo)" -ForegroundColor Red
	}

	if (Verify_Is_Current_Same) {
		Write-Host "      3   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.LocalExperiencePackTips): $($lang.Update)" -ForegroundColor Green
	} else {
		Write-Host "      3   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.LocalExperiencePackTips): $($lang.Update)" -ForegroundColor Red
	}

	if (Verify_Is_Current_Same) {
		Write-Host "      4   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.LocalExperiencePackTips): $($lang.Del)" -ForegroundColor Green
	} else {
		Write-Host "      4   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.LocalExperiencePackTips): $($lang.Del)" -ForegroundColor Red
	}

	Write-Host "`n      $($lang.InboxAppsManager)" -ForegroundColor Yellow
	Write-host "      $('-' * 77)"
	if (Verify_Is_Current_Same) {
		Write-Host "         O   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.InboxAppsOfflineDel -ForegroundColor Green
	} else {
		Write-Host "         O   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.InboxAppsOfflineDel -ForegroundColor Red
	}

	if (Verify_Is_Current_Same) {
		Write-Host "         F   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.InboxAppsClear -ForegroundColor Green
	} else {
		Write-Host "         F   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.InboxAppsClear -ForegroundColor Red
	}

	Write-Host "`n`n   $($lang.GetImageUWP)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      P   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.ExportToLogs -ForegroundColor Green
		} else {
			Write-host $lang.ExportToLogs -ForegroundColor Red
		}
	} else {
		Write-host $lang.ExportToLogs -ForegroundColor Red
	}

	Write-Host "      S   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.ExportShow -ForegroundColor Green
		} else {
			Write-host $lang.ExportShow -ForegroundColor Red
		}
	} else {
		Write-host $lang.ExportShow -ForegroundColor Red
	}

	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value

			Write-host "`n          $($lang.SaveTo)" -ForegroundColor Yellow
			Write-host "          $('-' * 73)"
			Write-host "     SS   " -NoNewline -ForegroundColor Yellow
			Write-host $Temp_Expand_Rule -ForegroundColor Green
		}
	}

	if (Verify_Is_Current_Same) {
		Write-Host "`n      A   $($lang.OnDemandPlanTask)" -ForegroundColor Green
	} else {
		Write-Host "`n      A   $($lang.OnDemandPlanTask)" -ForegroundColor Red
	}

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'1' {
			Write-Host "`n   $($lang.StepOne)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Mark_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'2' {
			Write-Host "`n   $($lang.StepTwo)$($lang.AddTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Add_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'3' {
			Write-Host "`n   $($lang.LocalExperiencePackTips): $($lang.Update)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Update_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'4' {
			Write-Host "`n   $($lang.LocalExperiencePackTips): $($lang.Del)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Remove_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'a' {
			Write-Host "`n   $($lang.User_Interaction): $($lang.OnDemandPlanTask)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
						.Assign available tasks
						.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Mark_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'o' {
			Write-Host "`n   $($lang.InboxAppsOfflineDel)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "InBox_Apps_Offline_Delete_UI" -Run
				Get_Next
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}
	
			ToWait -wait 2
			inBox_Apps_Menu
		}
		'f' {
			InBox_Apps_LIPs_Clean_Process
			ToWait -wait 2
			inBox_Apps_Menu
		}
		'p' {
			Write-Host "`n   $($lang.GetImageUWP)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Apps_Package -Save $Temp_Export_SaveTo
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		's' {
			Write-Host "`n   $($lang.GetImageUWP)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportShow)"

			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Apps_Package -Save $Temp_Export_SaveTo -View
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		'ss' {
			Write-Host "`n   $($lang.Setting): $($lang.SaveTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green

					Setting_Export_To_UI
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			inBox_Apps_Menu
		}
		default {
			Mainpage
		}
	}
}