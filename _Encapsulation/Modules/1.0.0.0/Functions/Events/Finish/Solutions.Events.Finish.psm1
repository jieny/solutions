<#
	.When an event is available
	.如果有可用事件时
#>
Function Event_Completion_Setting_UI
{
	Write-Host "`n   $($lang.AfterFinishingNotExecuted)" -ForegroundColor Yellow
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
		Width          = 668
		Text           = $lang.AfterFinishingNotExecuted
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.完成后显示区域
	#>
	$UI_Main_Not_Executed = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AfterFinishingNotExecuted
		Location       = '15,15'
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($this.Checked) {
				$UI_Main_After_Finishing.Enabled = $False
			} else {
				$UI_Main_After_Finishing.Enabled = $True
			}
		}
	}
	$UI_Main_After_Finishing = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 625
		Width          = 280
		autoSizeMode   = 1
		Padding        = "15,0,0,0"
		Location       = '15,50'
	}
	$UI_Main_After_Finishing_Pause = New-Object System.Windows.Forms.RadioButton -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.AfterFinishingPause
		Tag            = "2"
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_After_Finishing_Reboot = New-Object System.Windows.Forms.RadioButton -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.AfterFinishingReboot
		Tag            = "3"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_After_Finishing_Shutdown = New-Object System.Windows.Forms.RadioButton -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.AfterFinishingShutdown
		Tag            = "4"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
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
		Location       = '360,420'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop_Current = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 415
		Text           = "$($lang.AssignEndCurrent -f $Global:Primary_Key_Image.Uid)"
		Location       = '360,450'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			Event_Need_Mount_Global_Variable -DevQueue "2" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
			Event_Reset_Suggest
			$UI_Main.Close()
		}
	}
	$UI_Main_Event_Assign_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '360,480'
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
		Width          = 280
		Text           = $lang.SuggestedSkip
		Location       = '360,415'
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
		Location       = '376,451'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Event_Assign_Setting }
	}
	$UI_Main_Suggestion_Stop = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.AssignForceEnd
		Location       = '376,480'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = $UI_Main_Suggestion_Stop_Click
	}

	<#
		.Note
		.注意
	#>
	$UI_Main_Tips      = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 320
		Width          = 270
		BorderStyle    = 0
		Location       = "360,20"
		Text           = $lang.WaitTimeTips
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "360,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "385,525"
		Height         = 60
		Width          = 255
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "360,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			<#
				.Reset selected
				.重置已选择
			#>
			$Global:IsFinish = $False
			$SelectEveveLevel = @()

			$UI_Main_After_Finishing.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.RadioButton]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$SelectEveveLevel += @{
								EventName = $_.Text
								EventID   = $_.Tag
							}
						}
					}
				}
			}

			<#
				.Verification mark: check selection status
				.验证标记：检查选择状态
			#>
			if ($SelectEveveLevel.Count -gt 0) {
				$UI_Main.Hide()
				$Global:IsFinish = $True
				Write-Host "`n 8888  $($lang.AfterFinishingNotExecuted)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				Write-Host "   $($SelectEveveLevel.EventName)" -ForegroundColor Green

				if ($Global:EventQueueMode) {
					$EventMaps = "Queue"
				} else {
					$EventMaps = "Assign"
				}
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AllowAfterFinishing" -value "True" -String
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AfterFinishing" -value "$($SelectEveveLevel.EventID)" -String
				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose)"
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "360,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red

			$Global:IsFinish = $True
			if ($Global:EventQueueMode) {
				$EventMaps = "Queue"
			} else {
				$EventMaps = "Assign"
			}

			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AllowAfterFinishing" -value "True" -String
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AfterFinishing" -value "2" -String

			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Tips,
		$UI_Main_Not_Executed,
		$UI_Main_After_Finishing,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	$UI_Main_After_Finishing.controls.AddRange((
		$UI_Main_After_Finishing_Pause,
		$UI_Main_After_Finishing_Reboot,
		$UI_Main_After_Finishing_Shutdown
	))

	if ($Global:EventQueueMode) {
		$UI_Main.Text = "$($UI_Main.Text) [ $($lang.QueueMode), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		$UI_Main.controls.AddRange((
			$UI_Main_Suggestion_Manage,
			$UI_Main_Suggestion_Stop_Current,
			$UI_Main_Event_Assign_Stop
		))

		$EventMaps = "Queue"
	} else {
		if (Image_Is_Select_IAB) {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		}

		$EventMaps = "Assign"
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

	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AllowAfterFinishing" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AllowAfterFinishing" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Not_Executed.Checked = $True
				$UI_Main_After_Finishing.Enabled = $False

				<#
					.初始化选择：暂停、重启、关机
				#>
				if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AfterFinishing" -ErrorAction SilentlyContinue) {
					switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AfterFinishing" -ErrorAction SilentlyContinue) {
						2 { $UI_Main_After_Finishing_Pause.Checked = $True }
						3 { $UI_Main_After_Finishing_Reboot.Checked = $True }
						4 { $UI_Main_After_Finishing_Shutdown.Checked = $True }
					}
				} else {
					$UI_Main_After_Finishing_Pause.Checked = $True
				}
			}
			"False" {
				$UI_Main_Not_Executed.Checked = $False
				$UI_Main_After_Finishing.Enabled = $True
				$UI_Main_After_Finishing_Pause.Checked = $True
			}
		}
	} else {
		$UI_Main_Not_Executed.Checked = $False
		$UI_Main_After_Finishing.Enabled = $True
		$UI_Main_After_Finishing_Pause.Checked = $True
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
	.After event processing is complete
	.事件处理完成后
#>
Function Event_Completion_Process
{
	Write-Host "`n   $($lang.AfterFinishingNotExecuted)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	if ($Global:IsFinish) {
		if ($Global:EventQueueMode) {
			$EventMaps = "Queue"
		} else {
			$EventMaps = "Assign"
		}

		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AllowAfterFinishing" -ErrorAction SilentlyContinue) {
			switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AllowAfterFinishing" -ErrorAction SilentlyContinue) {
				"True" {
					if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AfterFinishing" -ErrorAction SilentlyContinue) {
						switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AfterFinishing" -ErrorAction SilentlyContinue) {
							2 {
								Write-Host "   $($lang.AfterFinishingPause)" -ForegroundColor Green
								Get_Next
								Write-Host "   $($lang.Done)`n" -ForegroundColor Green
							}
							3 {
								Write-Host "   $($lang.AfterFinishingReboot)" -ForegroundColor Green
								start-process "timeout.exe" -argumentlist "/t 10 /nobreak" -wait -nonewwindow
								Restart-Computer -Force -ErrorAction SilentlyContinue
								Write-Host "   $($lang.Done)`n" -ForegroundColor Green
							}
							4 {
								Write-Host "   $($lang.AfterFinishingShutdown)" -ForegroundColor Green
								start-process "timeout.exe" -argumentlist "/t 10 /nobreak" -wait -nonewwindow
								Stop-Computer -Force -ErrorAction SilentlyContinue
								Write-Host "   $($lang.Done)`n" -ForegroundColor Green
							}
						}
					}
				}
			}
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}
}