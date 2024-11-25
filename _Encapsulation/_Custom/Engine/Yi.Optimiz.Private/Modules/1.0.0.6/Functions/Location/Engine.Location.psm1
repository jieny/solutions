﻿Function Change_Location
{
	Logo -Title $($lang.LocationUserFolder)
	Write-Host "   $($lang.LocationUserFolder)`n   $('-' * 80)"

	<#
		.初始化：获取当前位置
	#>
	$DesktopOldpath = [Environment]::GetFolderPath("Desktop")
	$MyDocumentsOldpath = [Environment]::GetFolderPath("MyDocuments")
	$DownloadsOldpath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
	$MusicOldpath = [Environment]::GetFolderPath("MyMusic")
	$PicturesOldpath = [Environment]::GetFolderPath("MyPictures")
	$VideoOldpath = [Environment]::GetFolderPath("MyVideos")

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Function Change_Location_New_Path
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateSet('Desktop', 'Documents', 'Downloads', 'Music', 'Pictures', 'Videos')]
			[string]$KnownFolder
		)

		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null

		$FolderBrowser   = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
			RootFolder   = "MyComputer"
		}
	
		if ($FolderBrowser.ShowDialog() -eq "OK") {
			if (Test_Available_Disk -Path $FolderBrowser.SelectedPath) {
				switch ($KnownFolder) {
					"Desktop"   { $GUILocationItemDesktopShow.Text   = $FolderBrowser.SelectedPath }
					"Documents" { $GUILocationItemDocumentsShow.Text = $FolderBrowser.SelectedPath }
					"Downloads" { $GUILocationItemDownloadsShow.Text = $FolderBrowser.SelectedPath }
					"Music"     { $GUILocationItemMusicShow.Text     = $FolderBrowser.SelectedPath }
					"Pictures"  { $GUILocationItemPicturesShow.Text  = $FolderBrowser.SelectedPath }
					"Videos"    { $GUILocationItemVideosShow.Text    = $FolderBrowser.SelectedPath }
				}
			} else {
				$UI_Main_Error.Text = $lang.LocationFolderError
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
			}
		}
	}

	Function Change_Location_Refresh_Mount_Disk
	{
		$GUILocationPane1.controls.Clear()
		Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | ForEach-Object {
			if (Test_Available_Disk -Path $_.Root) {
				$RadioButton  = New-Object System.Windows.Forms.RadioButton -Property @{
					Height    = 35
					Width     = 345
					Text      = $_.Root
					Tag       = $_.Description
					add_Click = { Change_Location_Refresh }
				}
				if ($GUILocationLowSize.Checked) {
					if (-not (Verify_Available_Size -Disk $_.Root -Size $SelectLowSize.Text)) {
						$RadioButton.Enabled = $False
					}
				}
				$GUILocationPane1.controls.AddRange($RadioButton)
			}
		}
	}

	Function Change_Location_Refresh
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null

		$FlagCheckDiskSelect = $False
		$GUILocationPane1.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.RadioButton]) {
				if ($_.Checked) {
					$FlagCheckDiskSelect = $True
					$FlagsNewLabelSpecify = $_.Text

					if ($GUILocationCustomize.Checked) {
						<#
							.Mark: Determine the directory prefix
							.标记：判断目录前缀
						#>
						$FlagCheckFolderPrefix = $False

						<#
							.Necessary judgment
							.必备判断
						#>
						<#
							.Judgment: 1. Null value
							.判断：1. 空值
						#>
						if ([string]::IsNullOrEmpty($GUILocationCustomizeShow.Text)) {
							$UI_Main_Error.Text = $lang.SelectFromError -f $lang.NoSetFolderLabel
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}

						<#
							.Judgment: 2. The prefix cannot contain spaces
							.判断：2. 前缀不能带空格
						#>
						if ($GUILocationCustomizeShow.Text -match '^\s') {
							$UI_Main_Error.Text = $lang.SelectFromError -f $lang.ISO9660TipsErrorSpace
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}

						<#
							.Judgment: 3. No spaces at the end
							.判断：3. 前缀不能带空格
						#>
						if ($GUILocationCustomizeShow.Text -match '\s$') {
							$UI_Main_Error.Text = $lang.SelectFromError -f $lang.ISO9660TipsErrorSpace
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}

						<#
							.Judgment: 4. There can be no two spaces in between
							.判断：4. 中间不能含有二个空格
						#>
						if ($GUILocationCustomizeShow.Text -match '\s{2,}') {
							$UI_Main_Error.Text = $lang.SelectFromError -f $lang.ISO9660TipsErrorSpace
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}

						<#
							.Judgment: 5. Cannot contain: \\ /: *? "" <> |
							.判断：5, 不能包含：\\ / : * ? "" < > |
						#>
						if ($GUILocationCustomizeShow.Text -match '[~#$@!%&*{}\\:<>?/|+"]') {
							$UI_Main_Error.Text = $lang.SelectFromError -f $lang.ISO9660TipsErrorOther
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}
						<#
							.Judgment: 6. No more than 260 characters
							.判断：6. 不能大于 260 字符
						#>
						if ($GUILocationCustomizeShow.Text.length -gt 128) {
							$UI_Main_Error.Text = $lang.SelectFromError -f $($lang.ISOLengthError -f "260")
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\Assets\icon\Error.ico")
							return
						}

						$FlagsNewLabelSpecify += "$($GUILocationCustomizeShow.Text)\"
						Save_Dynamic -regkey "Yi.Optimiz.Private\UserFolder" -name "Folder" -value "$($GUILocationCustomizeShow.Text)" -String
					}

					if ($GUILocationComputer.Checked) {
						$FlagsNewLabelSpecify += "$($env:COMPUTERNAME)\"
					}

					if ($GUILocationUsers.Checked) {
						$FlagsNewLabelSpecify += "Users\"
					}

					if ($GUILocationUserName.Checked) {
						$FlagsNewLabelSpecify += "$($env:UserName)\"
					}

					if ($GUILocationItemDesktop.Checked) {
						$GUILocationItemDesktopShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Desktop" -ErrorAction SilentlyContinue
					}

					if ($GUILocationItemDocuments.Checked) {
						$GUILocationItemDocumentsShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Documents" -ErrorAction SilentlyContinue
					}

					if ($GUILocationItemDownloads.Checked) {
						$GUILocationItemDownloadsShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Downloads" -ErrorAction SilentlyContinue
					}

					if ($GUILocationItemMusic.Checked) {
						$GUILocationItemMusicShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Music" -ErrorAction SilentlyContinue
					}

					if ($GUILocationItemPictures.Checked) {
						$GUILocationItemPicturesShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Pictures" -ErrorAction SilentlyContinue
					}

					if ($GUILocationItemVideos.Checked) {
						$GUILocationItemVideosShow.Text = Join-Path -Path $FlagsNewLabelSpecify -ChildPath "Videos" -ErrorAction SilentlyContinue
					}
				}
			}
		}
		if (-not ($FlagCheckDiskSelect)) {
			$GUILocationItemDesktopShow.Text = $DesktopOldpath
			$GUILocationItemDocumentsShow.Text = $MyDocumentsOldpath
			$GUILocationItemDownloadsShow.Text = $DownloadsOldpath
			$GUILocationItemMusicShow.Text = $MusicOldpath
			$GUILocationItemPicturesShow.Text = $PicturesOldpath
			$GUILocationItemVideosShow.Text = $VideoOldpath
		}
	}

	$GUILocation       = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 1015
		Text           = $lang.LocationUserFolder
		MaximizeBox    = $False
		StartPosition  = "CenterScreen"
		MinimizeBox    = $false
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}

	<#
		.可选功能
	#>
	$GUILocationAdv    = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 410
		Text           = $lang.AdvOption
		Location       = '10,10'
	}
	$GUILocationStructure = New-Object System.Windows.Forms.Label -Property @{
		Height         = 22
		Width          = 396
		Text           = $lang.LocationStructure
		Location       = '24,38'
	}
	$GUILocationCustomize = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 380
		Text           = $lang.FolderLabel
		Location       = '40,66'
		add_Click      = {
			if ($GUILocationCustomize.Checked) {
				$GUILocationCustomizeShow.Enabled = $True
				Save_Dynamic -regkey "Yi.Optimiz.Private\UserFolder" -name "AllowCustomize" -value "True" -String
			} else {
				$GUILocationCustomizeShow.Enabled = $False
				Save_Dynamic -regkey "Yi.Optimiz.Private\UserFolder" -name "AllowCustomize" -value "False" -String
			}
			Change_Location_Refresh
		}
	}
	$GUILocationCustomizeShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 350
		Text           = ""
		Location       = '56,94'
		BackColor      = "#FFFFFF"
		add_Click      = { Change_Location_Refresh }
	}
	$GUILocationCustomizeTips = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 70
		Width          = 355
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $False
		Padding        = 0
		Dock           = 0
		Location       = '51,120'
	}
	$GUILocationVerifyErrorMsg = New-Object system.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Text           = $lang.VerifyNameTips
	}
	$GUILocationComputer = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 380
		Text           = $lang.LocationComputer
		Location       = '40,195'
		add_Click      = { Change_Location_Refresh }
	}
	$GUILocationUsers  = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 380
		Text           = "Users"
		Location       = '40,223'
		add_Click      = { Change_Location_Refresh }
	}
	$GUILocationUserName = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 380
		Text           = $lang.LocationUserName
		Location       = '40,251'
		Checked        = $True
		add_Click      = { Change_Location_Refresh }
	}

	$GUILocationSize   = New-Object System.Windows.Forms.Label -Property @{
		Height         = 22
		Width          = 410
		Text           = $lang.SelectAutoAvailable
		Location       = '10,295'
	}
	$GUILocationLowSize = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 380
		Text           = $lang.SelectCheckAvailable
		Location       = '26,320'
		Checked        = $True
		add_Click      = {
			if ($GUILocationLowSize.Checked) {
				$SelectLowSize.Enabled = $True
			} else {
				$SelectLowSize.Enabled = $False
			}
			Change_Location_Refresh_Mount_Disk
		}
	}
	$SelectLowSize     = New-Object System.Windows.Forms.NumericUpDown -Property @{
		Height         = 22
		Width          = 60
		Location       = "45,350"
		Value          = 1
		Minimum        = 1
		Maximum        = 999999
		TextAlign      = 1
		add_Click      = { Change_Location_Refresh_Mount_Disk }
	}
	$SelectLowUnit     = New-Object System.Windows.Forms.Label -Property @{
		Height         = 22
		Width          = 80
		Text           = "GB"
		Location       = "115,354"
	}
	$GUILocationTitle  = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 22
		Width          = 380
		Text           = $lang.ChangeInstallDisk
		Location       = '24,400'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Change_Location_Refresh_Mount_Disk }
	}
	$GUILocationPane1  = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 115
		Width          = 385
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $true
		Padding        = "8,0,8,0"
		Dock           = 0
		Location       = '30,423'
	}

	$GUILocationCurrent = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 22
		Width          = 385
		Text           = $lang.LocationCurrent
		Location       = '30,567'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$GUILocationItemDesktopShow.Text = $DesktopOldpath
			$GUILocationItemDocumentsShow.Text = $MyDocumentsOldpath
			$GUILocationItemDownloadsShow.Text = $DownloadsOldpath
			$GUILocationItemMusicShow.Text = $MusicOldpath
			$GUILocationItemPicturesShow.Text = $PicturesOldpath
			$GUILocationItemVideosShow.Text = $VideoOldpath
		}
	}
	$GUILocationInitial = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 22
		Width          = 385
		Text           = $lang.LocationInitial
		Location       = '30,595'
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$GUILocationItemDesktopShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop" -ErrorAction SilentlyContinue
			$GUILocationItemDocumentsShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Documents" -ErrorAction SilentlyContinue
			$GUILocationItemDownloadsShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads" -ErrorAction SilentlyContinue
			$GUILocationItemMusicShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Music" -ErrorAction SilentlyContinue
			$GUILocationItemPicturesShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Pictures" -ErrorAction SilentlyContinue
			$GUILocationItemVideosShow.Text = Join-Path -Path $env:USERPROFILE -ChildPath "Videos" -ErrorAction SilentlyContinue
		}
	}

	<#
		.迁移的项目
	#>
	$GUILocationItem   = New-Object System.Windows.Forms.Label -Property @{
		Height         = 22
		Width          = 430
		Text           = $lang.LocationUserFolderTips
		Location       = '472,10'
	}
	$GUILocationItemPanel = New-Object System.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 390
		Width          = 500
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '490,38'
		autoScroll     = $True
	}
	$GUILocationItemDesktop = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationDesktop
		Location       = '0,0'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemDesktop.Checked) {
				$GUILocationItemDesktopSelect.Enabled = $True
			} else {
				$GUILocationItemDesktopSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemDesktopShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,25'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemDesktopSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,25'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Desktop" }
		Text           = "..."
	}
	$GUILocationItemDocuments = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationDocuments
		Location       = '0,65'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemDocuments.Checked) {
				$GUILocationItemDocumentsSelect.Enabled = $True
			} else {
				$GUILocationItemDocumentsSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemDocumentsShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,90'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemDocumentsSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,90'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Documents" }
		Text           = "..."
	}
	$GUILocationItemDownloads = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationDownloads
		Location       = '0,130'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemDownloads.Checked) {
				$GUILocationItemDownloadsSelect.Enabled = $True
			} else {
				$GUILocationItemDownloadsSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemDownloadsShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,155'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemDownloadsSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,155'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Downloads" }
		Text           = "..."
	}
	$GUILocationItemMusic = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationMusic
		Location       = '0,195'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemMusic.Checked) {
				$GUILocationItemMusicSelect.Enabled = $True
			} else {
				$GUILocationItemMusicSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemMusicShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,220'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemMusicSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,220'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Music" }
		Text           = "..."
	}
	$GUILocationItemPictures = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationPictures
		Location       = '0,260'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemPictures.Checked) {
				$GUILocationItemPicturesSelect.Enabled = $True
			} else {
				$GUILocationItemPicturesSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemPicturesShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,285'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemPicturesSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,285'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Pictures" }
		Text           = "..."
	}
	$GUILocationItemVideos = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 475
		Text           = $lang.LocationVideos
		Location       = '0,325'
		Checked        = $True
		add_Click      = {
			if ($GUILocationItemVideos.Checked) {
				$GUILocationItemVideosSelect.Enabled = $True
			} else {
				$GUILocationItemVideosSelect.Enabled = $False
			}
		}
	}
	$GUILocationItemVideosShow = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 425
		Text           = ""
		Location       = '18,350'
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$GUILocationItemVideosSelect = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = '450,350'
		Height         = 22
		Width          = 25
		add_Click      = { Change_Location_New_Path -KnownFolder "Videos" }
		Text           = "..."
	}

	<#
		.更改完成后
	#>
	$GUILocationFinish = New-Object System.Windows.Forms.Label -Property @{
		Height         = 22
		Width          = 430
		Text           = $lang.LocationDone
		Location       = '472,455'
	}
	$GUILocationFinishSync = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 490
		Text           = $lang.LocationDoneSync
		Location       = '492,482'
		Checked        = $True
	}
	$GUILocationFinishClear = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 490
		Text           = $lang.LocationDoneClean
		Location       = '492,510'
		ForeColor      = "#0000FF"
	}
	$GUILocationFinishClearTips = New-Object System.Windows.Forms.Label -Property @{
		Height         = 38
		Width          = 475
		Text           = $lang.LocationDoneCleanTips
		Location       = '508,535'
	}
	
	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "10,598"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "16,645"
		Height         = 30
		Width          = 385
		Text           = ""
	}
	$GUILocationOK     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "492,635"
		Height         = 36
		Width          = 245
		Text           = $lang.OK
		add_Click      = {
			$GUILocation.Hide()
			if ($GUILocationFinishSync.Checked) {
				$Global:LocationFinishSync = $True
			} else {
				$Global:LocationFinishSync = $False
			}

			if ($GUILocationFinishClear.Checked) {
				$Global:LocationFinishClear = $True
			} else {
				$Global:LocationFinishClear = $False
			}

			if ($GUILocationItemDesktop.Checked) {
				Change_Location_Set_Path -KnownFolder "Desktop" -NewFolder $GUILocationItemDesktopShow.Text
			}

			if ($GUILocationItemDocuments.Checked) {
				Change_Location_Set_Path -KnownFolder "Documents" -NewFolder $GUILocationItemDocumentsShow.Text
			}

			if ($GUILocationItemDownloads.Checked) {
				Change_Location_Set_Path -KnownFolder "Downloads" -NewFolder $GUILocationItemDownloadsShow.Text
			}

			if ($GUILocationItemMusic.Checked) {
				Change_Location_Set_Path -KnownFolder "Music" -NewFolder $GUILocationItemMusicShow.Text
			}

			if ($GUILocationItemPictures.Checked) {
				Change_Location_Set_Path -KnownFolder "Pictures" -NewFolder $GUILocationItemPicturesShow.Text
			}

			if ($GUILocationItemVideos.Checked) {
				Change_Location_Set_Path -KnownFolder "Videos" -NewFolder $GUILocationItemVideosShow.Text
			}
			$GUILocation.Close()
		}
	}
	$GUILocationCanel  = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "742,635"
		Height         = 36
		Width          = 245
		Text           = $lang.Cancel
		add_Click      = {
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			$GUILocation.Close()
		}
	}
	$GUILocation.controls.AddRange((
		$GUILocationSize,
		$GUILocationLowSize,
		$SelectLowSize,
		$SelectLowUnit,
		$GUILocationTitle,
		$GUILocationPane1,
		$GUILocationAdv,
		$GUILocationCustomize,
		$GUILocationCustomizeShow,
		$GUILocationCustomizeTips,
		$GUILocationStructure,
		$GUILocationComputer,
		$GUILocationUsers,
		$GUILocationUserName,
		$GUILocationFinish,
		$GUILocationFinishSync,
		$GUILocationFinishClear,
		$GUILocationFinishClearTips,
		$GUILocationItem,
		$GUILocationItemPanel,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$GUILocationCurrent,
		$GUILocationInitial,
		$GUILocationOK,
		$GUILocationCanel
	))
	$GUILocationItemPanel.controls.AddRange((
		$GUILocationItemDesktop,
		$GUILocationItemDesktopShow,
		$GUILocationItemDesktopSelect,
		$GUILocationItemDocuments,
		$GUILocationItemDocumentsShow,
		$GUILocationItemDocumentsSelect,
		$GUILocationItemDownloads,
		$GUILocationItemDownloadsShow,
		$GUILocationItemDownloadsSelect,
		$GUILocationItemMusic,
		$GUILocationItemMusicShow,
		$GUILocationItemMusicSelect,
		$GUILocationItemPictures,
		$GUILocationItemPicturesShow,
		$GUILocationItemPicturesSelect,
		$GUILocationItemVideos,
		$GUILocationItemVideosShow,
		$GUILocationItemVideosSelect
	))
	$GUILocationCustomizeTips.controls.AddRange((
		$GUILocationVerifyErrorMsg
	))

	<#
		.Checkbox: Customize the new directory
		.复选框：自定义新的目录
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Engine).Author)\Yi.Optimiz.Private\UserFolder" -Name "AllowCustomize" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Engine).Author)\Yi.Optimiz.Private\UserFolder" -Name "AllowCustomize" -ErrorAction SilentlyContinue) {
			"True" {
				$GUILocationCustomize.Checked = $True
				$GUILocationCustomizeShow.Enabled = $True
			}
			"False" {
				$GUILocationCustomize.Checked = $False
				$GUILocationCustomizeShow.Enabled = $False
			}
		}
	} else {
		$GUILocationCustomize.Checked = $False
		$GUILocationCustomizeShow.Enabled = $False
		Save_Dynamic -regkey "Yi.Optimiz.Private\UserFolder" -name "AllowCustomize" -value "False" -String
	}

	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Engine).Author)\Yi.Optimiz.Private\UserFolder" -Name "Folder" -ErrorAction SilentlyContinue) {
		$GetNewFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Engine).Author)\Yi.Optimiz.Private\UserFolder" -Name "Folder" -ErrorAction SilentlyContinue
		$GUILocationCustomizeShow.Text = $GetNewFolder
	} else {
		$GUILocationCustomizeShow.Text = $Global:MainImageLang
	}

	Change_Location_Refresh
	Change_Location_Refresh_Mount_Disk

	if ($Global:EventQueueMode) {
		$GUILocation.Text = "$($GUILocation.Text) [ $($lang.QueueMode) ]"
	} else {
	}

	switch ($Global:IsLang) {
		"zh-CN" {
			$GUILocation.Font = New-Object System.Drawing.Font("Microsoft YaHei", 9, [System.Drawing.FontStyle]::Regular)
		}
		Default {
			$GUILocation.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
		}
	}

	$GUILocation.ShowDialog() | Out-Null
}

