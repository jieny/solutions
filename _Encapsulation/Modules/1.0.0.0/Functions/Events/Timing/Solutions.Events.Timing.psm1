<#
	.Initial waiting time
	.初始等待时间
#>
$Script:EventWaitTime = 0

<#
	.初始化：分钟
#>
$Script:Init_Wait_Time_Minute = 30

<#
	.等待时间设置界面
	.Waiting time setting interface
#>
Function Event_Completion_Start_Setting_UI
{
	Write-Host "`n   $($lang.WaitTimeTitle)" -ForegroundColor Yellow
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
		Text           = $lang.WaitTimeTitle
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.立即执行
	#>
	$UI_Main_Time_Execute = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 280
		Text           = $lang.TimeExecute
		Location       = '15,15'
		add_Click      = {
			if ($this.Checked) {
				$UI_Main_Menu.Enabled = $False
			} else {
				$UI_Main_Menu.Enabled = $True
			}
		}
	}

	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 620
		Width          = 280
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "17,0,8,0"
		Location       = '10,50'
	}

	<#
		.天
	#>
	$UI_Time_Sky_Name = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.Time_Sky
	}
	$UI_Time_Sky       = New-Object System.Windows.Forms.NumericUpDown -Property @{
		Height         = 30
		Width          = 60
		Value          = 0
		Minimum        = 0
		Maximum        = 99
		Margin         = "5,0,0,30"
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Sky" -ErrorAction SilentlyContinue) {
		$UI_Time_Sky.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Sky"
	}

	<#
		.小时
	#>
	$UI_Time_Time_Name = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.Time_Hour
	}
	$UI_Time_Time    = New-Object System.Windows.Forms.NumericUpDown -Property @{
		Height         = 30
		Width          = 60
		Value          = 0
		Minimum        = 0
		Maximum        = 24
		Margin         = "5,0,0,30"
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Hour" -ErrorAction SilentlyContinue) {
		$UI_Time_Time.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Hour"
	}

	<#
		.分钟
	#>
	$UI_Time_Minute_Name = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.Time_Minute
	}
	$UI_Time_Minute    = New-Object System.Windows.Forms.NumericUpDown -Property @{
		Height         = 30
		Width          = 60
		Value          = $Script:Init_Wait_Time_Minute
		Minimum        = 0
		Maximum        = 60
		Margin         = "5,0,0,40"
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Minute" -ErrorAction SilentlyContinue) {
		$UI_Time_Minute.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Minute"
	}

	<#
		.保存为默认
	#>
	$UI_Main_Save      = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.Image_Popup_Default
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\Time" -name "Sky" -value $UI_Time_Sky.Text -String
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\Time" -name "Hour" -value $UI_Time_Time.Text -String
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\Time" -name "Minute" -value $UI_Time_Minute.Text -String
		}
	}

	<#
		.恢复为默认
	#>
	$UI_Main_Restore = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 235
		Text           = $lang.Image_Restore_Default
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Time_Sky.Text = "0"
 			$UI_Time_Time.Text = "0"
			$UI_Time_Minute.Text = $Script:Init_Wait_Time_Minute

			Remove-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Sky" -ErrorAction SilentlyContinue | Out-Null
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Hour" -ErrorAction SilentlyContinue | Out-Null
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\Time" -Name "Minute" -ErrorAction SilentlyContinue | Out-Null
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
			Event_Need_Mount_Global_Variable -DevQueue "5" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
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
		Location       = '376,453'
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
		Width          = 265
		BorderStyle    = 0
		Location       = "360,20"
		Text           = $lang.WaitTimeTips
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}

	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "360,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			$UI_Main.Hide()

			$Global:QueueWaitTime = $True

			if ($UI_Main_Time_Execute.Checked) {
				$Script:EventWaitTime = 0
			} else {
				$Init_Time_Sky    = $([math]::Ceiling($UI_Time_Sky.Text) * 86400)
				$Init_Time_Time   = $([math]::Ceiling($UI_Time_Time.Text) * 60 * 60)
				$Init_Time_Minute = $([math]::Ceiling($UI_Time_Minute.Text) * 60)

				$sum_all = $Init_Time_Sky + $Init_Time_Time + $Init_Time_Minute

				Write-Host "   $($lang.TimeWait)" -NoNewline
				Write-host "$($sum_all) $($lang.TimeSeconds)" -ForegroundColor Yellow
				$Script:EventWaitTime = $sum_all
			}

			$UI_Main.Close()
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "360,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      =  {
			Write-Host "   $($lang.WaitTimeCanel)" -ForegroundColor Red
			$Global:QueueWaitTime = $False
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Time_Execute,
		$UI_Main_Menu,
		$UI_Main_Tips,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	
	$UI_Main_Menu.controls.AddRange((
		$UI_Time_Sky_Name,
		$UI_Time_Sky,
		$UI_Time_Time_Name,
		$UI_Time_Time,
		$UI_Time_Minute_Name,
		$UI_Time_Minute,
		$UI_Main_Save,
		$UI_Main_Restore
	))

	if ($UI_Main_Time_Execute.Checked) {
		$UI_Main_Menu.Enabled = $False
	} else {
		$UI_Main_Menu.Enabled = $True
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
	.执行等待时间
	.Execution wait time
#>
Function Event_Completion_Start_Process
{
	$NowTime       = Get-Date -format "yyyy/MM/dd HH:mm:ss"
	$GUITimeOKTime = (Get-Date).AddSeconds($Script:EventWaitTime)

	Write-Host "   $($lang.TimeWait)" -NoNewline
	Write-Host "$($Script:EventWaitTime) $($lang.TimeSeconds)" -ForegroundColor Yellow

	Write-Host "   $($lang.NowTime)" -NoNewline
	Write-Host $NowTime -ForegroundColor Yellow

	Write-Host "   $($lang.TimeStart)" -NoNewline
	Write-Host "$($GUITimeOKTime.ToString('yyyy/MM/dd HH:mm:ss'))" -ForegroundColor Yellow

	Write-Host "`n   $($lang.TimeMsg)"

	if ($Script:EventWaitTime -gt 99999) {
		Start-Sleep -s $Script:EventWaitTime
	} else {
		start-process "timeout.exe" -argumentlist "/t $($Script:EventWaitTime) /nobreak" -wait -nonewwindow
	}
}