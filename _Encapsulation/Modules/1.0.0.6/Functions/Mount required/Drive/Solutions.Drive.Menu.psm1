<#
	.Drive management
	.驱动管理
#>
Function Drive_Menu
{
	Logo -Title $lang.Drive
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
		Drive_Menu
	}

	Image_Get_Mount_Status

	Write-Host "`n   $($lang.Drive)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "      1   " -NoNewline -ForegroundColor Yellow
			Write-host $lang.AddTo -ForegroundColor Green
		} else {
			Write-Host "      1   " -NoNewline -ForegroundColor Yellow
			Write-host $lang.AddTo -ForegroundColor Red
		}
	} else {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.AddTo -ForegroundColor Red
	}

	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "      2   " -NoNewline -ForegroundColor Yellow
			Write-host $lang.Del -ForegroundColor Green
		} else {
			Write-Host "      2   " -NoNewline -ForegroundColor Yellow
			Write-host $lang.Del -ForegroundColor Red
		}
	} else {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Del -ForegroundColor Red
	}

	Write-Host "`n   $($lang.ViewDrive)" -ForegroundColor Yellow
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
					Event_Assign -Rule "Drive_Add_UI" -Run
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Drive_Menu
		}
		'2' {
			Write-Host "`n   $($lang.Update): $($lang.Del)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					Event_Assign -Rule "Drive_Delete_UI" -Run
				} else {
					Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"	
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Drive_Menu
		}
		'p' {
			Write-Host "`n   $($lang.ViewDrive)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report" -ErrorAction SilentlyContinue
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Installed_Drive -Save $Temp_Export_SaveTo
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Drive_Menu
		}
		's' {
			Write-Host "`n   $($lang.ViewDrive)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report" -ErrorAction SilentlyContinue
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Installed_Drive -Save $Temp_Export_SaveTo -View
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Drive_Menu
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
			Drive_Menu
		}
		default { Mainpage }
	}
}