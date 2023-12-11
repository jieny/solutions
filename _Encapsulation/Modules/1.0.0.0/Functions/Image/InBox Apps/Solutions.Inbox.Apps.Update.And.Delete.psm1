<#
	.Only add local language experience pack ( LXPs )
	.仅添加本地语言体验包 ( LXPs )
#>
Function InBox_Apps_Refresh_UI
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $lang.StepThree
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
			InBox_Apps_Refresh_UI
		}

		Image_Get_Mount_Status
	}

	Write-Host "`n   $($lang.StepThree)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

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

	Function InBox_Apps_Refresh_Remove
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$UI_Main_Is_Wait_Del.controls.Clear()

		if (-not (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguageRemove" -ErrorAction SilentlyContinue)) {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectLXPsLanguageRemove" -value "" -Multi
		}
		$GetSelectLXPsLanguage = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguageRemove"

		$Region = Language_Region
		ForEach ($itemRegion in $Region) {
			$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
				Height    = 40
				Width     = 160
				Text      = $itemRegion.Region
				add_Click = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null
				}
			}

			if (($GetSelectLXPsLanguage) -Contains $itemRegion.Region) {
				$CheckBox.Checked = $True
			} else {
				$CheckBox.Checked = $False
			}

			$UI_Main_Is_Wait_Del.controls.AddRange($CheckBox)
		}
	}

	<#
		.事件：刷新选择来源
	#>
	Function InBox_Apps_Refresh_Sync
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$TempSelectAddLanguage = @()

		if ($UI_Main_Is_Sync_To.Checked) {
			$UI_Main_Is_Wait_Add.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$TempSelectAddLanguage += $($_.Text)
						}
					}
				}
			}

			if ($UI_Main_Sync_To_Be_Deleted.Checked) {
				$UI_Main_Is_Wait_Del.controls.Clear()

				ForEach ($item in $TempSelectAddLanguage) {
					$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
						Height    = 28
						Width     = 160
						Text      = $item
						Checked   = $True
						add_Click = {
							$UI_Main_Error.Text = ""
							$UI_Main_Error_Icon.Image = $null
						}
					}

					$UI_Main_Is_Wait_Del.controls.AddRange($CheckBox)
				}
			}

			if ($UI_Main_Sync_To_Deleted.checked) {
				$UI_Main_Is_Wait_Del.controls.Clear()

				$Region = Language_Region
				ForEach ($itemRegion in $Region) {
					$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
						Height    = 40
						Width     = 160
						Text      = $itemRegion.Region
						add_Click = {
							$UI_Main_Error.Text = ""
							$UI_Main_Error_Icon.Image = $null
						}
					}

					if (($TempSelectAddLanguage) -Contains $itemRegion.Region) {
						$CheckBox.Checked = $True
					} else {
						$CheckBox.Checked = $False
					}

					$UI_Main_Is_Wait_Del.controls.AddRange($CheckBox)
				}
			}
		}
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
        Height         = 720
        Width          = 898
		Text           = $lang.StepThree
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.显示提示蒙层
	#>
	$UI_Main_Mask_Tips = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 760
		Width          = 898
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '0,0'
		Visible        = 0
	}
	$UI_Main_Mask_Tips_Results = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 555
		Width          = 855
		BorderStyle    = 0
		Location       = "15,15"
		Text           = $lang.RemoveAllUWPTips
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_Mask_Tips_Global_Do_Not = New-Object System.Windows.Forms.CheckBox -Property @{
		Location       = "20,607"
		Height         = 30
		Width          = 550
		Text           = $lang.LXPsAddDelTipsGlobal
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Mask_Tips_Global_Do_Not.Checked) {
				Save_Dynamic -regkey "Solutions" -name "TipsWarningUWPGlobal" -value "True" -String
				$UI_Main_Mask_Tips_Do_Not.Enabled = $False
			} else {
				Save_Dynamic -regkey "Solutions" -name "TipsWarningUWPGlobal" -value "False" -String
				$UI_Main_Mask_Tips_Do_Not.Enabled = $True
			}
		}
	}
	$UI_Main_Mask_Tips_Do_Not = New-Object System.Windows.Forms.CheckBox -Property @{
		Location       = "20,635"
		Height         = 30
		Width          = 550
		Text           = $lang.LXPsAddDelTips
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Mask_Tips_Do_Not.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "TipsWarningUWP" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "TipsWarningUWP" -value "False" -String
			}
		}
	}
	$UI_Main_Mask_Tips_Canel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "590,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main_Mask_Tips.Visible = 0
		}
	}

	$UI_Main_Is_Sync_To = New-Object System.Windows.Forms.CheckBox -Property @{
		Location       = "15,10"
		Height         = 30
		Width          = 440
		Text           = $lang.LXPsWaitSync
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Is_Sync_To.Checked) {
				$UI_Main_Sync_To_Group.Enabled = $True
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_AllowSyncToRemove" -value "True" -String
			} else {
				$UI_Main_Sync_To_Group.Enabled = $False
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_AllowSyncToRemove" -value "False" -String
				InBox_Apps_Refresh_Remove
			}
		}
	}
	$UI_Main_Sync_To_Group = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 80
		Width          = 500
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "8,0,8,0"
		Location       = "15,40"
	}
	$UI_Main_Sync_To_Be_Deleted = New-Object System.Windows.Forms.RadioButton -Property @{
		Height         = 30
		Width          = 440
		Text           = $lang.LXPsWaitRemove
		Padding        = "15,0,8,0"
		Add_Click      = {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectSyncTo" -value "1" -String
			InBox_Apps_Refresh_Sync
		}
	}
	$UI_Main_Sync_To_Deleted = New-Object System.Windows.Forms.RadioButton -Property @{
		Height         = 30
		Width          = 440
		Text           = $lang.LXPsWaitRemoveKnown
		Padding        = "15,0,8,0"
		Add_Click      = {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectSyncTo" -value "2" -String
			InBox_Apps_Refresh_Sync
		}
	}

	<#
		.待添加
	#>
	$UI_Main_Wait_Add  = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 205
		Location       = "43,130"
		Text           = $lang.LXPsWaitAddUpdate
		checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Wait_Add.Checked) {
				$UI_Main_Is_Wait_Add.Enabled = $True
				$UI_Main_Select_Folder.Enabled = $True
			} else {
				$UI_Main_Is_Wait_Add.Enabled = $False
				$UI_Main_Select_Folder.Enabled = $False
			}
		}
	}
	$UI_Main_Is_Wait_Add = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 330
		Width          = 205
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "16,0,0,0"
		Location       = "43,160"
	}

	<#
		.待删除
	#>
	$UI_Main_Wait_Del  = New-Object System.Windows.Forms.CheckBox -Property @{
		Location       = "310,130"
		Height         = 30
		Width          = 205
		Text           = $lang.LXPsWaitRemove
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Wait_Del.Checked) {
				$UI_Main_Is_Wait_Del.Enabled = $True
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_AllowRemoveLXPs" -value "True" -String
			} else {
				$UI_Main_Is_Wait_Del.Enabled = $False
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_AllowRemoveLXPs" -value "False" -String
			}
		}
	}
	$UI_Main_Is_Wait_Del = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 330
		Width          = 205
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "16,0,0,0"
		Location       = "310,160"
	}

	<#
		可选功能
	#>
	$UI_Main_Adv       = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 485
		Text           = $lang.AdvOption
		Location       = '15,525'
	}
	$UI_Main_Sync_Again = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 470
		Text           = $lang.LXPsSyncToRemove
		Location       = "31,560"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			InBox_Apps_Refresh_Sync
		
			$UI_Main_Error.Text = "$($lang.LXPsSyncToRemove), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		}
	}
	$UI_Main_Sync_Restore = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 470
		Text           = $lang.LXPsRestoreOld
		Location       = "31,598"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			InBox_Apps_Refresh_Remove
		
			$UI_Main_Error.Text = "$($lang.LXPsRestoreOld), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		}
	}
	$UI_Main_Tips_New  = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 470
		Text           = $lang.LXPsAddDelTipsView
		Location       = "31,640"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			$UI_Main_Mask_Tips.Visible = 1
		}
	}

	$UI_Main_Select_Folder = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "590,10"
		Height         = 36
		Width          = 280
		Text           = $lang.SelectFolder
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			if (-not (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguage" -ErrorAction SilentlyContinue)) {
				$DeployinboxGetSources = $False
				$DeployinboxGetSourcesOnly = @()

				$Region = Language_Region
				ForEach ($itemRegion in $Region) {
					if (Test-Path "$($Global:Image_source)\sources\$($itemRegion.Region)" -PathType Container) {
						if((Get-ChildItem "$($Global:Image_source)\sources\$($itemRegion.Region)" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
							$DeployinboxGetSources = $True
							$DeployinboxGetSourcesOnly += $($itemRegion.Region)
						}
					}
				}

				if ($DeployinboxGetSources) {
					Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectLXPsLanguage" -value $DeployinboxGetSourcesOnly -Multi
				} else {
					Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectLXPsLanguage" -value "" -Multi
				}
			}
			$GetSelectLXPsLanguage = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguage"

			<#
				.Initial browse directory
				.初始浏览目录
			#>
			$FolderBrowser   = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
				RootFolder   = "MyComputer"
			}

			<#
				.Browse catalog: confirm
				.浏览目录：确认
			#>
			if ($FolderBrowser.ShowDialog() -eq "OK") {
				$MarkCheckLocalExperiencePack = $False
				<#
					.Clear display area
					.清除显示区域
				#>
				$UI_Main_Is_Wait_Add.controls.Clear()

				<#
					.Search whether the selected directory has: LanguageExperiencePack.*.appx
					.搜索已选择的目录是否有：LanguageExperiencePack.*.appx
				#>
				if (Test-Path "$($FolderBrowser.SelectedPath)\LocalExperiencePack" -PathType Container) {
					Get-ChildItem "$($FolderBrowser.SelectedPath)\LocalExperiencePack" -directory -ErrorAction SilentlyContinue | ForEach-Object {
						if (Test-Path "$($_.FullName)\LanguageExperiencePack.*.appx" -PathType Leaf) {
							$MarkCheckLocalExperiencePack = $True

							$CheckBox     = New-Object System.Windows.Forms.CheckBox  -Property @{
								Height    = 28
								Width     = 160
								Text      = $_.BaseName
								Tag       = $_.FullName
								add_Click = { InBox_Apps_Refresh_Sync }
							}

							if ($GetSelectLXPsLanguage -contains $_.BaseName) {
								$CheckBox.Checked = $True
							} else {
								$CheckBox.Checked = $False
							}

							$UI_Main_Is_Wait_Add.controls.AddRange($CheckBox)
						}
					}
				} else {
					Get-ChildItem "$($FolderBrowser.SelectedPath)" -directory -ErrorAction SilentlyContinue | ForEach-Object {
						if (Test-Path "$($_.FullName)\LanguageExperiencePack.*.appx" -PathType Leaf) {
							$MarkCheckLocalExperiencePack = $True

							$CheckBox     = New-Object System.Windows.Forms.CheckBox  -Property @{
								Height    = 28
								Width     = 160
								Text      = $_.BaseName
								Tag       = $_.FullName
								add_Click = { InBox_Apps_Refresh_Sync }
							}

							if ($GetSelectLXPsLanguage -contains $_.BaseName) {
								$CheckBox.Checked = $True
							} else {
								$CheckBox.Checked = $False
							}

							$UI_Main_Is_Wait_Add.controls.AddRange($CheckBox)
						}
					}
				}

				if ($MarkCheckLocalExperiencePack) {
					InBox_Apps_Refresh_Sync
				}
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = $lang.UserCanel
			}
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
		Location       = '590,395'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 415
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '590,425'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "17" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '590,455'
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
		Location       = '590,390'
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
		Location       = '606,426'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '606,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "590,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "615,525"
		Height         = 60
		Width          = 255
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "590,595"
		Height         = 36
		Width          = 280
		Text           = $lang.AddTo
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			New-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_There_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			$Script:LXPsAddWaitQueue = @()

			New-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			$Script:LXPsDelWaitQueue = @()

			<#
				.Reset selected
				.重置已选择
			#>
			$TempSelectLXPsLanguage = @()

			<#
				.等待添加本地语言体验包（LXPs）
			#>
			if ($UI_Main_Wait_Add.checked) {
				<#
					.Mark: Check the selection status
					.标记：检查选择状态
				#>
				$FlagCheckSelectStatus = $False

				$UI_Main_Is_Wait_Add.Controls | ForEach-Object {
					if ($_ -is [System.Windows.Forms.CheckBox]) {
						if ($_.Enabled) {
							if ($_.Checked) {
								$FlagCheckSelectStatus = $True
								$Script:LXPsAddWaitQueue += $($_.Tag)
								$TempSelectLXPsLanguage += $($_.Text)
							}
						}
					}
				}

				<#
					.Verification mark: check selection status
					.验证标记：检查选择状态
				#>
				if ($FlagCheckSelectStatus) {
					ForEach ($item in $TempSelectLXPsLanguage) {
						Write-Host "   $($item)"
					}
					Write-Host ""

					if ($GUILXPsOnlySkipCheckAdd.Checked) {
						New-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_There_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
						$Script:LXPsAddWaitQueue = @()
					} else {
						New-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_There_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					}
					Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectLXPsLanguage" -value $TempSelectLXPsLanguage -Multi

					if ($UI_Main_Suggestion_Not.Checked) {
						Init_Canel_Event -All
					}
				} else {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) ( $($lang.LXPsWaitAddUpdate) )"
					return
				}
			}

			<#
				.等待删除本地语言体验包（LXPs）
			#>
			if ($UI_Main_Wait_Del.checked) {
				<#
					.Mark: Check the selection status
					.标记：检查选择状态
				#>
				$FlagCheckSelectRemoveStatus = $False

				$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
					if ($_ -is [System.Windows.Forms.CheckBox]) {
						if ($_.Enabled) {
							if ($_.Checked) {
								$FlagCheckSelectRemoveStatus = $True
							}
						}
					}
				}

				<#
					.Verification mark: check selection status
					.验证标记：检查选择状态
				#>
				if ($FlagCheckSelectRemoveStatus) {
					$UI_Main.Hide()
					New-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force

					$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
						if ($_ -is [System.Windows.Forms.CheckBox]) {
							if ($_.Enabled) {
								if ($_.Checked) {
									$Script:LXPsDelWaitQueue += $($_.Text)
									Write-Host "   $($lang.LXPsWaitRemove) ( $($_.Text) )"
								}
							}
						}
					}
					Write-Host ""
					Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectLXPsLanguageRemove" -value $Script:LXPsDelWaitQueue -Multi

					if ($UI_Main_Suggestion_Not.Checked) {
						Init_Canel_Event -All
					}

					$UI_Main.Close()
				} else {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) ( $($lang.LXPsWaitRemove) )"
					return
				}
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "590,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			New-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_There_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			$Script:LXPsAddWaitQueue = @()
			$Script:LXPsDelWaitQueue = @()

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Mask_Tips,
		$UI_Main_Is_Sync_To,
		$UI_Main_Sync_To_Group,

		$UI_Main_Wait_Add,
		$UI_Main_Is_Wait_Add,

		$UI_Main_Wait_Del,
		$UI_Main_Is_Wait_Del,

		<#
			.可选功能
		#>
		$UI_Main_Adv,
		$UI_Main_Sync_Again,
		$UI_Main_Sync_Restore,
		$UI_Main_Tips_New,
		$UI_Main_Select_Folder,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	$UI_Main_Mask_Tips.controls.AddRange((
		$UI_Main_Mask_Tips_Results,
		$UI_Main_Mask_Tips_Global_Do_Not,
		$UI_Main_Mask_Tips_Do_Not,
		$UI_Main_Mask_Tips_Canel
	))

	$UI_Main_Sync_To_Group.controls.AddRange((
		$UI_Main_Sync_To_Be_Deleted,
		$UI_Main_Sync_To_Deleted
	))

	<#
		.选择：等待删除，等待删除并显示已知其它语言
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectSyncTo" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectSyncTo" -ErrorAction SilentlyContinue) {
			"1" {
				$UI_Main_Sync_To_Be_Deleted.Checked = $True
				$UI_Main_Sync_To_Deleted.Checked = $False
			}
			"2" {
				$UI_Main_Sync_To_Be_Deleted.Checked = $False
				$UI_Main_Sync_To_Deleted.Checked = $True
			}
			Default
			{
				$UI_Main_Sync_To_Be_Deleted.Checked = $True
				$UI_Main_Sync_To_Deleted.Checked = $False
			}
		}
	} else {
		$UI_Main_Sync_To_Be_Deleted.Checked = $True
		$UI_Main_Sync_To_Deleted.Checked = $False
	}

	<#
		.复选框：选择等待添加后，同步到
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_AllowSyncToRemove" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_AllowSyncToRemove" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Is_Sync_To.Checked = $True
				$UI_Main_Sync_To_Group.Enabled = $True
			}
			"False" {
				$UI_Main_Is_Sync_To.Checked = $False
				$UI_Main_Sync_To_Group.Enabled = $False
			}
		}
	} else {
		$UI_Main_Is_Sync_To.Checked = $False
		$UI_Main_Sync_To_Group.Enabled = $False
	}

	<#
		.复选框：等待删除
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_AllowRemoveLXPs" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_AllowRemoveLXPs" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Wait_Del.Checked = $True
				$UI_Main_Is_Wait_Del.Enabled = $True
			}
			"False" {
				$UI_Main_Wait_Del.Checked = $False
				$UI_Main_Is_Wait_Del.Enabled = $False
			}
		}
	} else {
		$UI_Main_Wait_Del.Checked = $False
		$UI_Main_Is_Wait_Del.Enabled = $False
	}

	<#
		.提示
	#>
	$MarkShowNewTips = $False
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "TipsWarningUWPGlobal" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "TipsWarningUWPGlobal" -ErrorAction SilentlyContinue) {
			"True" {
				$MarkShowNewTips = $True
				$UI_Main_Mask_Tips_Global_Do_Not.Checked = $True
				$UI_Main_Mask_Tips_Do_Not.Enabled = $False
			}
			"False" {
				$UI_Main_Mask_Tips_Global_Do_Not.Checked = $False
				$UI_Main_Mask_Tips_Do_Not.Enabled = $True
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "TipsWarningUWP" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "TipsWarningUWP" -ErrorAction SilentlyContinue) {
			"True" {
				$MarkShowNewTips = $True
				$UI_Main_Mask_Tips_Do_Not.Checked = $True
			}
			"False" {
				$UI_Main_Mask_Tips_Do_Not.Checked = $False
			}
		}
	}
	if ($MarkShowNewTips) {
		$UI_Main_Mask_Tips.Visible = 0
	} else {
		$UI_Main_Mask_Tips.Visible = 1
	}

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUILXPsOnlySelectMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUILXPsOnlySelectMenu.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Is_Wait_Add.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUILXPsOnlySelectMenu.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Is_Wait_Add.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				$_.Checked = $false
			}
		}
	})
	$UI_Main_Is_Wait_Add.ContextMenuStrip = $GUILXPsOnlySelectMenu

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUILXPsRemoveMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUILXPsRemoveMenu.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUILXPsRemoveMenu.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				$_.Checked = $false
			}
		}
	})
	$UI_Main_Is_Wait_Del.ContextMenuStrip = $GUILXPsRemoveMenu

	InBox_Apps_Refresh_Remove

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.QueueMode), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))
	}  else {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"

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
	.添加本地语言体验包
#>
Function InBox_Apps_LIPs_Add_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = $lang.StepThree
	}

	if ($Script:LXPsAddWaitQueue.count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:LXPsAddWaitQueue) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:LXPsAddWaitQueue) {
			InBox_Apps_Add_Mark_Process -Path $item
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}

<#
	.删除本地语言体验包
#>
Function InBox_Apps_LIPs_Delete_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = "$($lang.Del) ( $($lang.LocalExperiencePackTips) )"
	}

	if ($Script:LXPsDelWaitQueue.count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:LXPsDelWaitQueue) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:LXPsDelWaitQueue) {
			Write-Host "   $($item)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			
			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				try {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)61" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Get-AppXProvisionedPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" | Where-Object DisplayName -Like ""*LanguageExperiencePack*$($item)*"" | Remove-AppxProvisionedPackage" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}
		
					Get-AppXProvisionedPackage -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | Where-Object DisplayName -Like "*LanguageExperiencePack*$($item)*" | Remove-AppxProvisionedPackage -ErrorAction SilentlyContinue | Out-Null
					Write-Host $lang.Done -ForegroundColor Green
				} catch {
					Write-Host $lang.SelectFromError -ForegroundColor Red
					Write-Host "   $($_)" -ForegroundColor Yellow
					Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
				}

				Write-host ""
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
			}
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}