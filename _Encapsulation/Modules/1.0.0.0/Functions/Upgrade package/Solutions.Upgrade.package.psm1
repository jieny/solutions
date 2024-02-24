<#
	.Create upgrade package user interface
	.创建升级包用户界面
#>
Function Update_Create_UI
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $lang.UpdateCreate
		Write-Host "   $($lang.UpdateCreate)" -ForegroundColor Green
		Write-host "   $('-' * 80)"
	}

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 928
		Text           = $lang.UpdateCreate
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}
	$UI_Main_Menu      = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 350
		Width          = 360
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = 15
		Dock           = 3
	}

	<#
		.创建升级包后需要做些什么
	#>
	$GUIUpdateRearTips = New-Object system.Windows.Forms.Label -Property @{
		Location       = "420,15"
		Height         = 30
		Width          = 390
		Text           = $lang.UpCreateRear
	}
	$GUIUpdateGroupASC = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 525
		Width          = 480
		autoSizeMode   = 1
		Padding        = "22,0,8,0"
		Location       = '420,45'
	}

	<#
		.asc
	#>
	$GUIUpdateCreateASC = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 430
		Text           = $lang.UpCreateASC
		Checked        = $True
		add_Click      = {
			if ($GUIUpdateCreateASC.Checked) {
				Save_Dynamic -regkey "Solutions" -name "IsPGP" -value "True" -String
				$GUIUpdateCreateASCPanel.Enabled = $True
			} else {
				Save_Dynamic -regkey "Solutions" -name "IsPGP" -value "False" -String
				$GUIUpdateCreateASCPanel.Enabled = $False
			}
		}
	}
	$GUIUpdateCreateASCPanel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		Padding        = "16,0,0,0"
		autoScroll     = $False
	}
	$GUIUpdateCreateASCPWDName = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 410
		Text           = $lang.UpPgpPwd
	}
	$GUIUpdateCreateASCPWD = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 390
		Text           = $($Global:secure_password)
	}
	$UI_Add_End_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 410
	}
	$GUIUpdateCreateASCSignName = New-Object system.Windows.Forms.Label -Property @{
		Location       = "42,75"
		Height         = 30
		Width          = 410
		Text           = $lang.CreateASCAuthor
	}
	$GUIUpdateCreateASCSign = New-Object system.Windows.Forms.ComboBox -Property @{
		Location       = "42,105"
		Height         = 55
		Width          = 390
		Text           = ""
		DropDownStyle  = "DropDownList"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	$GUIUpdateCreateSHA256 = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 470
		Text           = $lang.UpCreateSHA256
		Location       = '26,515'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "415,598"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "440,600"
		Height         = 30
		Width          = 404
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 240
		Location       = "415,635"
		Text           = $lang.OK
		add_Click      = {
			$MarkNewRunAction = "-Silent"

			<#
				.搜索到后生成 PGP
			#>
			if ($GUIUpdateCreateASC.Enabled) {
				if ($GUIUpdateCreateASC.Checked) {
					if ([string]::IsNullOrEmpty($GUIUpdateCreateASCSign.Text)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")

						$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.CreateASCAuthorTips))"
						return
					} else {
						Save_Dynamic -regkey "Solutions" -name "PGP" -value $GUIUpdateCreateASCSign.Text -String
						$Global:secure_password = $GUIUpdateCreateASCPWD.Text
						$Global:SignGpgKeyID = $GUIUpdateCreateASCSign.Text

						$MarkNewRunAction += " -PGP -PGPKEY $PGPKEY ""$Global:SignGpgKeyID"" -PGPPWD ""$Global:secure_password"""
					}
				}
			}

			$Script:QueueUpdatePackerSelect = @()
			$UI_Main_Menu.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Script:QueueUpdatePackerSelect += @{
								Name   = $_.Text
								PSFile = $_.Tag
							}
						}
					}
				}
			}

			if ($Script:QueueUpdatePackerSelect.Count -gt 0) {
				$UI_Main.Hide()

				if ($GUIUpdateCreateSHA256.Enabled) {
					if ($GUIUpdateCreateSHA256.Checked) {
						$MarkNewRunAction += " -SHA256"
					}
				}

				Remove_Tree "$([Environment]::GetFolderPath("Desktop"))\$((Get-Module -Name Solutions).Author).Solutions.Upgrade.Package"

				ForEach ($item in $Script:QueueUpdatePackerSelect) {
					Write-Host "   $($item.Name)" -ForegroundColor Green
					Write-Host "   $($lang.AddTo)".PadRight(28) -NoNewline
					Start-Process powershell -ArgumentList "-File ""$($item.PSFile)"" $($MarkNewRunAction) -SaveTo ""$([Environment]::GetFolderPath("Desktop"))\$((Get-Module -Name Solutions).Author).Solutions.Upgrade.Package\$($item.Name)""" -Wait -WindowStyle Minimized
					Write-Host $lang.Done -ForegroundColor Green

					Write-Host
				}

				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.NoChoose)"
			}
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 240
		Location       = "662,635"
		Text           = $lang.Cancel
		add_Click      = {
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$GUIUpdateBackup,
		$GUIUpdateBackupTips,
		$GUIUpdateRearTips,
		$GUIUpdateGroupASC,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	$GUIUpdateGroupASC.controls.AddRange((
		$GUIUpdateCreateSHA256,
		$GUIUpdateCreateASC,
		$GUIUpdateCreateASCPanel
	))

	$GUIUpdateCreateASCPanel.controls.AddRange((
		$GUIUpdateCreateASCPWDName,
		$GUIUpdateCreateASCPWD,
		$UI_Add_End_Wrap,
		$GUIUpdateCreateASCSignName,
		$GUIUpdateCreateASCSign
	))

	Get-ChildItem -Path "$($PSScriptRoot)\..\..\..\..\_Custom\Engine" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
		if (Test-Path -Path "$($_.Fullname)\_Create.Upgrade.Package.ps1" -PathType Leaf) {
			$CheckBox      = New-Object System.Windows.Forms.CheckBox -Property @{
				Height     = 35
				Width      = 325
				Text       = $_.BaseName
				Tag        = "$($_.Fullname)\_Create.Upgrade.Package.ps1"
				Checked    = $True
			}

			$UI_Main_Menu.controls.AddRange($CheckBox)
		}
	}

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$UI_Main_OK.Enabled = $True
	} else {
		$UI_Main_Menu.Enabled = $False
		$GUIUpdateGroupASC.Enabled = $False
		$UI_Main_OK.Enabled = $False

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += $($lang.ZipStatus)
	}

	<#
		.初始化：PGP KEY-ID
	#>
	ForEach ($item in $Global:GpgKI) {
		$GUIUpdateCreateASCSign.Items.Add($item) | Out-Null
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "PGP" -ErrorAction SilentlyContinue) {
		$GUIUpdateCreateASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "PGP" -ErrorAction SilentlyContinue
	}

	<#
		.初始化复选框：生成 PGP
	#>
	$Verify_Install_Path = Get_ASC -Run "gpg.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$GUIUpdateCreateASC.Enabled = $True
		$GUIUpdateCreateASCPanel.Enabled = $True
	} else {
		$GUIUpdateCreateASC.Enabled = $False
		$GUIUpdateCreateASCPanel.Enabled = $False

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += $($lang.ASCStatus)
	}

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