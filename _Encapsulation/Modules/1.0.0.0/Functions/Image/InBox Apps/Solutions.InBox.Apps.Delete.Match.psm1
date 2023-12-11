<#
	.Delete: delete inbox Apps by matching rules
	.删除：按匹配规则删除 inbox Apps
#>
Function InBox_Apps_Match_Delete_UI
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $lang.InboxAppsMatchDel
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
			InBox_Apps_Match_Delete_UI
		}

		Image_Get_Mount_Status
	}

	Write-Host "`n   $($lang.InboxAppsMatchDel)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main_Extract_Rule_Select_SourcestClick = {
		$UI_Main_Extract_Rule_Select_Apps.controls.clear()

		if (InBox_Apps_Delete_Check_Match_Customize -RuleNaming) {
			InBox_Apps_Refresh_Rule_Match_Delete
		}
	}

	<#
		.事件：查看规则命名，详细内容
	#>
	Function InBox_Apps_Del_Rule_Details_View
	{
		param
		(
			$GUID
		)

		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$InBox_Apps_Rule_Select_Single = @()

		<#
			.从预规则里获取
		#>
		ForEach ($item in $Global:Pre_Config_Rules) {
			if ($GUID -eq $item.GUID) {
				$InBox_Apps_Rule_Select_Single = $item
				break
			}
		}

		<#
			.从单条规则里获取
		#>
		ForEach ($item in $Global:Preconfigured_Rule_Language) {
			if ($GUID -eq $item.GUID) {
				$InBox_Apps_Rule_Select_Single = $item
				break
			}
		}

		<#
			.从用户自定义规则里获取
		#>
		if (Is_Find_Modules -Name "Solutions.Custom.Extension") {
			if ($Global:Custom_Rule.count -gt 0) {
				ForEach ($item in $Global:Custom_Rule) {
					if ($GUID -eq $item.GUID) {
						$InBox_Apps_Rule_Select_Single = $item
						break
					}
				}
			}
		}

		if ($InBox_Apps_Rule_Select_Single.count -gt 0) {
			$UI_Main_Mask_Rule_Detailed.Visible = $True
			$UI_Main_Mask_Rule_Detailed_Results.Text = ""

			$UI_Main_Mask_Rule_Detailed_Results.Text += "$($lang.RuleAuthon)`n"
			$UI_Main_Mask_Rule_Detailed_Results.Text += "   $($InBox_Apps_Rule_Select_Single.Author)"

			$UI_Main_Mask_Rule_Detailed_Results.Text += "`n`n$($lang.RuleGUID)`n"
			$UI_Main_Mask_Rule_Detailed_Results.Text += "     $($InBox_Apps_Rule_Select_Single.GUID)"

			$UI_Main_Mask_Rule_Detailed_Results.Text += "`n`n$($lang.RuleName)`n"
			$UI_Main_Mask_Rule_Detailed_Results.Text += "     $($InBox_Apps_Rule_Select_Single.Name)"

			$UI_Main_Mask_Rule_Detailed_Results.Text += "`n`n$($lang.RuleDescription)`n"
			$UI_Main_Mask_Rule_Detailed_Results.Text += "     $($InBox_Apps_Rule_Select_Single.Description)"

			$UI_Main_Mask_Rule_Detailed_Results.Text += "`n`n$($lang.RuleISO)`n"
			if ($InBox_Apps_Rule_Select_Single.ISO.Count -gt 0) {
				ForEach ($item in $InBox_Apps_Rule_Select_Single.ISO) {
					$UI_Main_Mask_Rule_Detailed_Results.Text += "     $($lang.FileName)$($item.ISO)`n"
					$UI_Main_Mask_Rule_Detailed_Results.Text += "     SHA-256: $($item.CRCSHA.SHA256)`n`n"
				}
			} else {
				$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.NoWork)`n"
			}

			$UI_Main_Mask_Rule_Detailed_Results.Text += "`n`n$($lang.InboxAppsManager)`n"
			if ($InBox_Apps_Rule_Select_Single.InboxApps.Rule.Count -gt 0) {
				$UI_Main_Mask_Rule_Detailed_Results.Text += "    $($lang.RuleISO)`n"
				if ($InBox_Apps_Rule_Select_Single.InboxApps.ISO.Count -gt 0) {
					ForEach ($item in $InBox_Apps_Rule_Select_Single.InboxApps.ISO) {
						$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.FileName)$($item.ISO)`n"
						$UI_Main_Mask_Rule_Detailed_Results.Text += "         SHA-256: $($item.CRCSHA.SHA256)`n`n"
					}
				} else {
					$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.NoWork)`n"
				}

				$UI_Main_Mask_Rule_Detailed_Results.Text += "`n    $($lang.RuleCustomize) ( $($InBox_Apps_Rule_Select_Single.InboxApps.Edition.Count) $($lang.EventManagerCount) )`n"
				if ($InBox_Apps_Rule_Select_Single.InboxApps.Edition.Count -gt 0) {
					ForEach ($item in $InBox_Apps_Rule_Select_Single.InboxApps.Edition) {
						$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.Event_Group) ( $($item.Name.Count) $($lang.EventManagerCount) )`n"
						ForEach ($itemNewName in $item.Name) {
							$UI_Main_Mask_Rule_Detailed_Results.Text += "               $($itemNewName)`n"
						}

						$UI_Main_Mask_Rule_Detailed_Results.Text += "`n               $($lang.InboxAppsManager): $($lang.AddTo) ( $($item.Apps.Count) $($lang.EventManagerCount) )`n"
						ForEach ($itemNewName in $item.Apps) {
							$UI_Main_Mask_Rule_Detailed_Results.Text += "                    $($itemNewName)`n"
						}

						$UI_Main_Mask_Rule_Detailed_Results.Text += "`n"
					}
				} else {
					$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.NoWork)`n"
				}

				$UI_Main_Mask_Rule_Detailed_Results.Text += "`n$($lang.RuleInBoxApps) ( $($InBox_Apps_Rule_Select_Single.InboxApps.Rule.Count) $($lang.EventManagerCount) )`n"
				if ($InBox_Apps_Rule_Select_Single.InboxApps.Rule.Count -gt 0) {
					ForEach ($item in $InBox_Apps_Rule_Select_Single.InboxApps.Rule){
						$UI_Main_Mask_Rule_Detailed_Results.Text += "     $($item.Name)`n"
					}
				} else {
					$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.NoWork)`n"
				}
			} else {
				$UI_Main_Mask_Rule_Detailed_Results.Text += "         $($lang.NoWork)"
			}
		} else {
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
			$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.Detailed_View)"
		}
	}

	Function InBox_Apps_Refresh_Rule_Match_Delete
	{
		if (-not (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_Match_Delete_UWP" -ErrorAction SilentlyContinue)) {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_Match_Delete_UWP" -value "" -Multi
		}
		$GetSelectUWPExclude = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_Match_Delete_UWP"

		$SelectUWPExclude = @()
		ForEach ($item in $GetSelectUWPExclude) {
			$SelectUWPExclude += $item
		}

		<#
			.添加规则：预置规则
		#>
		ForEach ($item in $Global:Pre_Config_Rules) {
			if ($Global:InBoxAppsSearchRuleSelected -eq $item.GUID) {
				ForEach ($itemInBoxAppx in $item.InboxApps.Rule){
					$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
						Height    = 35
						Width     = 495
						Text      = $itemInBoxAppx.Name
						Tag       = $itemInBoxAppx.Match
						add_Click = {
							$UI_Main_Error.Text = ""
							$UI_Main_Error_Icon.Image = $null
						}
					}

					if (($SelectUWPExclude) -Contains $itemInBoxAppx.Name) {
						$CheckBox.Checked = $True
					}

					$UI_Main_Extract_Rule_Select_Apps.controls.AddRange($CheckBox)
				}

				return
			}
		}

		<#
			.从单条规则里获取
		#>
		ForEach ($item in $Global:Preconfigured_Rule_Language) {
			if ($Global:InBoxAppsSearchRuleSelected -eq $item.GUID) {
				ForEach ($itemInBoxAppx in $item.InboxApps.Rule){
					$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
						Height    = 35
						Width     = 495
						Text      = $itemInBoxAppx.Name
						Tag       = $itemInBoxAppx.Match
						add_Click = {
							$UI_Main_Error.Text = ""
							$UI_Main_Error_Icon.Image = $null
						}
					}

					if (($SelectUWPExclude) -Contains $itemInBoxAppx.Name) {
						$CheckBox.Checked = $True
					}

					$UI_Main_Extract_Rule_Select_Apps.controls.AddRange($CheckBox)
				}

				return
			}
		}

		<#
			.从用户自定义规则里获取
		#>
		if (Is_Find_Modules -Name "Solutions.Custom.Extension") {
			if ($Global:Custom_Rule.count -gt 0) {
				ForEach ($item in $Global:Custom_Rule) {
					if ($Global:InBoxAppsSearchRuleSelected -eq $item.GUID) {
						ForEach ($itemInBoxAppx in $item.InboxApps.Rule){
							$CheckBox     = New-Object System.Windows.Forms.CheckBox  -Property @{
								Height    = 35
								Width     = 495
								Text      = $itemInBoxAppx.Name
								Tag       = $itemInBoxAppx.Match
								add_Click = {
									$UI_Main_Error.Text = ""
									$UI_Main_Error_Icon.Image = $null
								}
							}

							if (($SelectUWPExclude) -Contains $itemInBoxAppx.Name) {
								$CheckBox.Checked = $True
							}

							$UI_Main_Extract_Rule_Select_Apps.controls.AddRange($CheckBox)
						}

						return
					}
				}
			}
		}
	}

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
		Text           = $lang.InboxAppsMatchDel
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	$UI_Main_Menu      = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 675
		Width          = 555
		autoSizeMode   = 1
		Location       = '20,0'
		Padding        = "0,15,0,0"
		autoScroll     = $True
	}

	<#
		.Mask: Displays the rule details
		.蒙板：显示规则详细信息
	#>
	$UI_Main_Mask_Rule_Detailed = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 1006
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '0,0'
		Visible        = 0
	}
	$UI_Main_Mask_Rule_Detailed_Results = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 600
		Width          = 880
		BorderStyle    = 0
		Location       = "15,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_Mask_Rule_Detailed_Canel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main_Mask_Rule_Detailed.Visible = $False
		}
	}

	<#
		.选择规则
	#>
	$UI_Main_Extract_Rule_Name = New-Object system.Windows.Forms.Label -Property @{
		Location       = "10,10"
		Height         = 30
		Width          = 530
		Text           = $lang.LanguageExtractRuleFilter
	}
	$UI_Main_Extract_Rule_Select_Sourcest = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		autosize       = 1
		BorderStyle    = 0
		autoSizeMode   = 1
		autoScroll     = $true
		Padding        = "16,0,0,0"
	}

	<#
		.依赖项
	#> 
	$UI_Main_Select_Apps_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 530
		margin         = "0,40,0,0"
		Text           = $lang.InstallUWP
	}
	$UI_Main_Extract_Rule_Select_Apps = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
		Padding        = "16,0,8,0"
	}
	$UI_Main_Menu_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 530
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
		Location       = '620,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "14" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '620,425'
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
		Location       = '645,525'
		Height         = 36
		Width          = 255
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			if (InBox_Apps_Delete_Check_Match_Customize -RuleNaming -SelectApps) {
				$UI_Main.Hide()
				New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Match_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force

				ForEach ($item in $Script:QueueInboxAppsDeleteSelect) {
					Write-Host "   $($item.Name)"
				}

				if ($UI_Main_Suggestion_Not.Checked) {
					Init_Canel_Event -All
				}
				$UI_Main.Close()
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red

			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Match_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			$Script:QueueInboxAppsDeleteSelect = @()

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Mask_Rule_Detailed,
		$UI_Main_Menu,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	$UI_Main_Menu.controls.AddRange((
		<#
			.选择规则
		#>
		$UI_Main_Extract_Rule_Name,
		$UI_Main_Extract_Rule_Select_Sourcest,

		<#
			.选择应用程序
		#>
		$UI_Main_Select_Apps_Name,
		$UI_Main_Extract_Rule_Select_Apps,
		$UI_Main_Menu_Wrap
	))
	$UI_Main_Mask_Rule_Detailed.controls.AddRange((
		$UI_Main_Mask_Rule_Detailed_Results,
		$UI_Main_Mask_Rule_Detailed_Canel
	))

	<#
		.选择全局唯一规则 GUID
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectGUID" -ErrorAction SilentlyContinue) {
		$GetDefaultSelectLabel = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectGUID" 	-ErrorAction SilentlyContinue
	} else {
		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\MVS" -Name "GUID" -ErrorAction SilentlyContinue) {
			$GetDefaultSelectLabel = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\MVS" -Name "GUID" -ErrorAction SilentlyContinue
		} else {
			$GetDefaultSelectLabel = ""
		}
	}

	<#
		.添加规则：预置规则
	#>
	$UI_Main_Extract_Pre_Rule = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 460
		Text           = $lang.RulePre
	}
	$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange($UI_Main_Extract_Pre_Rule)
	ForEach ($item in $Global:Pre_Config_Rules) {
		$CheckBox     = New-Object System.Windows.Forms.RadioButton -Property @{
			Height    = 28
			Width     = 460
			Padding   = "18,0,0,0"
			Text      = $item.Name
			Tag       = $item.GUID
			add_Click = $UI_Main_Extract_Rule_Select_SourcestClick
		}

		$UI_Main_Rule_Details_View = New-Object system.Windows.Forms.LinkLabel -Property @{
			Height         = 30
			Width          = 460
			Padding        = "36,0,0,0"
			Margin         = "0,0,0,5"
			Text           = $lang.Detailed_View
			Tag            = $item.GUID
			LinkColor      = "GREEN"
			ActiveLinkColor = "RED"
			LinkBehavior   = "NeverUnderline"
			add_Click      = {
				InBox_Apps_Del_Rule_Details_View -GUID $this.Tag
			}
		}

		$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange((
			$CheckBox,
			$UI_Main_Rule_Details_View
		))

		if ($item.InboxApps.Rule.Count -gt 0) {
			if ($GetDefaultSelectLabel -eq $item.GUID) {
				$CheckBox.Checked = $True
			}
		} else {
			$CheckBox.Enabled = $False
		}
	}

	<#
		.从单条规则里获取
	#>
	$UI_Main_Extract_Other_Rule = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 460
		Margin         = "0,35,0,0"
		Text           = $lang.RuleOther
	}
	$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange($UI_Main_Extract_Other_Rule)
	ForEach ($item in $Global:Preconfigured_Rule_Language) {
		$CheckBox     = New-Object System.Windows.Forms.RadioButton -Property @{
			Height    = 28
			Width     = 460
			Padding   = "18,0,0,0"
			Text      = $item.Name
			Tag       = $item.GUID
			add_Click = $UI_Main_Extract_Rule_Select_SourcestClick
		}

		$UI_Main_Rule_Details_View = New-Object system.Windows.Forms.LinkLabel -Property @{
			Height         = 30
			Width          = 460
			Padding        = "36,0,0,0"
			Margin         = "0,0,0,5"
			Text           = $lang.Detailed_View
			Tag            = $item.GUID
			LinkColor      = "GREEN"
			ActiveLinkColor = "RED"
			LinkBehavior   = "NeverUnderline"
			add_Click      = {
				InBox_Apps_Del_Rule_Details_View -GUID $this.Tag
			}
		}

		$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange((
			$CheckBox,
			$UI_Main_Rule_Details_View
		))

		if ($item.InboxApps.Rule.Count -gt 0) {
			if ($GetDefaultSelectLabel -eq $item.GUID) {
				$CheckBox.Checked = $True
			}
		} else {
			$CheckBox.Enabled = $False
		}
	}

	<#
		.添加规则，自定义
	#>
	$UI_Main_Extract_Customize_Rule = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 460
		Margin         = "0,35,0,0"
		Text           = $lang.RuleCustomize
	}
	$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange($UI_Main_Extract_Customize_Rule)
	if (Is_Find_Modules -Name "Solutions.Custom.Extension") {
		if ($Global:Custom_Rule.count -gt 0) {
			ForEach ($item in $Global:Custom_Rule) {
				$CheckBox     = New-Object System.Windows.Forms.RadioButton -Property @{
					Height    = 28
					Width     = 460
					Padding   = "18,0,0,0"
					Text      = $item.Name
					Tag       = $item.GUID
					add_Click = $UI_Main_Extract_Rule_Select_SourcestClick
				}

				$UI_Main_Rule_Details_View = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 30
					Width          = 460
					Padding        = "36,0,0,0"
					Margin         = "0,0,0,5"
					Text           = $lang.Detailed_View
					Tag            = $item.GUID
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						InBox_Apps_Del_Rule_Details_View -GUID $this.Tag
					}
				}

				$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange((
					$CheckBox,
					$UI_Main_Rule_Details_View
				))

				if ($item.InboxApps.Rule.Count -gt 0) {
					if ($GetDefaultSelectLabel -eq $item.GUID) {
						$CheckBox.Checked = $True
					}
				} else {
					$CheckBox.Enabled = $False
				}
			}
		} else {
			$UI_Main_Extract_Customize_Rule_Tips = New-Object system.Windows.Forms.Label -Property @{
				AutoSize       = 1
				Padding        = "18,0,0,0"
				Text           = $lang.RuleCustomizeTips
			}
			$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange($UI_Main_Extract_Customize_Rule_Tips)
		}
	} else {
		$UI_Main_Extract_Customize_Rule_Tips_Not = New-Object system.Windows.Forms.Label -Property @{
			AutoSize       = 1
			Padding        = "18,0,0,0"
			Text           = $lang.RuleCustomizeNot
		}
		$UI_Main_Extract_Rule_Select_Sourcest.controls.AddRange($UI_Main_Extract_Customize_Rule_Tips_Not)
	}

	if (InBox_Apps_Delete_Check_Match_Customize -RuleNaming) {
		InBox_Apps_Refresh_Rule_Match_Delete
	}

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUIGroupUWPAddMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUIGroupUWPAddMenu.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Extract_Rule_Select_Apps.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUIGroupUWPAddMenu.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Extract_Rule_Select_Apps.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_Extract_Rule_Select_Apps.ContextMenuStrip = $GUIGroupUWPAddMenu

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.QueueMode), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))
	} else {
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

Function InBox_Apps_Delete_Check_Match_Customize
{
	param
	(
		[switch]$RuleNaming,
		[switch]$SelectApps
	)

	$UI_Main_Error.Text = ""
	$UI_Main_Error_Icon.Image = $null
	
	$MarkCheckedRuleNaming = $False
	$MarkCheckedSelectApps = $False

	$Script:QueueInboxAppsDeleteSelect = @()

	<#
		.检查是否选择规则命名
	#>
	if ($RuleNaming) {
		$UI_Main_Extract_Rule_Select_Sourcest.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.RadioButton]) {
				if ($_.Checked) {
					$MarkCheckedRuleNaming = $True
					$Global:InBoxAppsSearchRuleSelected = $_.Tag
					Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_SelectGUID" -value $_.Tag -String
				}
			}
		}

		if ($MarkCheckedRuleNaming) {
		} else {
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
			$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) ( $($lang.RulePre) )"
			return
		}
	}

	<#
		.检查是否勾先应用程序
	#>
	if ($SelectApps) {
			$UI_Main_Extract_Rule_Select_Apps.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$MarkCheckedSelectApps = $True
							$Script:QueueInboxAppsDeleteSelect += @{
								Name = $_.Text;
								Rule = $_.Tag
							}
						}
					}
				}
			}

		if ($MarkCheckedSelectApps) {
			<#
				.已选择状态，保存到注册表
			#>
			$TempSaveInboxAppsDeleteSelect = @()
			ForEach ($item in $Script:QueueInboxAppsDeleteSelect) {
				$TempSaveInboxAppsDeleteSelect += $item.Name
			}

			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -name "$(Get_GPS_Location)_Match_Delete_UWP" -value $TempSaveInboxAppsDeleteSelect -Multi
		} else {
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
			$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) ( $($lang.InstallUWP) )"
			return
		}
	}

	return $True
}

<#
	.删除 UWP 预安装应用
#>
Function InBox_Apps_Match_Delete_Process
{
	<#
		.初始化，获取预安装 UWP 应用
	#>
	$InitlUWPPreDeleteSelectPakcage = @()
	$InitlUWPPreDeleteSelectPakcageDelete = @()

	ForEach ($item in $Script:QueueInboxAppsDeleteSelect) {
		Write-Host "   $($lang.RuleName): " -NoNewline
		Write-host $item.Name -ForegroundColor Green
		
		Write-host "   $($lang.RuleFileFind): " -NoNewline
		Write-host $item.Rule -ForegroundColor Green

		Write-host ""
	}

	Write-Host "   $($lang.GetImageUWP)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	try {
		if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
			Write-Host "`n   $($lang.Command)" -ForegroundColor Green
			Write-host "   $($lang.Developers_Mode_Location)53" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			write-host "   Get-AppxProvisionedPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount""" -ForegroundColor Green
			Write-host "   $('-' * 80)`n"
		}

		Get-AppxProvisionedPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
    		$InitlUWPPreDeleteSelectPakcage += $_.PackageName
			Write-Host "   $($_.PackageName)"
		}
	} catch {
		Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
		Write-Host "   $($_)" -ForegroundColor Yellow
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		return
	}

	ForEach ($item in $InitlUWPPreDeleteSelectPakcage) {
		ForEach ($WildCard in $Script:QueueInboxAppsDeleteSelect.Rule) {
			if ($item -like "*$($WildCard)*") {
				$InitlUWPPreDeleteSelectPakcageDelete += $item
			}
		}
	}

	Write-Host "`n   $($lang.LXPsWaitRemove)" -ForegroundColor Green
	Write-host "   $('-' * 80)"
	if ($InitlUWPPreDeleteSelectPakcageDelete.count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $InitlUWPPreDeleteSelectPakcageDelete) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $InitlUWPPreDeleteSelectPakcageDelete) {
			Write-Host "   $($item)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			
			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				try {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)55" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Remove-AppxProvisionedPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -PackageName ""$($item)""" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}

					Remove-AppxProvisionedPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Remove-AppxProvisionedPackage.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PackageName $item -ErrorAction SilentlyContinue | Out-Null
					Write-Host $lang.Done -ForegroundColor Green
				} catch {
					Write-Host $lang.SelectFromError -ForegroundColor Red
					Write-Host "   $($_)" -ForegroundColor Yellow
					Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
				}
			} else {
				Write-Host $lang.SelectFromError -ForegroundColor Red
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			Write-Host ""
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}