Function Feature_Enabled_UI
{
	Write-Host "`n   $($lang.WindowsFeature): $($lang.Enable)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	<#
		.所有文件
	#>
	$Script:Init_Feature_All_Enabled = @()
	$Script:Init_Feature_All_Disable = @()

	$Script:Init_Feature_Add_Queue = @()

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Function Refresh_Wait_Add_Enabled_List
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		
		$UI_Main_Wait_Add.Controls.clear()
		$UI_Main_Wait_Add_Name.Text = "$($lang.YesWork) ( $($Script:Init_Feature_Add_Queue.Count) $($lang.EventManagerCount) )"

		if ($Script:Init_Feature_Add_Queue.Count -gt 0) {
			foreach ($item in $Script:Init_Feature_Add_Queue) {
				$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
					Height    = 35
					Width     = 465
					Text      = $item
					Tag       = $item
					Checked   = $True
					add_Click = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}

				$UI_Main_Wait_Add.controls.AddRange($CheckBox)
			}
		} else {
			$UI_Main_Other_Rule_Not_Find = New-Object system.Windows.Forms.Label -Property @{
				Height         = 40
				Width          = 465
				Padding        = "0,0,0,0"
				Text           = $lang.NoWork
			}
			$UI_Main_Wait_Add.controls.AddRange($UI_Main_Other_Rule_Not_Find)
		}
	}

	Function Enable_Select_Refresh_List
	{
		$UIUnzip_Search_Sift_Custon.BackColor = "#FFFFFF"

		<#
			.重置：映像源显示区域
		#>
		$UI_Main_Menu.controls.Clear()

		<#
			.已匹配成功的启用
		#>
		$Script:Init_Feature_All_Enabled_Match_Done = @()

		<#
			.已匹配成功的启用
		#>
		$Script:Init_Feature_All_Disable_Match_Done = @()

		<#
			.搜索功能
		#>
		<#
			.判断是否空白
		#>
		if ([string]::IsNullOrEmpty($UIUnzip_Search_Sift_Custon.Text)) {
			$Script:Init_Feature_All_Enabled_Match_Done = $Script:Init_Feature_All_Enabled
			$Script:Init_Feature_All_Disable_Match_Done = $Script:Init_Feature_All_Disable
		} else {
			<#
				.Judgment: 2. The prefix cannot contain spaces
				.判断：2. 前缀不能带空格
			#>
			if ($UIUnzip_Search_Sift_Custon.Text -match '^\s') {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISO9660TipsErrorSpace))"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}
		
			<#
				.Judgment: 3. Suffix cannot contain spaces
				.判断：3. 后缀不能带空格
			#>
			if ($UIUnzip_Search_Sift_Custon.Text -match '\s$') {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISO9660TipsErrorSpace))"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}
		
			<#
				.Judgment: 4. The suffix cannot contain multiple spaces
				.判断：4. 后缀不能带多空格
			#>
			if ($UIUnzip_Search_Sift_Custon.Text -match '\s{2,}$') {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISO9660TipsErrorSpace))"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}
		
			<#
				.Judgment: 5. There can be no two spaces in between
				.判断：5. 中间不能含有二个空格
			#>
			if ($UIUnzip_Search_Sift_Custon.Text -match '\s{2,}') {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISO9660TipsErrorSpace))"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}
		
			<#
				.Judgment: 6. Cannot contain: \\ /: *? "" <> |
				.判断：6, 不能包含：\\ / : * ? "" < > |
			#>
			if ($UIUnzip_Search_Sift_Custon.Text -match '[~#$@!%&*{}<>?/|+"]') {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISO9660TipsErrorOther))"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}
			<#
				.Judgment: 7. No more than 260 characters
				.判断：7. 不能大于 260 字符
			#>
			if ($UIUnzip_Search_Sift_Custon.Text.length -gt 260) {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.ISOLengthError -f "260")"
				$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
				return
			}

			<#
				.1、自定义筛选：启用
			#>
			ForEach ($WildCard in $Script:Init_Feature_All_Enabled) {
				$NewFileName = [IO.Path]::GetFileName($WildCard)

				if ($NewFileName -like "*$($UIUnzip_Search_Sift_Custon.Text)*") {
					$Script:Init_Feature_All_Enabled_Match_Done += $WildCard
				}
			}

			<#
				.2、自定义筛选：禁用
			#>
			ForEach ($WildCard in $Script:Init_Feature_All_Disable) {
				$NewFileName = [IO.Path]::GetFileName($WildCard)

				if ($NewFileName -like "*$($UIUnzip_Search_Sift_Custon.Text)*") {
					$Script:Init_Feature_All_Disable_Match_Done += $WildCard
				}
			}
		}

		<#
			.添加控件：启用
		#>
		$UI_Main_Pre_Rule  = New-Object system.Windows.Forms.Label -Property @{
			Height         = 40
			Width          = 465
			Text           = "$($lang.Enable) ( $($Script:Init_Feature_All_Disable_Match_Done.Count) $($lang.EventManagerCount) )"
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Pre_Rule)

		if ($Script:Init_Feature_All_Disable_Match_Done.count -gt 0) {
			ForEach ($item in $Script:Init_Feature_All_Disable_Match_Done) {
				$CheckBox          = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 40
					Width          = 465
					Text           = $item
					Tag            = $item
					Padding        = "18,0,0,0"
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
						
						if ($Script:Init_Feature_Add_Queue -contains $this.Tag) {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.Existed): $($this.Tag)"
						} else {
							$Script:Init_Feature_Add_Queue += $this.tag
							Refresh_Wait_Add_Enabled_List

							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
							$UI_Main_Error.Text = "$($lang.AddTo): $($this.Tag), $($lang.Done)"
						}
					}
				}

				$UI_Main_Menu.controls.AddRange($CheckBox)
			}
		} else {
			$UI_Main_Pre_Rule_Not_Find = New-Object system.Windows.Forms.Label -Property @{
				autosize = 30
				Padding  = "18,0,0,0"
				Text     = $lang.NoWork
			}
			$UI_Main_Menu.controls.AddRange($UI_Main_Pre_Rule_Not_Find)
		}

		$UI_Add_End_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height       = 30
			Width        = 435
		}
		$UI_Main_Menu.controls.AddRange($UI_Add_End_Wrap)

		<#
			.添加控件：禁用
		#>
		$UI_Main_Pre_Rule  = New-Object system.Windows.Forms.Label -Property @{
			Height         = 40
			Width          = 465
			Text           = "$($lang.Disable) ( $($Script:Init_Feature_All_Enabled_Match_Done.Count) $($lang.EventManagerCount) )"
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Pre_Rule)

		if ($Script:Init_Feature_All_Enabled_Match_Done.count -gt 0) {
			ForEach ($item in $Script:Init_Feature_All_Enabled_Match_Done) {
				$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
					Height    = 35
					Width     = 465
					Padding   = "18,0,0,0"
					Text      = $item
					Tag       = $item
					Enabled   = $False
					add_Click = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}

				$UI_Main_Menu.controls.AddRange($CheckBox)
			}
		} else {
			$UI_Main_Pre_Rule_Not_Find = New-Object system.Windows.Forms.Label -Property @{
				autosize = 30
				Padding  = "18,0,0,0"
				Text     = $lang.NoWork
			}
			$UI_Main_Menu.controls.AddRange($UI_Main_Pre_Rule_Not_Find)
		}

		$UI_Add_End_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height       = 30
			Width        = 435
		}
		$UI_Main_Menu.controls.AddRange($UI_Add_End_Wrap)

		Refresh_Wait_Add_Enabled_List
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
		Width          = 876
		Text           = "$($lang.WindowsFeature): $($lang.Enable)"
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.等待添加项
	#>
	$UI_Main_Wait_Add_Name  = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 465
		Location       = '15,15'
		Text           = ""
	}
	$UI_Main_Wait_Add  = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 200
		Width          = 500
		BorderStyle    = 0
		autoSizeMode   = 1
		autoScroll     = $True
		Padding        = "15,0,0,0"
		Location       = '15,45'
	}
	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$UI_Main_Wait_Add_Select = New-Object System.Windows.Forms.ContextMenuStrip
	$UI_Main_Wait_Add_Select.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Wait_Add.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$UI_Main_Wait_Add_Select.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Wait_Add.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_Wait_Add.ContextMenuStrip = $UI_Main_Wait_Add_Select

	$UI_Other_Path_Clear_Select = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 365
		Padding        = "14,0,0,0"
		Location       = '15,265'
		Text           = "$($lang.Del), $($lang.Choose)"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$Script:Init_Feature_Add_Queue = @()

			$UI_Main_Wait_Add.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Checked) {
					} else {
						$Script:Init_Feature_Add_Queue += $_.Text
					}
				}
			}

			Refresh_Wait_Add_Enabled_List

			$UI_Main_Error.Text = "$($lang.Del), $($lang.Choose), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		}
	}

	$UI_Other_Path_Clear = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 40
		Width          = 365
		Padding        = "14,0,0,0"
		Location       = '15,305'
		Text           = $lang.AllClear
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$Script:Init_Feature_Add_Queue = @()
			Refresh_Wait_Add_Enabled_List

			$UI_Main_Error.Text = "$($lang.AllClear), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		}
	}

	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 315
		Width          = 500
		Location       = '10,365'
		BorderStyle    = 0
		autoScroll     = $True
		Padding        = "15,10,0,0"
	}

	<#
		.End on-demand mode
		.结束按需模式
	#>
	$UI_Main_Suggestion_Manage = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignSetting
		Location       = '570,395'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 415
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '570,425'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "11" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '570,455'
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
		Location       = '570,390'
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
		Location       = '586,426'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '586,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "570,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "595,525"
		Height         = 60
		Width          = 225
		Text           = ""
	}

	<#
		.搜索或匹配
	#>
	$UIUnzipPanelRefresh = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "570,10"
		Height         = 36
		Width          = 280
		Text           = $lang.LanguageExtractSearch
		add_Click      = { Enable_Select_Refresh_List }
	}

	$UIUnzip_Search_Sift = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 240
		Location       = "575,60"
		Text           = $lang.LanguageExtractRuleFilter
	}
	$UIUnzip_Search_Sift_Custon = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 250
		Location       = "590,90"
		Text           = ""
		add_Click      = {
			$This.BackColor = "#FFFFFF"
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "570,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			New-Variable -Scope global -Name "Queue_Is_Feature_Enable_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Feature_Enable_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			<#
				.初始化临时保存的选择
			#>
			$Temp_Queue_Is_Feature_Enable_Select = @()
			$UI_Main_Wait_Add.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Temp_Queue_Is_Feature_Enable_Select += $_.Tag
						}
					}
				}
			}

			<#
				.Verification mark: check selection status
				.验证标记：检查选择状态
			#>
			if ($Temp_Queue_Is_Feature_Enable_Select.Count -gt 0) {
				$UI_Main.Hide()
				New-Variable -Scope global -Name "Queue_Is_Feature_Enable_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				New-Variable -Scope global -Name "Queue_Is_Feature_Enable_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Queue_Is_Feature_Enable_Select -Force

				ForEach ($item in $Temp_Queue_Is_Feature_Enable_Select) {
					Write-Host "   $($item)"
				}

				if ($UI_Main_Suggestion_Not.Checked) {
					Init_Canel_Event -All
				}
				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose)"
				return
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "570,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			New-Variable -Scope global -Name "Queue_Is_Feature_Enable_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Feature_Enable_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Wait_Add_Name,
		$UI_Main_Wait_Add,
		$UI_Other_Path_Clear_Select,
		$UI_Other_Path_Clear,
		$UI_Main_Menu,
		$UIUnzipPanelRefresh,
		$UIUnzip_Search_Sift,
		$UIUnzip_Search_Sift_Custon,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	Get-WindowsOptionalFeature -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
		if ($_.State -eq "Enabled") {
			$Script:Init_Feature_All_Enabled += $_.FeatureName
		}
	
		if ($_.State -eq "Disabled") {
			$Script:Init_Feature_All_Disable += $_.FeatureName
		}
	}
	Enable_Select_Refresh_List

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$UI_Main_Menu_Select = New-Object System.Windows.Forms.ContextMenuStrip
	$UI_Main_Menu_Select.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Menu.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$UI_Main_Menu_Select.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Menu.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_Menu.ContextMenuStrip = $UI_Main_Menu_Select

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

