<#
	.Open the functional user interface
	.开启功能用户界面
#>
Function Feature_Menu
{
	Write-Host "`n   $($lang.WindowsFeature)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	if (Verify_Is_Current_Same) {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Enable -ForegroundColor Green
	} else {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Enable -ForegroundColor Red
	}

	if (Verify_Is_Current_Same) {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Disable -ForegroundColor Green
	} else {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Disable -ForegroundColor Red
	}

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'1' {
			Write-Host "`n   $($lang.WindowsFeature): $($lang.Enable)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Feature_Enabled_UI" -Run
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Feature_Menu
		}
		'2' {
			Write-Host "`n   $($lang.WindowsFeature): $($lang.Disable)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Feature_Disable_UI" -Run
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Feature_Menu
		}
		default {
			Mainpage
		}
	}
}