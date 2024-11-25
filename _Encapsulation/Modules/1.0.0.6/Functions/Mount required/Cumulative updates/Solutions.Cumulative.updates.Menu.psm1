<#
	.Update management
	.更新管理
#>
Function Update_Menu
{
	Logo -Title $lang.CUpdate
	Write-Host "   $($lang.Dashboard)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "   $($lang.MountImageTo): " -NoNewline
	if (Test-Path -Path $Global:Mount_To_Route -PathType Container) {
		Write-Host $Global:Mount_To_Route -ForegroundColor Green
	} else {
		Write-Host $Global:Mount_To_Route -ForegroundColor Yellow
	}

	Write-Host "   $($lang.MainImageFolder): " -NoNewline
	if (Test-Path -Path $Global:Image_source -PathType Container) {
		Write-Host $Global:Image_source -ForegroundColor Green
	} else {
		Write-Host $Global:Image_source -ForegroundColor Red
		Write-host "   $('-' * 80)"
		Write-Host "   $($lang.NoInstallImage)" -ForegroundColor Red

		ToWait -wait 2
		Update_Menu
	}

	Image_Get_Mount_Status

	Write-Host "`n   $($lang.CUpdate)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      1   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.AddTo -ForegroundColor Green
		} else{
			Write-host $lang.AddTo -ForegroundColor Red
		}
	} else {
		Write-host $lang.AddTo -ForegroundColor Red
	}

	Write-Host "      2   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.Del -ForegroundColor Green
		} else {
			Write-host $lang.Del -ForegroundColor Red
		}
	} else {
		Write-host $lang.Del -ForegroundColor Red
	}

	Write-Host "`n   $($lang.MoreFeature)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      3   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.CuringUpdate -ForegroundColor Green
		} else {
			Write-host $lang.CuringUpdate -ForegroundColor Red
		}
	} else {
		Write-host $lang.CuringUpdate -ForegroundColor Red
	}
	Write-host "          $('-' * 73)"

	Write-Host "          31   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.Superseded -ForegroundColor Green
		} else {
			Write-host $lang.Superseded -ForegroundColor Red
		}
	} else {
		Write-host $lang.Superseded -ForegroundColor Red
	}

	Write-Host "          32   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host "$($lang.Superseded), $($lang.ExcludeItem)" -ForegroundColor Green
		} else {
			Write-host "$($lang.Superseded), $($lang.ExcludeItem)" -ForegroundColor Red
		}
	} else {
		Write-host "$($lang.Superseded), $($lang.ExcludeItem)" -ForegroundColor Red
	}

	Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
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

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'1' {
			Write-Host "`n   $($lang.Update): $($lang.AddTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Update_Add_UI" -Run
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'2' {
			Write-Host "`n   $($lang.Update): $($lang.Del)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Update_Delete_UI" -Run
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'3' {
			Write-Host "`n   $($lang.CuringUpdate)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					Event_Process_Task_Need_Mount
					New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

					Get_Next
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'31' {
			Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					Image_Clear_Superseded
					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

					Get_Next
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'32' {
			Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					Image_Clear_Superseded
					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
					New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

					Get_Next
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'p' {
			Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
					if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
						$Temp_Export_SaveTo = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report" -ErrorAction SilentlyContinue
					} else {
						$Temp_Export_SaveTo = $Temp_Expand_Rule
					}

					Image_Get_Components_Package -Save $Temp_Export_SaveTo
					Get_Next
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		's' {
			Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
					if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
						$Temp_Export_SaveTo = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report" -ErrorAction SilentlyContinue
					} else {
						$Temp_Export_SaveTo = $Temp_Expand_Rule
					}

					Image_Get_Components_Package -Save $Temp_Export_SaveTo -View
					Get_Next
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		'ss' {
			Write-Host "`n   $($lang.Setting): $($lang.SaveTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green

					Setting_Export_To_UI
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Update_Menu
		}
		default {
			Mainpage
		}
	}
}