<#
	.Windows 功能：处理启用项
#>
Function Feature_Enabled_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = "$($lang.WindowsFeature): $($lang.Enable)"
	}

	$Temp_Queue_Is_Feature_Enable_Custom_Select = (Get-Variable -Scope global -Name "Queue_Is_Feature_Enable_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	if ($Temp_Queue_Is_Feature_Enable_Custom_Select.count -gt 0) {
		Write-Host "   $($lang.YesWork)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Queue_Is_Feature_Enable_Custom_Select) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		ForEach ($item in $Temp_Queue_Is_Feature_Enable_Custom_Select) {
			Write-Host "   $($item)"
			Write-Host "   $($lang.Enable)".PadRight(28) -NoNewline
			try {
				if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows" -PathType Container) {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "`n   $($lang.Developers_Mode_Location)2236" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Enable-WindowsOptionalFeature -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -FeatureName ""$($item)"" -Source ""$($Global:Image_source)\sources\sxs"", ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows"" -All -LimitAccess" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}
	
					Enable-WindowsOptionalFeature -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -FeatureName $item -Source "$($Global:Image_source)\sources\sxs", "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows" -All -LimitAccess | Out-Null
				} else {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)2237" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Enable-WindowsOptionalFeature -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -FeatureName ""$($item)"" -Source ""$($Global:Image_source)\sources\sxs"" -All -LimitAccess" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}
	
					Enable-WindowsOptionalFeature -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -FeatureName $item -Source "$($Global:Image_source)\sources\sxs" -All -LimitAccess | Out-Null
				}
				Write-Host "   $($lang.Done)" -ForegroundColor Green
			} catch {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			Write-Host
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}