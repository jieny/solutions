<#
	.Components: Cleanup
	.组件：清理
#>
Function Language_Cleanup_Components_UI
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $($lang.OnlyLangCleanup)
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
			Language_Cleanup_Components_UI
		}

		Image_Get_Mount_Status

		<#
			.先决条件
		#>
		<#
			.判断是否选择 Install, Boot, WinRE
		#>
		if (-not (Image_Is_Select_IAB)) {
			Write-Host "`n   $($lang.OnlyLangCleanup)"
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			return
		}

		<#
			.判断挂载合法性
		#>
		if (-not (Verify_Is_Current_Same)) {
			Write-Host "`n   $($lang.OnlyLangCleanup)"
			Write-host "   $('-' * 80)"
			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				Write-Host "   $($lang.MountedIndexError)" -ForegroundColor Red
			} else {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			return
		}
	}

	Write-Host "`n   $($lang.OnlyLangCleanup)" -ForegroundColor Yellow
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

	Function Language_Del_Refresh_Cleanup_Components
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$GUILangCleanupComponentsSelectPanel.controls.Clear()

		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Language" -Name "$(Get_GPS_Location)_CleanupComponents" -ErrorAction SilentlyContinue) {
			$SelectCleanupComponentsLanguage = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Language" -Name "$(Get_GPS_Location)_CleanupComponents"
		} else {
			if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguageRemove" -ErrorAction SilentlyContinue) {
				$SelectCleanupComponentsLanguage = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\InBox" -Name "$(Get_GPS_Location)_SelectLXPsLanguageRemove"
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Language" -name "$(Get_GPS_Location)_CleanupComponents" -value $SelectCleanupComponentsLanguage -Multi
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Language" -name "$(Get_GPS_Location)_CleanupComponents" -value "" -Multi
				$SelectCleanupComponentsLanguage = ""
			}
		}

		$GetSelectCleanupComponentsLanguage = @()
		ForEach ($item in $SelectCleanupComponentsLanguage) {
			$GetSelectCleanupComponentsLanguage += $item
		}

		$Region = Language_Region
		ForEach ($itemRegion in $Region) {
			$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
				Height    = 55
				Width     = 260
				Text      = "$($itemRegion.Region)`n$($itemRegion.Name)"
				Tag       = $($itemRegion.Region)
				add_Click = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null
				}
			}

			if (($GetSelectCleanupComponentsLanguage) -Contains $itemRegion.Region) {
				$CheckBox.Checked = $True
			} else {
				$CheckBox.Checked = $False
			}

			$GUILangCleanupComponentsSelectPanel.controls.AddRange($CheckBox)
		}
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 876
		Text           = $lang.OnlyLangCleanup
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#FFFFFF"
		FormBorderStyle = "Fixed3D"
	}

	$GUILangCleanupComponentsSelectPanel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 665
		Width          = 300
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "16,0,0,0"
		Location       = "8,10"
	}

	<#
		.End on-demand mode
		.结束按需模式
	#>
	$UI_Main_Suggestion_Manage = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignSetting
		Location       = '400,455'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 415
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '400,485'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "20" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '400,515'
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
		Location       = '400,450'
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
		Location       = '416,486'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '416,515'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "402,588"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "427,590"
		Height         = 40
		Width          = 415
		Text           = $lang.OnlyLangCleanupTips
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "400,635"
		Height         = 36
		Width          = 222
		Text           = $lang.OK
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			<#
				.Reset selected
				.重置已选择
			#>
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			$Temp_Queue_Is_Language_Components_Clean_Select = @()
			$GUILangCleanupComponentsSelectPanel.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Temp_Queue_Is_Language_Components_Clean_Select += $_.Tag
						}
					}
				}
			}

			if ($Temp_Queue_Is_Language_Components_Clean_Select.Count -gt 0) {
				New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Queue_Is_Language_Components_Clean_Select -Force
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Language" -name "$(Get_GPS_Location)_CleanupComponents" -value $Temp_Queue_Is_Language_Components_Clean_Select -Multi
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) $($lang.OnlyLangCleanup)"
				return
			}

			$UI_Main.Hide()
			if ((Get-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
				Write-Host "`n   $($lang.OnlyLangCleanup)"
				ForEach ($item in $Temp_Queue_Is_Language_Components_Clean_Select) {
					Write-Host "   $($item)" -ForegroundColor Green
				}
			}

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event -All
			}
			$UI_Main.Close()
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "626,635"
		Height         = 36
		Width          = 222
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$GUILangCleanupComponentsSelectPanel,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	Language_Del_Refresh_Cleanup_Components

	<#
		.Delete language selection: add right-click menu: select all, clear button
		.删除语言选择：添加右键菜单：全选、清除按钮
	#>
	$GUILangCleanupComponentsMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUILangCleanupComponentsMenu.Items.Add($lang.AllSel).add_Click({
		$GUILangCleanupComponentsSelectPanel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUILangCleanupComponentsMenu.Items.Add($lang.AllClear).add_Click({
		$GUILangCleanupComponentsSelectPanel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$GUILangCleanupComponentsSelectPanel.ContextMenuStrip = $GUILangCleanupComponentsMenu

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
	.Cleanup component processing
	.清理组件处理
#>
Function Cleanup_Components_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = $lang.OnlyLangCleanup
	}

	<#
    	.初始化，获取语言
	#>
	$InitlClearLanguagePackage = @()

	$Temp_Queue_Language_Components_Clean_Select = (Get-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	ForEach ($item in $Temp_Queue_Language_Components_Clean_Select) {
		Write-Host "   $($item)" -ForegroundColor Green
	}

	ForEach ($item in $Temp_Queue_Language_Components_Clean_Select) {
		try {
			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)63" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Get-WindowsPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount""" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Get-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
				if ($_.PackageName -like "*$($item)*") {
					$InitlClearLanguagePackage += $_.PackageName
				}
			}
		} catch {
			Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			return
		}
	}

	Write-Host "`n   $($lang.OnlyLangCleanup)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ($InitlClearLanguagePackage.count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
	
		ForEach ($item in $InitlClearLanguagePackage | Sort-Object -Descending) {
			Write-Host "   $($item)" -ForegroundColor Green
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			
			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				try {
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