﻿<#
	.More features
	.更多功能
#>
Function Setting_Export_To_UI
{
	Write-Host "`n   $($lang.Setting): $($lang.SaveTo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	$SearchFolderRule = @(
		"$($Global:Image_source)\History\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
		"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
		"$($Global:Image_source)_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
	)
	$SearchFolderRule = $SearchFolderRule | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 928
		Text           = "$($lang.Setting): $($lang.SaveTo)"
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 625
		Width          = 555
		Padding        = 15
		BorderStyle    = 0
		autoSizeMode   = 0
		Dock           = 3
		autoScroll     = $true
	}

	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Height         = 60
		Width          = 280
		Location       = "620,525"
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 280
		Location       = "620,595"
		Text           = $lang.OK
		add_Click      = {
			$UI_Main_Menu.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.RadioButton]) {
					if ($_.Checked) {
						Write-host "   $($lang.Setting): $($lang.SaveTo)"
						Write-host "   $($_.Text)"
						New-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $_.Text -Force
						Write-host "   $($lang.Done)" -ForegroundColor Green

						$UI_Main.Close()
					}
				}
			}

			$UI_Main_Error.Text = $lang.NoChoose		
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Hide()
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	<#
		.计算公式：
			四舍五入为整数
				(初始化字符长度 * 初始化字符长度）
			/ 控件高度
	#>
	<#
		.初始化字符长度
	#>
	[int]$InitCharacterLength = 90

	<#
		.初始化控件高度
	#>
	[int]$InitControlHeight = 35

	$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	ForEach ($item in $SearchFolderRule) {
		$InitLength = $item.Length
		if ($InitLength -lt $InitCharacterLength) { $InitLength = $InitCharacterLength }

		$CheckBox     = New-Object System.Windows.Forms.RadioButton -Property @{
			Height    = $([math]::Ceiling($InitLength / $InitCharacterLength) * $InitControlHeight)
			Width     = 515
			Text      = $item
			Tag       = $item
		}

		if ($Temp_Expand_Rule -eq $item) {
			$CheckBox.Checked = $True
		}
		$UI_Main_Menu.controls.AddRange($CheckBox)
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