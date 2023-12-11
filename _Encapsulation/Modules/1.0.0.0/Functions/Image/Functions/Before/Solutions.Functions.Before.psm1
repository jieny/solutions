Function Functions_Before_UI
{
	Write-Host "`n   $($lang.SpecialFunction): $($lang.Functions_Before)" -ForegroundColor Yellow
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

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 1075
		Text           = "$($lang.SpecialFunction): $($lang.Functions_Before)"
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.待分配
	#>
	$UI_Main_Wait_Assign = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 485
		Location       = "15,15"
		Text           = $lang.Functions_Wait_Assign
	}
	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 465
		Width          = 500
		Location       = '0,55'
		Padding        = "31,0,0,0"
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $true
	}

	<#
		.可选功能
	#>
	$UI_Main_Adv       = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 485
		Location       = '15,555'
		Text           = $lang.AdvOption
	}

	<#
		.有重复时不再添加
	#>
	$UI_Main_Functions_Duplicate = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 485
		Location       = '35,585'
		Text           = $lang.Functions_Duplicate
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Functions_Duplicate.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "$(Get_GPS_Location)_Is_Check_Duplicate" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "$(Get_GPS_Location)_Is_Check_Duplicate" -value "False" -String
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "$(Get_GPS_Location)_Is_Check_Duplicate" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "$(Get_GPS_Location)_Is_Check_Duplicate" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Functions_Duplicate.Checked = $True
			}
			"False" {
				$UI_Main_Functions_Duplicate.Checked = $False
			}
		}
	} else {
		$UI_Main_Functions_Duplicate.Checked = $True
	}

	<#
		.添加后自动勾选新增项
	#>
	$UI_Main_Functions_AutoSelect = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 485
		Location       = '35,620'
		Text           = $lang.Functions_AutoSelect
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($UI_Main_Functions_AutoSelect.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "$(Get_GPS_Location)_Is_Check_Auto_Select" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "$(Get_GPS_Location)_Is_Check_Auto_Select" -value "False" -String
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "$(Get_GPS_Location)_Is_Check_Auto_Select" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "$(Get_GPS_Location)_Is_Check_Auto_Select" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Functions_AutoSelect.Checked = $True
			}
			"False" {
				$UI_Main_Functions_AutoSelect.Checked = $False
			}
		}
	} else {
		$UI_Main_Functions_AutoSelect.Checked = $True
	}

	<#
		.选择函数
	#>
	$UI_Main_Select_Function_Name = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 455
		Text           = $lang.Functions_Running_Order
		Location       = '560,15'
	}
	$UI_Main_Select_Function = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 350
		Width          = 485
		Location       = '560,50'
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "16,0,0,0"
	}
	$UI_Main_Select_Function_Tips = New-Object system.Windows.Forms.Label -Property @{
		Location       = "560,420"
		Height         = 50
		Width          = 480
		Text           = $lang.FunctionTips
	}

	<#
		.End on-demand mode
		.结束按需模式
	#>
	$UI_Main_Suggestion_Manage = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 485
		Text           = $lang.AssignSetting
		Location       = '560,495'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 485
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '560,525'
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
		Width          = 485
		Text           = $lang.AssignForceEnd
		Location       = '560,555'
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
		Width          = 485
		Text           = $lang.SuggestedSkip
		Location       = '560,490'
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
		Width          = 485
		Text           = $lang.AssignSetting
		Location       = '576,526'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 485
		Text           = $lang.AssignForceEnd
		Location       = '576,555'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "560,598"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "585,600"
		Height         = 30
		Width          = 460
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "560,635"
		Height         = 36
		Width          = 240
		Text           = $lang.OK
		add_Click      = {
			<#
				.Reset selected
				.重置已选择
			#>
			New-Variable -Scope global -Name "Queue_Functions_Before_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			<#
				.Mark: Check the selection status
				.标记：检查选择状态
			#>
			$TempSelectFunctionQueue = @()
			$UI_Main_Select_Function.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$TempSelectFunctionQueue += $_.Text
						}
					}
				}
			}

			if ($TempSelectFunctionQueue.Count -gt 0) {
				$UI_Main.Hide()
				New-Variable -Scope global -Name "Queue_Functions_Before_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $TempSelectFunctionQueue -Force

				ForEach ($item in $TempSelectFunctionQueue) {
					Write-Host "   $($item)" -ForegroundColor Green
				}

				if ($UI_Main_Suggestion_Not.Checked) {
					Init_Canel_Event -All
				}
				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose)"
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "807,635"
		Height         = 36
		Width          = 240
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			New-Variable -Scope global -Name "Queue_Functions_Before_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force


			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Select_Function_Name,
		$UI_Main_Select_Function,
		$UI_Main_Select_Function_Tips,
		$UI_Main_Wait_Assign,
		$UI_Main_Menu,
		$UI_Main_Adv,
		$UI_Main_Functions_Duplicate,
		$UI_Main_Functions_AutoSelect,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	Get-Command -CommandType Function | ForEach-Object {
		if ($_ -like "Other_Tasks_*") {
			$LinkLabel          = New-Object system.Windows.Forms.LinkLabel -Property @{
				Height         = 45
				Width          = 445
				Text           = $_.Name
				LinkColor      = "GREEN"
				ActiveLinkColor = "RED"
				LinkBehavior   = "NeverUnderline"
				add_Click      = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null
					
					if ($UI_Main_Functions_Duplicate.Checked) {
						$Temp_Get_Select_Function = @()
						$UI_Main_Select_Function.Controls | ForEach-Object {
							if ($_ -is [System.Windows.Forms.CheckBox]) {
								$Temp_Get_Select_Function += $_.Text
							}
						}

						if ($Temp_Get_Select_Function -contains $this.Text) {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.Existed): $($This.Text)"
						} else {
							$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
								Height    = 40
								Width     = 445
								Text      = $this.Text
								add_Click = {
									$UI_Main_Error.Text = ""
									$UI_Main_Error_Icon.Image = $null
								}
							}

							if ($UI_Main_Functions_AutoSelect.Checked) {
								$CheckBox.Checked = $True
							}

							$UI_Main_Select_Function.controls.AddRange($CheckBox)

							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
							$UI_Main_Error.Text = "$($lang.AddTo): $($This.Text), $($lang.Done)"
						}
					} else {
						$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
							Height    = 40
							Width     = 445
							Text      = $this.Text
							add_Click = {
								$UI_Main_Error.Text = ""
								$UI_Main_Error_Icon.Image = $null
							}
						}

						if ($UI_Main_Functions_AutoSelect.Checked) {
							$CheckBox.Checked = $True
						}

						$UI_Main_Select_Function.controls.AddRange($CheckBox)

						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
						$UI_Main_Error.Text = "$($lang.AddTo): $($This.Text), $($lang.Done)"
					}
				}
			}

			$UI_Main_Menu.controls.AddRange($LinkLabel)
		}
	}

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.QueueMode), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"

		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))
	} else {
		if (Image_Is_Select_IAB) {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"

			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				$UI_Main_Menu.Enabled = $True
			} else {
				$UI_Main_Menu.Enabled = $False
			}
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
	}

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$UI_Main_Menu_Select = New-Object System.Windows.Forms.ContextMenuStrip
	$UI_Main_Menu_Select.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Select_Function.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$UI_Main_Menu_Select.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Select_Function.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_Select_Function.ContextMenuStrip = $UI_Main_Menu_Select

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