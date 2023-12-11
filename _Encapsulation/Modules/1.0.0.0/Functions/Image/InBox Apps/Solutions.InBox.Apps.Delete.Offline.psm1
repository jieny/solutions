<#
	.Delete: delete inbox Apps by matching rules
	.删除：离线删除 inbox Apps
#>
Function InBox_Apps_Offline_Delete_UI
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $lang.InboxAppsOfflineDel
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
			InBox_Apps_Offline_Delete_UI
		}

		Image_Get_Mount_Status
	}

	Write-Host "`n   $($lang.InboxAppsOfflineDel)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Function InBox_Apps_Refresh_Offline_Install_UWP
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		
		$UI_Main_Refresh_Sources.Enabled = $False
		$UI_Main_Menu.controls.Clear()
		$Script:QueueInboxAppsOfflineDeleteSelect = @()

		try {
			Get-AppXProvisionedPackage -path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue | ForEach-Object {
				$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
					Height    = 40
					Width     = 450
					Text      = $_.DisplayName
					Tag       = $_.PackageName
					add_Click = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}

				$UI_Main_Menu.controls.AddRange($CheckBox)
			}

			$UI_Main_Refresh_Sources.Enabled = $True
		} catch {
			$UI_Main_Menu.Enabled = $False
			$UI_Main_Refresh_Sources.Enabled = $False
			$UI_Main_OK.Enabled = $False

			Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.GetImageUWP), $($lang.Inoperable)" -ForegroundColor Red
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
		Width          = 876
		Text           = $lang.InboxAppsOfflineDel
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.依赖项
	#> 
	$UI_Main_Select_Apps_Name = New-Object system.Windows.Forms.Label -Property @{
		Location       = "10,10"
		Height         = 30
		Width          = 500
		Text           = $lang.InstallUWP
	}
	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 635
		Width          = 500
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $true
		Padding        = "14,0,8,0"
		Location       = '10,35'
	}

	$UI_Main_Refresh_Sources = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "570,10"
		Height         = 36
		Width          = 280
		Text           = $lang.Refresh
		add_Click      = {
			InBox_Apps_Refresh_Offline_Install_UWP

			$UI_Main_Error.Text = "$($lang.Refresh), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
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
			Event_Need_Mount_Global_Variable -DevQueue "15" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
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
		Location       = "570,563"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "595,565"
		Height         = 30
		Width          = 255
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "570,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			<#
				.Reset selected
				.重置已选择
			#>
			$Script:QueueInboxAppsOfflineDeleteSelect = @()
	
			<#
				.Mark: Check the selection status
				.标记：检查选择状态
			#>
			$FlagCheckSelectStatus = $False
	
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			$UI_Main_Menu.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$FlagCheckSelectStatus = $True
							$Script:QueueInboxAppsOfflineDeleteSelect += $_.Tag
						}
					}
				}
			}		
	
			<#
				.Verification mark: check selection status
				.验证标记：检查选择状态
			#>
			if ($FlagCheckSelectStatus) {
				$UI_Main.Hide()
				New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Mount_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
	
				ForEach ($item in $Script:QueueInboxAppsOfflineDeleteSelect) {
					Write-Host "   $($item)"
				}
	
				if ($UI_Main_Suggestion_Not.Checked) {
					Init_Canel_Event -All
				}
				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose)"
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
	
			New-Variable -Scope global -Name "Queue_Is_InBox_Apps_Mount_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			$Script:QueueInboxAppsOfflineDeleteSelect = @()
	
			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Select_Apps_Name,
		$UI_Main_Menu,
		$UI_Main_Refresh_Sources,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	InBox_Apps_Refresh_Offline_Install_UWP

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
	.删除 UWP 预安装应用
#>
Function InBox_Apps_Offline_Delete_Process
{
	if ($Script:QueueInboxAppsOfflineDeleteSelect.count -gt 0) {
		Write-Host "   $($lang.LXPsWaitRemove)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:QueueInboxAppsOfflineDeleteSelect) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Script:QueueInboxAppsOfflineDeleteSelect) {
			Write-Host "   $($item)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline

			if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				try {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)56" -ForegroundColor Green
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