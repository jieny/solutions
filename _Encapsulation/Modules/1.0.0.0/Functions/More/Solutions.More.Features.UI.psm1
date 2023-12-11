<#
	.Select other task user interface
	.选择其它任务用户界面
#>
Function Feature_More_UI_Menu
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $($lang.MoreFeature)
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
			Functions_Assign
		}

		Image_Get_Mount_Status
	}


	<#
		.Assign available tasks
		.分配可用的任务
	#>
	Event_Assign -Rule "Feature_More_UI" -Run
}

Function Feature_More_UI
{
	Write-Host "`n   $($lang.MoreFeature)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	$SearchFolderRule = @(
		"$($Global:Image_source)\History\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
		"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
		"$($Global:Image_source)_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
	)
	$SearchFolderRule = $SearchFolderRule | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	<#
		.事件：强行结束按需任务
	#>
	$UI_Main_Suggestion_Stop_Click = {
		$UI_Main.Hide()
		Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
		Event_Reset_Variable
		$UI_Main.Close()
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 928
		Text           = $lang.MoreFeature
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 625
		Width          = 555
		Padding        = "25,15,0,0"
		BorderStyle    = 0
		autoSizeMode   = 0
		Dock           = 3
		autoScroll     = $true
	}
	$UI_Main_Rule      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
	}

	<#
		.固化更新
	#>
	$UI_Main_Curing_Update = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Text           = $lang.CuringUpdate
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Curing_Update_Tips = New-Object system.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Margin         = "18,0,0,0"
		Text           = $lang.CuringUpdateTips
	}

	<#
		.清理取代的
	#>
	$UI_Main_Superseded_Rule = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Margin         = "18,20,0,0"
		Text           = $lang.Superseded
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Superseded_Rule_Tips = New-Object system.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Margin         = "36,0,0,10"
		Text           = $lang.SupersededTips
	}
	$UI_Main_Superseded_Rule_Exclude = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Padding        = "32,0,0,0"
		Text           = $lang.ExcludeItem
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Superseded_Rule_View_Detailed = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 450
		Padding        = "48,0,0,0"
		Text           = $lang.Exclude_View
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			$UI_Main_View_Detailed.Visible = $True
			$UI_Main_View_Detailed_Show.Text = ""

			$UI_Main_View_Detailed_Show.Text += "   $($lang.ExcludeItem)`n"
			ForEach ($item in $Global:ExcludeClearSuperseded) {
				$UI_Main_View_Detailed_Show.Text += "       $($item)`n"
			}
		}
	}

	<#
		.健康
	#>
	$UI_Main_Healthy   = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.Healthy
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Healthy_Tips = New-Object system.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Margin         = "18,0,0,0"
		Text           = $lang.HealthyTips
	}

	<#
		.打印报告到日志里
	#>
	$UI_Main_UWP_Name  = New-Object system.Windows.Forms.Label -Property @{
		Height         = 35
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.GetImageUWP
	}
	$UI_Main_UWP_To_Log = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportToLogs
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_UWP_To_View = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportShow
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	$UI_Main_Package_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.GetImagePackage
	}
	$UI_Main_Package_To_Log = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportToLogs
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Package_To_View = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportShow
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	<#
		.驱动
	#>
	$UI_Main_Drive_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.ViewDrive
	}
	$UI_Main_Drive_To_Log = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportToLogs
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Drive_To_View = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportShow
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	$UI_Main_Language_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.ImageLanguage
	}
	$UI_Main_Language  = New-Object System.Windows.Forms.CheckBox -Property @{
		Padding        = "15,0,0,0"
		Height         = 35
		Width          = 450
		Text           = $lang.ExportToLogs
		Enabled        = $False
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_SaveTo  = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Margin         = "0,35,0,0"
		Text           = $lang.SaveTo
	}

	<#
		.Mask: Displays the rule details
		.蒙板：显示规则详细信息
	#>
	$UI_Main_View_Detailed = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 1006
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '0,0'
		Visible        = 0
	}
	$UI_Main_View_Detailed_Show = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 600
		Width          = 880
		BorderStyle    = 0
		Location       = "15,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_View_Detailed_Canel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main_View_Detailed.Visible = $False
		}
	}

	<#
		.End on-demand mode
		.结束按需模式
	#>
	$UI_Main_Suggestion_Manage = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignSetting
		Location       = '620,395'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 415
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '620,425'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "12" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '620,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	<#
		.Suggested content
		.建议的内容
	#>
	$UI_Main_Suggestion_Not = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 430
		Text           = $lang.SuggestedSkip
		Location       = '620,390'
		add_Click      = {
			if ($UI_Main_Suggestion_Not.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Suggested\$($Global:Event_Guid)" -name "IsSuggested" -value "True" -String
				$UI_Main_Suggestion_Setting.Enabled = $False
				$UI_Main_Suggestion_Stop.Enabled = $False
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Suggested\$($Global:Event_Guid)" -name "IsSuggested" -value "False" -String
				$UI_Main_Suggestion_Setting.Enabled = $True
				$UI_Main_Suggestion_Stop.Enabled = $True
			}
		}
	}
	$UI_Main_Suggestion_Setting = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignSetting
		Location       = '636,426'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '636,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "620,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Height         = 60
		Width          = 280
		Location       = "645,525"
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 280
		Location       = "620,595"
		Text           = $lang.OK
		add_Click      = {
			$Temp_Queue_Update_Add_Select = @()
			$UI_Main_Rule.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.RadioButton]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Temp_Queue_Update_Add_Select += $_.Tag

							Write-host "   $($lang.Setting): $($lang.SaveTo)"
							Write-host "   $($_.Tag)"
							New-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $_.Tag -Force
							Write-host "   $($lang.Done)" -ForegroundColor Green
						}
					}
				}
			}

			if ($Temp_Queue_Update_Add_Select.Count -gt 0) {
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.SaveTo)"
				return
			}

			$UI_Main.Hide()

			<#
				.固化更新
			#>
			New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.CuringUpdate)" -ForegroundColor Yellow
			if ($UI_Main_Curing_Update.Enabled) {
				if ($UI_Main_Curing_Update.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green

					New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.清理取代的
			#>
			New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
			if ($UI_Main_Superseded_Rule.Enabled) {
				if ($UI_Main_Superseded_Rule.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green

					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}

				Write-Host "`n   $($lang.ExcludeItem)" -ForegroundColor Yellow
				if ($UI_Main_Superseded_Rule_Exclude.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green

					New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.健康
			#>
			New-Variable -Scope global -Name "Queue_Healthy_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.Healthy)" -ForegroundColor Yellow
			if ($UI_Main_Healthy.Enabled) {
				if ($UI_Main_Healthy.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Healthy_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.获取预安装应用 UWP
			#>
			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.GetImageUWP)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
			if ($UI_Main_UWP_To_Log.Enabled) {
				if ($UI_Main_UWP_To_Log.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			Write-Host "`n   $($lang.ExportShow)" -ForegroundColor Yellow
			if ($UI_Main_UWP_To_View.Enabled) {
				if ($UI_Main_UWP_To_View.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}


			<#
				.查看安装的所有软件包的列表
			#>
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
			if ($UI_Main_Package_To_Log.Enabled) {
				if ($UI_Main_Package_To_Log.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_Language_Components_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.查看已安装的驱动列表
			#>
			New-Variable -Scope global -Name "Queue_Is_Drive_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Drive_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.ViewDrive)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
			if ($UI_Main_Drive_To_Log.Enabled) {
				if ($UI_Main_Drive_To_Log.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_Drive_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			Write-Host "`n   $($lang.ExportShow)" -ForegroundColor Yellow
			if ($UI_Main_Drive_To_View.Enabled) {
				if ($UI_Main_Drive_To_View.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_Drive_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.映像语言
			#>
			New-Variable -Scope global -Name "Queue_Is_Language_Report_Image_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.ImageLanguage)"
			if ($UI_Main_Language.Enabled) {
				if ($UI_Main_Language.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green
					New-Variable -Scope global -Name "Queue_Is_Language_Report_Image_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event -All
			}
			$UI_Main.Close()
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			<#
				.固化更新
			#>
			New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

				<#
					.清理取代的
				#>
				New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
				New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			<#
				.健康
			#>
			New-Variable -Scope global -Name "Queue_Healthy_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			<#
				.获取预安装应用 UWP
			#>
			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			<#
				.查看安装的所有软件包的列表
			#>
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			<#
				.查看已安装的驱动列表
			#>
			New-Variable -Scope global -Name "Queue_Is_Drive_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Drive_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			<#
				.映像语言
			#>
			New-Variable -Scope global -Name "Queue_Is_Language_Report_Image_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_View_Detailed,
		$UI_Main_Menu,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	$UI_Main_View_Detailed.controls.AddRange((
		$UI_Main_View_Detailed_Show,
		$UI_Main_View_Detailed_Canel
	))
	$UI_Main_Menu.controls.AddRange((
		$UI_Main_Curing_Update,
		$UI_Main_Curing_Update_Tips,
		$UI_Main_Superseded_Rule,
		$UI_Main_Superseded_Rule_Tips,
		$UI_Main_Superseded_Rule_Exclude,
		$UI_Main_Superseded_Rule_View_Detailed,
		$UI_Main_Healthy,
		$UI_Main_Healthy_Tips,
		$UI_Main_UWP_Name,
		$UI_Main_UWP_To_Log,
		$UI_Main_UWP_To_View,
		$UI_Main_Package_Name,
		$UI_Main_Package_To_Log,
		$UI_Main_Package_To_View,
		$UI_Main_Drive_Name,
		$UI_Main_Drive_To_Log,
		$UI_Main_Drive_To_View,
		$UI_Main_Language_Name,
		$UI_Main_Language,
		$UI_Main_SaveTo,
		$UI_Main_Rule
	))

	<#
		.计算公式：
			四舍五入为整数
				(初始化字符长度 * 初始化字符长度）
			/ 控件高度
	#>
	<#
		.初始化字符长度
	#>
	[int]$InitCharacterLength = 90

	<#
		.初始化控件高度
	#>
	[int]$InitControlHeight = 35

	$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	ForEach ($item in $SearchFolderRule) {
		$InitLength = $item.Length
		if ($InitLength -lt $InitCharacterLength) { $InitLength = $InitCharacterLength }

		$CheckBox     = New-Object System.Windows.Forms.RadioButton -Property @{
			Height    = $([math]::Ceiling($InitLength / $InitCharacterLength) * $InitControlHeight)
			Width     = 492
			Text      = $item
			Tag       = $item
			Margin    = "16,0,0,0"
			add_Click = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null
			}
		}

		if ($Temp_Expand_Rule -eq $item) {
			$CheckBox.Checked = $True
		}
		$UI_Main_Rule.controls.AddRange($CheckBox)
	}

	$UI_Main_Need_Mount_Lang_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 460
	}
	$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Wrap)

	<#
		.判断 boot.wim，关闭部分不可用的选项
	#>
	switch ("$($Global:Primary_Key_Image.Master);$($Global:Primary_Key_Image.ImageFileName);") {
		"Install;Install;wim;" {

		}
			"Install;WinRE;wim;" {
				$UI_Main_Curing_Update.Enabled = $False                 # 固化更新
				$UI_Main_Superseded_Rule.Enabled = $False               # 清理取代的
				$UI_Main_Superseded_Rule_Exclude.Enabled = $False       # 清理过时的，排除规则
				$UI_Main_Healthy.Enabled = $False                       # 健康
				$UI_Main_UWP_To_Log.Enabled = $False                    # 获取预安装应用 UWP
			}

		"boot;boot;wim;" {
			$UI_Main_Curing_Update.Enabled = $False                 # 固化更新
			$UI_Main_Superseded_Rule.Enabled = $False               # 清理取代的
			$UI_Main_Superseded_Rule_Exclude.Enabled = $False       # 清理过时的，排除规则
			$UI_Main_Healthy.Enabled = $False                       # 健康
			$UI_Main_UWP_To_Log.Enabled = $False                    # 获取预安装应用 UWP
		}
		Default {
			
		}
	}

	<#
		.固化更新
	#>
	if ((Get-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Curing_Update.Checked = $True
	}

	<#
		.清理过期的组件
	#>
	if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Superseded_Rule.Checked = $True
	}

	if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Superseded_Rule_Exclude.Checked = $True
	} else {
		$UI_Main_Superseded_Rule_Exclude.Checked = $False
	}

	<#
		.健康
	#>
	if ((Get-Variable -Scope global -Name "Queue_Healthy_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Healthy.Checked = $True
	}

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.QueueMode), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"

		$UI_Main_UWP_To_Log.Enabled = $True
		$UI_Main_Package_To_Log.Enabled = $True
		$UI_Main_Drive_To_Log.Enabled = $True
		$UI_Main_Language.Enabled = $True

		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))
	} else {
		if (Image_Is_Select_IAB) {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		} else {
			$UI_Main_Menu.Enabled = $False
		}

		<#
			.初始化复选框：不再建议
		#>
		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Suggested\$($Global:Event_Guid)" -Name "IsSuggested" -ErrorAction SilentlyContinue) {
			switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Suggested\$($Global:Event_Guid)" -Name "IsSuggested" -ErrorAction SilentlyContinue) {
				"True" {
					$UI_Main_Suggestion_Not.Checked = $True
					$UI_Main_Suggestion_Setting.Enabled = $False
					$UI_Main_Suggestion_Stop.Enabled = $False
				}
				"False" {
					$UI_Main_Suggestion_Not.Checked = $False
					$UI_Main_Suggestion_Setting.Enabled = $True
					$UI_Main_Suggestion_Stop.Enabled = $True
				}
			}
		} else {
			$UI_Main_Suggestion_Not.Checked = $False
			$UI_Main_Suggestion_Setting.Enabled = $True
			$UI_Main_Suggestion_Stop.Enabled = $True
		}

		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "IsSuggested" -ErrorAction SilentlyContinue) {
			if ((Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "IsSuggested" -ErrorAction SilentlyContinue) -eq "True") {
				$UI_Main.controls.AddRange((
					$UI_Main_Suggestion_Not,
					$UI_Main_Suggestion_Setting,
					$UI_Main_Suggestion_Stop
				))
			}
		}

		if (Image_Is_Select_IAB) {
			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				if (Image_Is_Select_Install) {
					$UI_Main_UWP_To_Log.Enabled = $True
					$UI_Main_UWP_To_View.Enabled = $True
				}
				$UI_Main_Drive_To_Log.Enabled = $True
				$UI_Main_Drive_To_View.Enabled = $True
				$UI_Main_Package_To_Log.Enabled = $True
				$UI_Main_Package_To_View.Enabled = $True
				$UI_Main_Language.Enabled = $True
			}
		}
	}

	<#
		.Allow open windows to be on top
		.允许打开的窗口后置顶
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "TopMost" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "TopMost" -ErrorAction SilentlyContinue) {
			"True" { $UI_Main.TopMost = $True }
		}
	}

	switch ($Global:IsLang) {
		"zh-CN" {
			$UI_Main.Font = New-Object System.Drawing.Font("Microsoft YaHei", 9, [System.Drawing.FontStyle]::Regular)
		}
		Default {
			$UI_Main.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
		}
	}

	$UI_Main.ShowDialog() | Out-Null
}

<#
	.Clean up expired and replaced
	.清理过期被取代的
#>
Function Image_Clear_Superseded
{
	<#
		.初始化，获取预安装 UWP 应用
	#>
	$InitlClearSuperseded = @()
	$InitlClearSupersededExclude = @()
	$InitlClearSupersededDelete = @()

	<#
		.判断挂载目录是否存在
	#>
	if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		<#
			.从设置里判断是否允许排除规则
		#>
		if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			ForEach ($item in $Global:ExcludeClearSuperseded) {
				$InitlClearSupersededDelete += $item
			}
		}

		<#
			.输出当前所有排除规则
		#>
		Write-Host "`n   $($lang.ExcludeItem)" -ForegroundColor Yellow
		if ($InitlClearSupersededDelete.count -gt 0) {
			ForEach ($item in $InitlClearSupersededDelete) {
				Write-Host "   $($item)" -ForegroundColor Green
			}
		} else {
			Write-Host "   $($lang.NoWork)" -ForegroundColor Red
		}

		<#
			.获取所有已安装的应用，并输出到数组
		#>
		Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
		try {
			Get-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
				if ($_.PackageState -eq "Superseded") {
					$InitlClearSuperseded += $_.PackageName
					Write-Host "   $($_.PackageName)" -ForegroundColor Green
				}
			}
		} catch {
			Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Superseded), $($lang.Inoperable) ( Superseded )" -ForegroundColor Red
		}

		try {
			Get-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
				if ($_.PackageState -eq "UninstallPending") {
					$InitlClearSuperseded += $_.PackageName
					Write-Host "   $($_.PackageName)" -ForegroundColor Green
				}
			}
		} catch {
			Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Superseded), $($lang.Inoperable) ( UninstallPending )" -ForegroundColor Red
		}

		<#
			.从排除规则获取需要排除的项目
		#>
		if ($InitlClearSuperseded.count -gt 0) {
			ForEach ($Item in $InitlClearSuperseded) {
				ForEach ($WildCard in $InitlClearSupersededDelete) {
					if ($item -like $WildCard) {
						$InitlClearSupersededExclude += $item
					}
				}
			}

			Write-Host "`n   $($lang.LXPsWaitRemove)" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			ForEach ($item in $InitlClearSuperseded) {
				if (($InitlClearSupersededExclude) -notContains $item) {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)38" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Remove-WindowsPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -PackageName ""$($item)""" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}

					Write-Host "   $($item)" -ForegroundColor Red
					Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
					try {
						Remove-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Remove.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PackageName $item -ErrorAction SilentlyContinue | Out-Null
						Write-Host $lang.Done -ForegroundColor Green
					} catch {
						Write-Host $lang.SelectFromError -ForegroundColor Red
						Write-Host "   $($_)" -ForegroundColor Yellow
						Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
					}

					Write-Host ""
				}
			}
		} else {
			Write-Host "   $($lang.NoWork)" -ForegroundColor Red
		}
	} else {
		Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
	}
}