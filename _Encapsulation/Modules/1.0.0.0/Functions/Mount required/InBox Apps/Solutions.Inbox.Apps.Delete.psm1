<#
	.:ocal language experience pack ( LXPs ): Remove
	.本地语言体验包 ( LXPs ): 删除
#>
Function InBox_Apps_Remove_UI
{
	param (
		[array]$Autopilot
	)

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

	Function Refres_Event_Tasks_InBox_Apps_Del_UI
	{
		<#
			.验证是否有任务
		#>
		$Temp_LXPs_Delete = (Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
		if ($Temp_LXPs_Delete.Count -gt 0) {
			$UI_Main_Dashboard_Event_Clear.Text = "$($lang.YesWork), $($lang.EventManagerCurrentClear)"
			$UI_Main_Dashboard_Event_Status.Text = "$($lang.EventManager): $($lang.Enable)"
		} else {
			$UI_Main_Dashboard_Event_Clear.Text = $lang.EventManagerNo
			$UI_Main_Dashboard_Event_Status.Text = "$($lang.EventManager): $($lang.Disable)"
		}
	}

	$UI_Main_Event_Clear_Click = {
		New-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

		Refres_Event_Tasks_InBox_Apps_Del_UI

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		$UI_Main_Error.Text = "$($lang.EventManagerCurrentClear), $($lang.Done)"
	}

	Function Autopilot_InBox_Apps_Remove_UI_Save
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null

		$Temp_InBox_Apps_Wait_Delete = @()

		<#
			.等待删除本地语言体验包（LXPs）
		#>
		$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					if ($_.Checked) {
						$Temp_InBox_Apps_Wait_Delete += $_.Tag
					}
				}
			}
		}

		<#
			.Verification mark: check selection status
			.验证标记：检查选择状态
		#>
		if ($Temp_InBox_Apps_Wait_Delete.Count -gt 0) {
			New-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_InBox_Apps_Wait_Delete -Force

			Refres_Event_Tasks_InBox_Apps_Del_UI

			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
			$UI_Main_Error.Text = "$($lang.Save), $($lang.Done)"
			return $true
		} else {
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
			$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose) ( $($lang.LXPsWaitRemove) )"
			return $False
		}
	}

	Function InBox_Apps_Refresh_Remove
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$UI_Main_Is_Wait_Del.controls.Clear()

		$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
		$Temp_Assign_Task_Select = $Temp_Assign_Task_Select | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

		$Region = Language_Region
		ForEach ($itemRegion in $Region) {
			$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
				Height    = 55
				Width     = 510
				Text      = "$($itemRegion.Name)`n$($itemRegion.Region)"
				Tag       = "$($itemRegion.Region)"
			}

			if ($Temp_Assign_Task_Select -Contains $itemRegion.Region) {
				$CheckBox.Checked = $True
			} else {
				$CheckBox.Checked = $False
			}

			$UI_Main_Is_Wait_Del.controls.AddRange($CheckBox)
		}
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
        Height         = 720
        Width          = 928
		Text           = "$($lang.LocalExperiencePackTips): $($lang.Del)"
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
		.待删除
	#>
	$UI_Main_Wait_Del = New-Object system.Windows.Forms.Label -Property @{
		Height         = 35
		Width          = 530
		margin         = "0,35,0,0"
		Text           = $lang.LXPsWaitRemove
	}
	$UI_Main_Is_Wait_Del = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Padding        = "16,0,0,0"
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
	}

	$UI_Main_Dashboard = New-Object system.Windows.Forms.Label -Property @{
		Height         = 35
		Width          = 530
		Location       = "620,230"
		Text           = $lang.Dashboard
	}
	$UI_Main_Dashboard_Event_Status = New-Object system.Windows.Forms.Label -Property @{
		Height         = 35
		Width          = 530
		Padding        = "16,0,0,0"
		Location       = "620,265"
		Text           = "$($lang.EventManager): $($lang.Failed)"
	}
	$UI_Main_Dashboard_Event_Clear = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 530
		Location       = "620,300"
		Text           = $lang.EventManagerCurrentClear
		Padding        = "32,0,0,0"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Event_Clear_Click
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
			Event_Need_Mount_Global_Variable -DevQueue "822" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
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
		Location       = '620,503'
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = '645,505'
		Height         = 45
		Width          = 255
		Text           = ""
	}

	$UI_Main_Event_Clear = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,555"
		Height         = 36
		Width          = 280
		Text           = $lang.EventManagerCurrentClear
		add_Click      = $UI_Main_Event_Clear_Click
	}
	$UI_Main_Save      = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,595"
		Height         = 36
		Width          = 280
		Text           = $lang.Save
		add_Click      = {
			if (Autopilot_InBox_Apps_Remove_UI_Save) {

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

			if (-not $Global:AutopilotMode -xor $Global:EventQueueMode) {
				Write-Host "   $($lang.UserCancel)" -ForegroundColor Red

				Write-Host "`n   $($lang.LXPsWaitAddUpdate)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Update_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if ($Temp_Assign_Task_Select.count -gt 0) {
					ForEach ($item in $Temp_Assign_Task_Select) {
						Write-Host "   $($item)" -ForegroundColor Green
					}
				} else {
					Write-Host "   $($lang.NoWork)" -ForegroundColor Red
				}

				Write-Host "`n   $($lang.LXPsWaitRemove)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if ($Temp_Assign_Task_Select.count -gt 0) {
					ForEach ($item in $Temp_Assign_Task_Select) {
						Write-Host "   $($item)" -ForegroundColor Green
					}
				} else {
					Write-Host "   $($lang.NoWork)" -ForegroundColor Red
				}
			}

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_Event_Clear,
		$UI_Main_Save,
		$UI_Main_Canel
	))
	$UI_Main_Menu.controls.AddRange((
		$UI_Main_Dashboard,
		$UI_Main_Dashboard_Event_Status,
		$UI_Main_Dashboard_Event_Clear,
		$UI_Main_Wait_Del,
		$UI_Main_Is_Wait_Del
	))

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
	Refres_Event_Tasks_InBox_Apps_Del_UI

	if ($Global:AutopilotMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Autopilot), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
	}

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.OnDemandPlanTask), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))
	}

	if (-not $Global:AutopilotMode -xor $Global:EventQueueMode) {
		Write-Host "`n   $($lang.LocalExperiencePackTips): $($lang.Del)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
	
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


	if ($Autopilot) {
		Write-host "   $($lang.Autopilot)" -ForegroundColor Green
		Write-host "   $('-' * 80)"
		Write-host "   $($lang.Save)".PadRight(18) -NoNewline -ForegroundColor Yellow

		$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($Autopilot.Region -contains $_.Tag) {
					$_.Checked = $True
				} else {
					$_.Checked = $False
				}
			}
		}

		if (Autopilot_InBox_Apps_Remove_UI_Save) {
			Write-host $lang.Done -ForegroundColor Green
		} else {
			Write-host $lang.ISOCreateFailed -ForegroundColor Red
			$UI_Main.ShowDialog() | Out-Null
		}
	} else {
		$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
		$Temp_Assign_Task_Select = $Temp_Assign_Task_Select | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

		$UI_Main_Is_Wait_Del.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				write-host $_.Tag
				if ($Temp_Assign_Task_Select -contains $_.Tag) {
					$_.Checked = $True
				} else {
					$_.Checked = $False
				}
			}
		}

		$UI_Main.ShowDialog() | Out-Null
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

	$Temp_LXPs_Delete = (Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	$Temp_LXPs_Delete = $Temp_LXPs_Delete | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

	if ($Temp_LXPs_Delete.Count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_LXPs_Delete) {
			Write-Host "   $($item)" -ForegroundColor Yellow
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_LXPs_Delete) {
			$New_wait_delete_match = @()

			Write-Host "   $($item)".PadRight(28) -NoNewline -ForegroundColor Yellow
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline

			if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
				try {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)61" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Get-AppXProvisionedPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" | Where-Object DisplayName -Like ""*LanguageExperiencePack*$($item)*"" | Remove-AppxProvisionedPackage" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}

					Get-appxprovisionedpackage -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | where-object {
						if ($_.packagename –like "*LanguageExperiencePack*$($item)*") {
							$New_wait_delete_match += $_.packagename
						}
					}

					if ($New_wait_delete_match.count -gt 0) {
						Write-Host "`n   $($lang.YesWork)" -ForegroundColor Yellow
						Write-host "   $('-' * 80)"
						foreach ($itemnew in $New_wait_delete_match) {
							InBox_Apps_LIPs_Delete_Process_add -packnewname $itemnew
						}
					} else {
						Write-Host $lang.NoWork -ForegroundColor Red
					}
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

<#
	.删除本地语言体验包
#>
Function InBox_Apps_LIPs_Delete_Process_add
{
	param (
		$packnewname
	)

	Write-Host "   $($packnewname)"
	Write-Host "   $($lang.Del)".PadRight(28) -NoNewline

	try {
		Remove-AppxProvisionedPackage -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PackageName $packnewname -ErrorAction SilentlyContinue | Out-Null
		Write-Host $lang.Done -ForegroundColor Green
	}
	catch {
		Write-Host "   $($lang.Failed)" -ForegroundColor Red
	}
}