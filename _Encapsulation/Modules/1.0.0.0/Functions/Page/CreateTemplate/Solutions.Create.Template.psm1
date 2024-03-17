Function Create_Template
{
	param
	(
		[Switch]$Silent
	)

	if (-not $Silent) {
		Logo -Title $lang.Deploy
		Write-Host "   $($lang.Deploy)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
	}

	Image_Init_Disk_Sources
	Create_Template_UI
}


<#
	.Create upgrade package user interface
	.创建升级包用户界面
#>
Function Create_Template_UI
{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 928
		Text           = $lang.Deploy
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}
	$GUIUnPackSources  = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 360
		Text           = "$($lang.UpSources -f $($UnPackigtype))"
		Location       = '15,10'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($GUIUnPackSources.Checked) {
				$GUIUnPackShow.Enabled = $False
			} else {
				$GUIUnPackShow.Enabled = $True
			}
		}
	}
	$GUIUnPackShow     = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 530
		Width          = 360
		autoSizeMode   = 1
		Padding        = "28,0,8,0"
		Location       = "0,40"
		autoScroll     = $True
		Enabled        = $False
	}

	<#
		.创建升级包后需要做些什么
	#>
	$GUIUnPackRearTips = New-Object system.Windows.Forms.Label -Property @{
		Location       = "420,15"
		Height         = 30
		Width          = 510
		Text           = $lang.UpCreateRear
	}
	$GUIUnPackGroupGPG = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 220
		Width          = 520
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '420,40'
	}
	$GUIUnPackCreateASC = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 470
		Text           = "$($lang.UpSources -f "PGP")"
		Location       = '26,0'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($GUIUnPackCreateASC.Checked) {
				$GUIUnPackCreateASCPanel.Enabled = $True
				Save_Dynamic -regkey "Solutions" -name "IsPGP" -value "True" -String
			} else {
				$GUIUnPackCreateASCPanel.Enabled = $False
				Save_Dynamic -regkey "Solutions" -name "IsPGP" -value "False" -String
			}
		}
	}
	$GUIUnPackCreateASCPanel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 185
		Width          = 480
		autoSizeMode   = 1
		Padding        = "38,0,0,0"
		Location       = "0,35"
	}
	$GUIUnPackCreateASCClean = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.UpCleanOld
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUnPackCreateASCPWDName = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.UpPgpPwd
	}
	$GUIUnPackCreateASCPWD = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 400
		Text           = $($Global:secure_password)
	}
	$UI_Add_End_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 410
	}
	$GUIUnPackASCSignName = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.CreateASCAuthor
	}
	$GUIUnPackASCSign = New-Object system.Windows.Forms.ComboBox -Property @{
		Height         = 30
		Width          = 400
		Text           = ""
		DropDownStyle  = "DropDownList"
	}

	$GUIUnPackCreateSHA256 = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 470
		Location       = '426,290'
		Text           = "$($lang.UpSources -f "SHA256")"
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			if ($GUIUnPackCreateSHA256.Checked) {
				$GUIUnPackCreateSHA256Clean.Enabled = $True
			} else {
				$GUIUnPackCreateSHA256Clean.Enabled = $False
			}
		}
	}
	$GUIUnPackCreateSHA256Clean = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 453
		Location       = '443,320'
		Text           = $lang.UpCleanOld
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUnPackBackupExclude = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 453
		Text           = $lang.UpBackupExclude
		Location       = '426,380'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUnPackBackupExcludeView = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 265
		Text           = $lang.Exclude_View
		Location       = "441,410"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			$UI_Main_View_Detailed.Visible = $True
			$UI_Main_View_Detailed_Show.Text = ""

			$UI_Main_View_Detailed_Show.Text += "   $($lang.ExcludeItem)`n"
			ForEach ($item in $ArchiveExcludeUnPack) {
				$UI_Main_View_Detailed_Show.Text += "       $($item)`n"
			}
		}
	}
	$GUIUnPackBackup   = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "8,635"
		Height         = 36
		Width          = 360
		Text           = $lang.UpBackup
		add_Click      = {
			<#
				.备份时，排除不包含项
			#>
			if ($GUIUnPackBackupExclude.Checked) {
				$Script:BackupSoluionsExclude = $True
			} else {
				$Script:BackupSoluionsExclude = $False
			}

			<#
				.搜索到后生成 PGP
			#>
			$Script:UnPackCreateASC = $False
			$Script:UnPackCreateASCClean = $False
			if ($GUIUnPackCreateASC.Enabled) {
				if ($GUIUnPackCreateASC.Checked) {
					if ([string]::IsNullOrEmpty($GUIUnPackASCSign.Text)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.CreateASCAuthorTips))"
						return
					} else {
						Save_Dynamic -regkey "Solutions" -name "PGP" -value $GUIUnPackASCSign.Text -String
						$Script:UnPackCreateASC = $True
						$Global:secure_password = $GUIUnPackCreateASCPWD.Text
						$Global:SignGpgKeyID = $GUIUnPackASCSign.Text
					}
				}

				if ($GUIUnPackCreateASCClean.Enabled) {
					if ($GUIUnPackCreateASCClean.Checked) {
						$Script:UnPackCreateASCClean = $True
					}
				}
			}

			<#
				.搜索到后生成 SHA256
			#>
			$Script:UnPackCreateSHA256 = $False
			$Script:UnPackCreateSHA256Clean = $False
			if ($GUIUnPackCreateSHA256.Enabled) {
				if ($GUIUnPackCreateSHA256.Checked) {
					$Script:UnPackCreateSHA256 = $True
				}

				if ($GUIUnPackCreateSHA256Clean.Enabled) {
					if ($GUIUnPackCreateSHA256Clean.Checked) {
						$Script:UnPackCreateSHA256Clean = $True
					}
				}
			}

			$RandomTempFileGuid = [guid]::NewGuid()
			Check_Folder -chkpath $TempFolderUnPack
			Out-File -FilePath "$TempFolderUnPack\writetest-$($RandomTempFileGuid)" -Encoding utf8 -ErrorAction SilentlyContinue

			if (Test-Path -Path "$($TempFolderUnPack)\writetest-$($RandomTempFileGuid)" -PathType Leaf) {
				$UI_Main.Hide()
				Remove-Item "$($TempFolderUnPack)\writetest-$($RandomTempFileGuid)" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null

				UnPack_Compression_Process -Path "$($PSScriptRoot)\..\..\..\..\..\.."
				UnPack_Create_SHA256_GPG -Path $TempFolderUnPack
				UnPack_Move_To -OldPath $TempFolderUnPack -NewPath $UnPackSaveTo
				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = $lang.UnpackFolderUse
			}
		}
	}

	<#
		.Mask: Displays the rule details
		.蒙板：显示规则详细信息
	#>
	$UI_Main_View_Detailed = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 910
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '0,0'
		Visible        = 0
	}
	$UI_Main_View_Detailed_Show = New-Object System.Windows.Forms.RichTextBox -Property @{
		BorderStyle    = 0
		Height         = 595
		Width          = 880
		Location       = "15,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_View_Detailed_Canel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 240
		Location       = "662,635"
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main_View_Detailed.Visible = $False
		}
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "15,598"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "40,600"
		Height         = 30
		Width          = 875
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 240
		Location       = "415,635"
		Text           = $lang.OK
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			$Script:SelectFolderList = @()

			<#
				.搜索到后生成 PGP
			#>
			$Script:UnPackCreateASC = $False
			$Script:UnPackCreateASCClean = $False
			if ($GUIUnPackCreateASC.Enabled) {
				if ($GUIUnPackCreateASC.Checked) {
					if ([string]::IsNullOrEmpty($GUIUnPackASCSign.Text)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.CreateASCAuthorTips))"
						return
					} else {
						Save_Dynamic -regkey "Solutions" -name "PGP" -value $GUIUnPackASCSign.Text -String
						$Script:UnPackCreateASC = $True
						$Global:secure_password = $GUIUnPackCreateASCPWD.Text
						$Global:SignGpgKeyID = $GUIUnPackASCSign.Text
					}
				}

				if ($GUIUnPackCreateASCClean.Enabled) {
					if ($GUIUnPackCreateASCClean.Checked) {
						$Script:UnPackCreateASCClean = $True
					}
				}
			}

			<#
				.搜索到后生成 SHA256
			#>
			$Script:UnPackCreateSHA256 = $False
			$Script:UnPackCreateSHA256Clean = $False
			if ($GUIUnPackCreateSHA256.Enabled) {
				if ($GUIUnPackCreateSHA256.Checked) {
					$Script:UnPackCreateSHA256 = $True
				}

				if ($GUIUnPackCreateSHA256Clean.Enabled) {
					if ($GUIUnPackCreateSHA256Clean.Checked) {
						$Script:UnPackCreateSHA256Clean = $True
					}
				}
			}

			if ($GUIUnPackSources.Checked) {
				$UI_Main.Hide()
				ForEach ($item in $SearchUnPack) {
					$Script:SelectFolderList += "$($Global:MainMasterFolder)\$($item)"
				}

				ForEach ($item in $Script:SelectFolderList) {
					Write-Host "   $($item)"
					UnPack_Create_SHA256_GPG -Path $item
				}
				$UI_Main.Close()
			} else {
				$GUIUnPackShow.Controls | ForEach-Object {
					if ($_ -is [System.Windows.Forms.CheckBox]) {
						if ($_.Enabled) {
							if ($_.Checked) {
								$Script:SelectFolderList += $_.Text
							}
						}
					}
				}

				if ($Script:SelectFolderList.Count -gt 0) {
					$UI_Main.Hide()
					ForEach ($item in $Script:SelectFolderList) {
						Write-Host "   $($item)"
						UnPack_Create_SHA256_GPG -Path $item
					}
					$UI_Main.Close()
				} else {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = $lang.UpdateServerNoSelect
				}
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
		$UI_Main_View_Detailed,
		$GUIUnPackSources,
		$GUIUnPackShow,
		$GUIUnPackBackup,
		$GUIUnPackBackupTips,
		$GUIUnPackRearTips,
		$GUIUnPackGroupGPG,
		$GUIUnPackCreateSHA256,
		$GUIUnPackCreateSHA256Clean,
		$GUIUnPackBackupExclude,
		$GUIUnPackBackupExcludeView,
		$GUIUnPackBackup,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	$UI_Main_View_Detailed.controls.AddRange((
		$UI_Main_View_Detailed_Show,
		$UI_Main_View_Detailed_Canel
	))

	$GUIUnPackGroupGPG.controls.AddRange((
		$GUIUnPackCreateASC,
		$GUIUnPackCreateASCPanel
	))

	$GUIUnPackCreateASCPanel.controls.AddRange((
		$GUIUnPackCreateASCClean,
		$GUIUnPackCreateASCPWDName,
		$GUIUnPackCreateASCPWD,
		$UI_Add_End_Wrap,
		$GUIUnPackASCSignName,
		$GUIUnPackASCSign
	))

	ForEach ($item in $SearchUnPack) {
		$CheckBox         = New-Object System.Windows.Forms.CheckBox -Property @{
			Height        = 40
			Width         = 310
			Text          = "$($Global:MainMasterFolder)\$($item)"
			Checked       = $True
			add_Click      = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null
			}
		}
		$GUIUnPackShow.controls.AddRange($CheckBox)
	}

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$GUIUnPackBackup.Enabled = $True
		$UI_Main_OK.Enabled = $True
	} else {
		$GUIUnPackSources.Enabled = $False
		$GUIUnPackCreateSHA256Clean.Enabled = $False

		$GUIUnPackBackup.Enabled = $False
		$UI_Main_OK.Enabled = $False

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += $($lang.ZipStatus)
	}

	<#
		.初始化：PGP KEY-ID
	#>
	ForEach ($item in $Global:GpgKI) {
		$GUIUnPackASCSign.Items.Add($item) | Out-Null
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "PGP" -ErrorAction SilentlyContinue) {
		$GUIUnPackASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "PGP" -ErrorAction SilentlyContinue
	}

	<#
		.初始化复选框：生成 PGP
	#>
	$Verify_Install_Path = Get_ASC -Run "gpg.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$GUIUnPackGroupGPG.Enabled = $True

		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "IsPGP" -ErrorAction SilentlyContinue) {
			switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -Name "IsPGP" -ErrorAction SilentlyContinue) {
				"True" {
					$GUIUnPackCreateASC.Checked = $True
					$GUIUnPackCreateASCPanel.Enabled = $True
				}
				"False" {
					$GUIUnPackCreateASC.Checked = $False
					$GUIUnPackCreateASCPanel.Enabled = $False
				}
			}
		} else {
			$GUIUnPackCreateASC.Checked = $False
			$GUIUnPackCreateASCPanel.Enabled = $False
		}
	} else {
		$GUIUnPackGroupGPG.Enabled = $False

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += $($lang.ASCStatus)
	}

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUIUnPackAddMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUIUnPackAddMenu.Items.Add($lang.AllSel).add_Click({
		$GUIUnPackShow.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUIUnPackAddMenu.Items.Add($lang.AllClear).add_Click({
		$GUIUnPackShow.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$GUIUnPackShow.ContextMenuStrip = $GUIUnPackAddMenu

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