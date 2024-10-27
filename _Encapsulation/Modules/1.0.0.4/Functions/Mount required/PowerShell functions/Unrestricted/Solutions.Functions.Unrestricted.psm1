Function Functions_Unrestricted_UI
{
	Write-Host "`n   $($lang.SpecialFunction): $($lang.Function_Unrestricted)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 1075
		Text           = "$($lang.SpecialFunction): $($lang.Function_Unrestricted)"
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
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "Now_Is_Check_Duplicate" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "Now_Is_Check_Duplicate" -value "False" -String
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "Now_Is_Check_Duplicate" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "Now_Is_Check_Duplicate" -ErrorAction SilentlyContinue) {
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
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "Now_Is_Check_Auto_Select" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -name "Now_Is_Check_Auto_Select" -value "False" -String
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "Now_Is_Check_Auto_Select" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Functions" -Name "Now_Is_Check_Auto_Select" -ErrorAction SilentlyContinue) {
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
			$Global:Function_Unrestricted = @()

			<#
				.Mark: Check the selection status
				.标记：检查选择状态
			#>
			$UI_Main_Select_Function.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Global:Function_Unrestricted += $_.Text
						}
					}
				}
			}

			if ($Global:Function_Unrestricted.Count -gt 0) {
				$UI_Main.Hide()

				Write-Host "`n   $($lang.AddSources)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				ForEach ($item in $Global:Function_Unrestricted) {
					Write-Host "   $($item)" -ForegroundColor Green
				}

				Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				ForEach ($item in $Global:Function_Unrestricted) {
					Write-Host "   $($item)" -ForegroundColor Green
					Write-Host "   $($lang.Has_Been_Run)"

					Invoke-Expression -Command $item

					Write-Host "   $($lang.Running)".PadRight(28) -NoNewline
					Write-Host $lang.Done -ForegroundColor Green
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
			$Global:Function_Unrestricted = @()

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