Function Change_Location_Set_Path
{
	Param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet("Desktop", "Documents", "Downloads", "Music", "Pictures", "Videos")]
		[string]$KnownFolder,
		
		[Parameter(Mandatory = $true)]
		[string]$NewFolder
	)

	$DesktopOldpath = [Environment]::GetFolderPath("Desktop")
	$MyDocumentsOldpath = [Environment]::GetFolderPath("MyDocuments")
	$DownloadsOldpath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
	$MusicOldpath = [Environment]::GetFolderPath("MyMusic")
	$PicturesOldpath = [Environment]::GetFolderPath("MyPictures")
	$VideoOldpath = [Environment]::GetFolderPath("MyVideos")

	# Define known folder GUIDs
	$KnownFoldersGuids = @{
		"Desktop"   = @("B4BFCC3A-DB2C-424C-B029-7FE99A87C641");
		"Documents" = @("FDD39AD0-238F-46AF-ADB4-6C85480369C7", "f42ee2d3-909f-4907-8871-4c22fc0bf756");
		"Downloads" = @("374DE290-123F-4565-9164-39C4925E467B", "7d83ee9b-2244-4e70-b1f5-5393042af1e4");
		"Music"     = @("4BD8D571-6D19-48D3-BE97-422220080E43", "a0c69a99-21c8-4671-8703-7934162fcf1d");
		"Pictures"  = @("33E28130-4E1E-4676-835A-98395C3BC3BB", "0ddd015d-b06c-45d5-8c4c-f59713854639");
		"Videos"    = @("18989B1D-99B5-455B-841C-AB7C74E4DDFC", "35286a68-3c57-41a1-bbb1-0eae73d76c95");
	}

	$Signature = @{
		Namespace        = "WinAPI"
		Name             = "KnownFolders"
		Language         = "CSharp"
		MemberDefinition = @"
[DllImport("shell32.dll")]
public extern static int SHSetKnownFolderPath(ref Guid folderId, uint flags, IntPtr token, [MarshalAs(UnmanagedType.LPWStr)] string path);
"@
	}
	if (-not ("WinAPI.KnownFolders" -as [type]))
	{
		Add-Type @Signature
	}

	ForEach ($GUID in $KnownFoldersGuids[$KnownFolder])
	{
		[WinAPI.KnownFolders]::SHSetKnownFolderPath([ref]$GUID, 0, 0, $NewFolder)
	}

	$UserShellFoldersGUIDs = @{
		"Desktop"   = "{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}"
		"Documents" = "{F42EE2D3-909F-4907-8871-4C22FC0BF756}"
		"Downloads" = "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}"
		"Music"     = "{A0C69A99-21C8-4671-8703-7934162FCF1D}"
		"Pictures"  = "{0DDD015D-B06C-45D5-8C4C-F59713854639}"
		"Videos"    = "{35286A68-3C57-41A1-BBB1-0EAE73D76C95}"
	}

	switch ($KnownFolder) {
		"Desktop" {
			$MarkNewFolderPath = $DesktopOldpath
			Write-Host "   $($lang.LocationDesktop)" -ForegroundColor Green
		}
		"Documents" {
			$MarkNewFolderPath = $MyDocumentsOldpath
			Write-Host "   $($lang.LocationDocuments)" -ForegroundColor Green
		}
		"Downloads" {
			$MarkNewFolderPath = $DownloadsOldpath
			Write-Host "   $($lang.LocationDownloads)" -ForegroundColor Green
		}
		"Music" {
			$MarkNewFolderPath = $MusicOldpath
			Write-Host "   $($lang.LocationMusic)" -ForegroundColor Green
		}
		"Pictures" {
			$MarkNewFolderPath = $PicturesOldpath
			Write-Host "   $($lang.LocationPictures)" -ForegroundColor Green
		}
		"Videos" {
			$MarkNewFolderPath = $VideoOldpath
			Write-Host "   $($lang.LocationVideos)" -ForegroundColor Green
		}
		default {
			write-host "    $($KnownFolder)" -ForegroundColor Red
		}
	}
	
	Write-Host "   $($lang.LocationFolderOld -f $MarkNewFolderPath)"
	Write-Host "   $($lang.LocationFolderNew -f $NewFolder)"

	if ($MarkNewFolderPath -eq $NewFolder) {
		write-host "   $($lang.LocationFolderSame)`n" -ForegroundColor Red
		return
	} else {
		Check_Folder -chkpath $NewFolder

		if (Test_Available_Disk -Path $NewFolder) {
			New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name $UserShellFoldersGUIDs[$KnownFolder] -PropertyType ExpandString -Value $NewFolder -Force -ErrorAction SilentlyContinue | Out-Null

			write-host "   $($lang.LocationDoneSync)"
			if ($Global:LocationFinishSync) {
				start-process "robocopy.exe" -argumentlist "`"$($MarkNewFolderPath)`" `"$($NewFolder)`" /E /XO /W:1 /R:1" -wait -WindowStyle Minimized
				Write-Host "   $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   $($lang.Inoperable)`n" -ForegroundColor Red
			}

			write-host "   $($lang.LocationDoneClean)"
			if ($Global:LocationFinishClear) {
				Remove-Item -Path $MarkNewFolderPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
				Write-Host "   $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   $($lang.Inoperable)`n" -ForegroundColor Red
			}
		} else {
			Write-Host "   $($lang.FailedCreateFolder -f $NewFolder)`n" -ForegroundColor Red
		}
	}
}