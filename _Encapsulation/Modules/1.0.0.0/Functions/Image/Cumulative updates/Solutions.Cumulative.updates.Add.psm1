<#
	.Add update
	.添加更新
#>
Function Update_Add_UI
{
	<#
		.转换架构类型
	#>
	switch ($Global:Architecture) {
		"arm64" { $ArchitectureNew = "arm64" }
		"AMD64" { $ArchitectureNew = "x64" }
		"x86" { $ArchitectureNew = "x86" }
	}

	<#
		初始化全局变量
	#>
	$Script:Temp_Select_Update_Add_Folder = @()

	$SearchFolderRule = @(
		"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Update\$($ArchitectureNew)\Add"
		"$($Global:Image_source)_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Update\Add"
	)
	$SearchFolderRule = $SearchFolderRule | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

	$Search_Folder_Multistage_Rule = @(
		"$($Global:MainMasterFolder)\$($Global:ImageType)\_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Update"
	)
	$Search_Folder_Multistage_Rule = $Search_Folder_Multistage_Rule | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

	if (-not $Global:EventQueueMode) {
		Logo -Title "$($lang.CUpdate): $($lang.AddTo)"
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
			Update_Add_UI
		}

		Image_Get_Mount_Status

		<#
			.先决条件
		#>
		<#
			.判断是否选择 Install, Boot, WinRE
		#>
		if (-not (Image_Is_Select_IAB)) {
			Write-Host "`n   $($lang.Update): $($lang.AddTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			return
		}

		<#
			.判断挂载合法性
		#>
		if (-not (Verify_Is_Current_Same)) {
			Write-Host "`n   $($lang.Update): $($lang.AddTo)" -ForegroundColor Yellow
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

	Write-Host "`n   $($lang.Update): $($lang.AddTo)" -ForegroundColor Yellow
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

	$UI_Main_Create_New_Tempate_Click = {
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		
		$RandomGuid = "Example_$(Get-RandomHexNumber -length 5).$(Get-RandomHexNumber -length 3)"

		switch ($Global:Architecture) {
			"arm64" { $ArchitectureNew = "arm64" }
			"AMD64" { $ArchitectureNew = "x64" }
			"x86" { $ArchitectureNew = "x86" }
		}

		Check_Folder -chkpath "$($this.Tag)\$($RandomGuid)\$($ArchitectureNew)\Add"
		Check_Folder -chkpath "$($this.Tag)\$($RandomGuid)\$($ArchitectureNew)\Del"

		Update_Add_Refresh_Sourcs
	}

	Function Update_Add_Refresh_Sourcs
	{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
		$UI_Main_Rule.controls.Clear()

		<#
			.计算公式：
				四舍五入为整数
					(初始化字符长度 * 初始化字符长度）
				/ 控件高度
		#>

		<#
			.初始化字符长度
		#>
		[int]$InitCharacterLength = 78

		<#
			.初始化控件高度
		#>
		[int]$InitControlHeight = 40

		<#
			.预规则，标题
		#>
		$UI_Main_Pre_Rule  = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 520
			Padding        = "16,0,0,0"
			Text           = $lang.RulePre
		}
		$UI_Main_Rule.controls.AddRange($UI_Main_Pre_Rule)

		ForEach ($item in $SearchFolderRule) {
			$InitLength = $item.Length
			if ($InitLength -lt $InitCharacterLength) { $InitLength = $InitCharacterLength }

			$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
				Height    = $([math]::Ceiling($InitLength / $InitCharacterLength) * $InitControlHeight)
				Width     = 490
				Margin    = "35,0,0,5"
				Text      = $item
				Tag       = $item
				add_Click = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null
				}
			}
			$UI_Main_Rule.controls.AddRange($CheckBox)

			$AddSourcesPath     = New-Object system.Windows.Forms.LinkLabel -Property @{
				autosize        = 1
				Padding         = "50,0,0,0"
				margin          = "0,5,0,15"
				Text            = $lang.RuleNoFindFile
				Tag             = $item
				LinkColor       = "GREEN"
				ActiveLinkColor = "RED"
				LinkBehavior    = "NeverUnderline"
				add_Click       = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null

					if ([string]::IsNullOrEmpty($This.Tag)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
					} else {
						if (Test-Path $This.Tag -PathType Container) {
							Start-Process $This.Tag
		
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
						} else {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
						}
					}
				}
			}

			$AddSourcesPathOpen = New-Object system.Windows.Forms.LinkLabel -Property @{
				Height          = 40
				Width           = 525
				Padding         = "48,0,0,0"
				Text            = $lang.OpenFolder
				Tag             = $item
				LinkColor       = "GREEN"
				ActiveLinkColor = "RED"
				LinkBehavior    = "NeverUnderline"
				add_Click       = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null

					if ([string]::IsNullOrEmpty($This.Tag)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
					} else {
						if (Test-Path $This.Tag -PathType Container) {
							Start-Process $This.Tag
		
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
						} else {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
						}
					}
				}
			}

			$AddSourcesPathPaste = New-Object system.Windows.Forms.LinkLabel -Property @{
				Height          = 40
				Width           = 525
				Padding         = "48,0,0,0"
				Text            = $lang.Paste
				Tag             = $item
				LinkColor       = "GREEN"
				ActiveLinkColor = "RED"
				LinkBehavior    = "NeverUnderline"
				add_Click       = {
					$UI_Main_Error.Text = ""
					$UI_Main_Error_Icon.Image = $null

					if ([string]::IsNullOrEmpty($This.Tag)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.Paste), $($lang.Inoperable)"
					} else {
						Set-Clipboard -Value $This.Tag

						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
						$UI_Main_Error.Text = "$($lang.Paste), $($lang.Done)"
					}
				}
			}

			if (Test-Path $item -PathType Container) {
				if ($UI_Main_Dont_Checke_Is_Folder.Checked) {
					$CheckBox.Checked = $True
				} else {
					$CheckBox.Checked = $False
				}

				<#
					.判断目录里，是否存在文件
				#>
				if ($UI_Main_Dont_Checke_Is_File.Checked) {
					$CheckBox.Enabled = $True
				} else {
					<#
						.从目录里判断是否有文件
					#>
					if((Get-ChildItem $item -Recurse -Include ($Global:Search_KB_File_Type) -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0) {
						<#
							.提示，未发现文件
						#>

						$UI_Main_Rule.controls.AddRange($AddSourcesPath)
						$CheckBox.Enabled = $False
					} else {
						$CheckBox.Enabled = $True
					}
				}

				$UI_Main_Rule.controls.AddRange((
					$AddSourcesPathOpen,
					$AddSourcesPathPaste
				))

				$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
					Height         = 30
					Width          = 520
				}
				$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
			} else {
				$CheckBox.Enabled = $False

				$AddSourcesPathNoFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
					autosize        = 1
					Padding         = "48,0,0,0"
					Text            = $lang.RuleMatchNoFindFolder
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = {
						Check_Folder -chkpath $this.Tag
						Update_Add_Refresh_Sourcs
					}
				}
				$UI_Main_Rule.controls.AddRange($AddSourcesPathNoFolder)

				$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
					Height         = 30
					Width          = 520
				}
				$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
			}
		}

		<#
			.多级目录规则
		#>
		$UI_Main_Multistage_Rule_Name = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 520
			Padding        = "16,0,0,0"
			margin         = "0,20,0,0"
			Text           = $lang.RuleMultistage
		}
		$UI_Main_Rule.controls.AddRange($UI_Main_Multistage_Rule_Name)

		<#
			.转换架构类型
		#>
		switch ($Global:Architecture) {
			"arm64" { $ArchitectureNew = "arm64" }
			"AMD64" { $ArchitectureNew = "x64" }
			"x86" { $ArchitectureNew = "x86" }
		}

		ForEach ($item in $Search_Folder_Multistage_Rule) {
			$MarkIsFolderRule = $False
			if (Test-Path $item -PathType Container) {
				if((Get-ChildItem $item -Directory -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
					$MarkIsFolderRule = $True
				}
			}

			if ($MarkIsFolderRule) {
				$No_Find_Multistage_Rule_Create = New-Object system.Windows.Forms.LinkLabel -Property @{
					autosize        = 1
					Padding         = "33,0,0,0"
					margin          = "0,8,0,15"
					Text            = $lang.RuleMultistageFindCreateNew
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = $UI_Main_Create_New_Tempate_Click
				}
				$UI_Main_Rule.controls.AddRange($No_Find_Multistage_Rule_Create)

				Get-ChildItem -Path $item -Directory -ErrorAction SilentlyContinue | Where-Object {
					<#
						.添加：文字显示路径
					#>
					$AddSourcesPathName = New-Object system.Windows.Forms.LinkLabel -Property @{
						autosize        = 1
						Padding         = "33,0,15,0"
						margin          = "0,0,0,5"
						Text            = $_.FullName
						Tag             = $_.FullName
						LinkColor       = "GREEN"
						ActiveLinkColor = "RED"
						LinkBehavior    = "NeverUnderline"
						add_Click       = {
							$UI_Main_Error.Text = ""
							$UI_Main_Error_Icon.Image = $null

							if ([string]::IsNullOrEmpty($This.Tag)) {
								$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
								$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
							} else {
								if (Test-Path $This.Tag -PathType Container) {
									Start-Process $This.Tag
				
									$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
									$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
								} else {
									$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
									$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
								}
							}
						}
					}
					$UI_Main_Rule.controls.AddRange($AddSourcesPathName)

					Update_Add_Refresh_Sources_New -Sources $_.FullName -NewMaster $Global:Primary_Key_Image.Master -ImageName $Global:Primary_Key_Image.ImageFileName

					$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
						Height         = 30
						Width          = 520
					}
					$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
				}
			} else {
				$InitLength = $item.Length
				if ($InitLength -lt $InitCharacterLength) { $InitLength = $InitCharacterLength }

				$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
					Height    = $([math]::Ceiling($InitLength / $InitCharacterLength) * $InitControlHeight)
					Width     = 465
					Margin    = "35,0,0,5"
					Text      = $item
					Tag       = $item
					Enabled   = $False
					add_Click = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}

				$No_Find_Multistage_Rule = New-Object system.Windows.Forms.LinkLabel -Property @{
					autosize        = 1
					Padding         = "49,0,0,0"
					Text            = $lang.RuleMultistageFindFailed
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = $UI_Main_Create_New_Tempate_Click
				}

				$UI_Main_Rule.controls.AddRange((
					$CheckBox,
					$No_Find_Multistage_Rule
				))

				$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
					Height         = 30
					Width          = 520
				}
				$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
			}
		}

		<#
			.其它规则
		#>
		$UI_Main_Other_Rule = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 520
			Margin         = "0,35,0,0"
			Padding        = "18,0,0,0"
			Text           = $lang.RuleOther
		}
		$UI_Main_Rule.controls.AddRange($UI_Main_Other_Rule)
		if ($Script:Temp_Select_Update_Add_Folder.count -gt 0) {
			ForEach ($item in $Script:Temp_Select_Update_Add_Folder) {
				$InitLength = $item.Length
				if ($InitLength -lt $InitCharacterLength) { $InitLength = $InitCharacterLength }

				$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
					Height    = $([math]::Ceiling($InitLength / $InitCharacterLength) * $InitControlHeight)
					Width     = 470
					Margin    = "35,0,0,5"
					Text      = $item
					Tag       = $item
					add_Click = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}
				$UI_Main_Rule.controls.AddRange($CheckBox)

				$AddSourcesPath     = New-Object system.Windows.Forms.LinkLabel -Property @{
					autosize        = 1
					Padding         = "50,0,0,0"
					margin          = "0,5,0,5"
					Text            = $lang.RuleNoFindFile
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null

						if ([string]::IsNullOrEmpty($This.Tag)) {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
						} else {
							if (Test-Path $This.Tag -PathType Container) {
								Start-Process $This.Tag
			
								$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
								$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
							} else {
								$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
								$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
							}
						}
					}
				}

				$AddSourcesPathOpen = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height          = 40
					Width           = 470
					Padding         = "48,0,0,0"
					Text            = $lang.OpenFolder
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null

						if ([string]::IsNullOrEmpty($This.Tag)) {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
						} else {
							if (Test-Path $This.Tag -PathType Container) {
								Start-Process $This.Tag
			
								$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
								$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
							} else {
								$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
								$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
							}
						}
					}
				}

				$AddSourcesPathPaste = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height          = 40
					Width           = 470
					Padding         = "48,0,0,0"
					Text            = $lang.Paste
					Tag             = $item
					LinkColor       = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior    = "NeverUnderline"
					add_Click       = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null

						if ([string]::IsNullOrEmpty($This.Tag)) {
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
							$UI_Main_Error.Text = "$($lang.Paste), $($lang.Inoperable)"
						} else {
							Set-Clipboard -Value $This.Tag
	
							$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
							$UI_Main_Error.Text = "$($lang.Paste), $($lang.Done)"
						}
					}
				}
	
				if (Test-Path $item -PathType Container) {
					if ($UI_Main_Dont_Checke_Is_Folder.Checked) {
						$CheckBox.Checked = $True
					} else {
						$CheckBox.Checked = $False
					}
	
					<#
						.判断目录里，是否存在文件
					#>
					if ($UI_Main_Dont_Checke_Is_File.Checked) {
						$CheckBox.Enabled = $True
					} else {
						<#
							.从目录里判断是否有文件
						#>
						if((Get-ChildItem $item -Recurse -Include ($Global:Search_KB_File_Type) -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0) {
							<#
								.提示，未发现文件
							#>
							$UI_Main_Rule.controls.AddRange($AddSourcesPath)
							$CheckBox.Enabled = $False
						} else {
							$CheckBox.Enabled = $True
						}
					}
	
					$UI_Main_Rule.controls.AddRange((
						$AddSourcesPathOpen,
						$AddSourcesPathPaste
					))

					$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
						Height         = 30
						Width          = 520
					}
					$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
				} else {
					$CheckBox.Enabled = $False

					$AddSourcesPathNoFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
						autosize        = 1
						Padding         = "48,0,0,0"
						Text            = $lang.RuleMatchNoFindFolder
						Tag             = $item
						LinkColor       = "GREEN"
						ActiveLinkColor = "RED"
						LinkBehavior    = "NeverUnderline"
						add_Click       = {
							Check_Folder -chkpath $this.Tag
							Update_Del_Refresh_Sourcs
						}
					}
					$UI_Main_Rule.controls.AddRange($AddSourcesPathNoFolder)

					$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
						Height         = 30
						Width          = 520
					}
					$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
				}
			}
		} else {
			$UI_Main_Other_Rule_Not_Find = New-Object system.Windows.Forms.Label -Property @{
				Height         = 40
				Width          = 520
				Padding        = "33,0,0,0"
				Text           = $lang.NoWork
			}
			$UI_Main_Rule.controls.AddRange($UI_Main_Other_Rule_Not_Find)

			$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
				Height         = 30
				Width          = 520
			}
			$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
		}
	}

	Function Update_Add_Refresh_Sources_New
	{
		param
		(
			$NewMaster,
			$ImageName,
			$Sources
		)

		<#
			.转换架构类型
		#>
		switch ($Global:Architecture) {
			"arm64" { $ArchitectureNew = "arm64" }
			"AMD64" { $ArchitectureNew = "x64" }
			"x86" { $ArchitectureNew = "x86" }
		}

		$MarkNewFolder = "$($Sources)\$($ArchitectureNew)\Add"
		$AddSourcesPathNoFile = New-Object system.Windows.Forms.LinkLabel -Property @{
			autosize        = 1
			Padding         = "71,0,0,0"
			margin          = "0,0,0,15"
			Text            = $lang.RuleNoFindFile
			Tag             = $MarkNewFolder
			LinkColor       = "GREEN"
			ActiveLinkColor = "RED"
			LinkBehavior    = "NeverUnderline"
			add_Click       = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null

				if ([string]::IsNullOrEmpty($This.Tag)) {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
				} else {
					if (Test-Path $This.Tag -PathType Container) {
						Start-Process $This.Tag
	
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
						$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Done)"
					} else {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.OpenFolder), $($lang.Inoperable)"
					}
				}
			}
		}

		$CheckBoxInstall = New-Object System.Windows.Forms.CheckBox -Property @{
			Height    = 35
			Width     = 450
			margin    = "55,0,0,0"
			Text      = "$($ArchitectureNew)\Add"
			Tag       = $MarkNewFolder
			add_Click = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null
			}
		}
		$UI_Main_Rule.controls.AddRange($CheckBoxInstall)

		if (Test-Path $MarkNewFolder -PathType Container) {
			if ($UI_Main_Dont_Checke_Is_Folder.Checked) {
				$CheckBox.Checked = $True
			} else {
				$CheckBox.Checked = $False
			}

			<#
				.判断目录里，是否存在文件
			#>
			if ($UI_Main_Dont_Checke_Is_File.Checked) {
				$CheckBoxInstall.Enabled = $True
			} else {
				<#
					.从目录里判断是否有文件
				#>
				if((Get-ChildItem $MarkNewFolder -Recurse -Include ($Global:Search_KB_File_Type) -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0) {
					<#
						.提示，未发现文件
					#>
					$UI_Main_Rule.controls.AddRange($AddSourcesPathNoFile)
					$CheckBoxInstall.Enabled = $False
				} else {
					$CheckBoxInstall.Enabled = $True
				}
			}
		} else {
			$CheckBoxInstall.Enabled = $False

			$AddSourcesPathNoFolder = New-Object system.Windows.Forms.LinkLabel -Property @{
				autosize        = 1
				Padding         = "71,0,0,0"
				Text            = $lang.RuleMatchNoFindFolder
				Tag             = $MarkNewFolder
				LinkColor       = "GREEN"
				ActiveLinkColor = "RED"
				LinkBehavior    = "NeverUnderline"
				add_Click       = {
					Check_Folder -chkpath $this.Tag
					Update_Add_Refresh_Sourcs
				}
			}
			$UI_Main_Rule.controls.AddRange($AddSourcesPathNoFolder)

			$AddSourcesPath_Wrap = New-Object system.Windows.Forms.Label -Property @{
				Height         = 30
				Width          = 520
			}
			$UI_Main_Rule.controls.AddRange($AddSourcesPath_Wrap)
		}
	}

	$UI_Main_DragOver = [System.Windows.Forms.DragEventHandler]{
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
	
		if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
			$_.Effect = 'Copy'
		} else {
			$_.Effect = 'None'
		}
	}
	$UI_Main_DragDrop = {
		$UI_Main_Error.Text = ""
		$UI_Main_Error_Icon.Image = $null
	
		if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
			foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
				if (Test-Path -Path $filename -PathType Container) {
					$Get_Temp_Select_Update_Add_Folder = @()
					$UI_Main_Rule.Controls | ForEach-Object {
						if ($_ -is [System.Windows.Forms.CheckBox]) {
							$Get_Temp_Select_Update_Add_Folder += $_.Text
						}
					}

					if ($Get_Temp_Select_Update_Add_Folder -Contains $filename) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = $lang.Existed
					} else {
						$Script:Temp_Select_Update_Add_Folder += $filename
						Update_Add_Refresh_Sourcs
					}
				} else {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = "$($lang.SelectFromError)$($lang.SelectFolder)"
				}
			}
		}
	}

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 928
		Text           = "$($lang.Update): $($lang.AddTo)"
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
		AllowDrop      = $true
		Add_DragOver   = $UI_Main_DragOver
		Add_DragDrop   = $UI_Main_DragDrop
	}
	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 675
		Width          = 555
		autoSizeMode   = 1
		Location       = '20,0'
		Padding        = "0,15,0,0"
		autoScroll     = $True
	}

	<#
		.可选功能
	#>
	$UI_Main_Adv       = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 530
		Text           = $lang.AdvOption
	}

	<#
		.不再检查目录里是否存在文件
	#>
	$UI_Main_Dont_Checke_Is_File = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 530
		Padding        = "18,0,0,0"
		Text           = "$($lang.RuleSkipFolderCheck)$($Global:Search_KB_File_Type)"
		add_Click      = {
			if ($UI_Main_Dont_Checke_Is_File.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -name "$(Get_GPS_Location)_Is_Skip_Check_File_Add" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -name "$(Get_GPS_Location)_Is_Skip_Check_File_Add" -value "False" -String
			}

			Update_Add_Refresh_Sourcs
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -Name "$(Get_GPS_Location)_Is_Skip_Check_File_Add" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -Name "$(Get_GPS_Location)_Is_Skip_Check_File_Add" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Dont_Checke_Is_File.Checked = $True
			}
			"False" {
				$UI_Main_Dont_Checke_Is_File.Checked = $False
			}
		}
	} else {
		$UI_Main_Dont_Checke_Is_File.Checked = $False
	}

	<#
		.目录可用时，自动选择
	#>
	$UI_Main_Dont_Checke_Is_Folder = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 530
		Padding        = "18,0,0,0"
		Text           = $lang.RuleFindFolder
		add_Click      = {
			if ($UI_Main_Dont_Checke_Is_Folder.Checked) {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -name "$(Get_GPS_Location)_Is_Check_Folder_Available_Add" -value "True" -String
			} else {
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -name "$(Get_GPS_Location)_Is_Check_Folder_Available_Add" -value "False" -String
			}

			Update_Add_Refresh_Sourcs
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -Name "$(Get_GPS_Location)_Is_Check_Folder_Available_Add" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Update" -Name "$(Get_GPS_Location)_Is_Check_Folder_Available_Add" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Main_Dont_Checke_Is_Folder.Checked = $True
			}
			"False" {
				$UI_Main_Dont_Checke_Is_Folder.Checked = $False
			}
		}
	} else {
		$UI_Main_Dont_Checke_Is_Folder.Checked = $True
	}

	<#
		.固化更新
	#>
	$GUIUpdateAddCuring = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 515
		Margin         = "18,15,0,0"
		Text           = $lang.CuringUpdate
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUpdateAddCuringTips = New-Object System.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Margin         = "36,0,0,0"
		Text           = $lang.CuringUpdateTips
	}

	<#
		.清理取代的
	#>
	$UI_Main_Superseded_Rule = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Margin         = "36,20,0,0"
		Text           = $lang.Superseded
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Superseded_Rule_Tips = New-Object system.Windows.Forms.Label -Property @{
		AutoSize       = 1
		Margin         = "52,0,0,10"
		Text           = $lang.SupersededTips
	}
	$UI_Main_Superseded_Rule_Exclude = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 530
		Padding        = "52,0,0,0"
		Text           = $lang.ExcludeItem
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Superseded_Rule_View_Detailed = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 530
		Padding        = "68,0,0,0"
		Text           = $lang.Exclude_View
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
			$UI_Main_View_Detailed.Visible = $True
			$UI_Main_View_Detailed_Show.Text = ""

			$UI_Main_View_Detailed_Show.Text += "   $($lang.ExcludeItem)`n"
			ForEach ($item in $Global:ExcludeClearSuperseded) {
				$UI_Main_View_Detailed_Show.Text += "       $($item)`n"
			}
		}
	}

	<#
		.Select the rule
		.选择规则
	#>
	$UI_Main_Rule_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 530
		margin         = "0,40,0,0"
		Text           = $lang.AddSources
	}
	$UI_Main_Rule      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		autosize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
	}

	<#
		.刷新
	#>
	$UI_Main_Refresh_Sources = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,10"
		Height         = 36
		Width          = 280
		Text           = $lang.Refresh
		add_Click      = {
			Update_Add_Refresh_Sourcs

			$UI_Main_Error.Text = "$($lang.Refresh), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Success.ico")
		}
	}

	<#
		.选择目录
	#>
	$UI_Main_Select_Folder = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,50"
		Height         = 36
		Width          = 280
		Text           = $lang.SelectFolder
		add_Click      = {
			$Get_Temp_Select_Update_Add_Folder = @()
			$UI_Main_Rule.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					$Get_Temp_Select_Update_Add_Folder += $_.Text
				}
			}

			$FolderBrowser   = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
				RootFolder   = "MyComputer"
			}

			if ($FolderBrowser.ShowDialog() -eq "OK") {
				if ($Get_Temp_Select_Update_Add_Folder -Contains $FolderBrowser.SelectedPath) {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = $lang.Existed
				} else {
					$Script:Temp_Select_Update_Add_Folder += $FolderBrowser.SelectedPath
					Update_Add_Refresh_Sourcs
				}
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = $lang.UserCanel
			}
		}
	}
	$UI_Main_Select_Folder_Tips = New-Object system.Windows.Forms.Label -Property @{
		Height         = 100
		Width          = 260
		Location       = "628,95"
		Text           = $lang.DropFolder
	}

	<#
		.Mask: Displays the rule details
		.蒙板：显示规则详细信息
	#>
	$UI_Main_View_Detailed = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 1006
		autoSizeMode   = 1
		Padding        = "8,0,8,0"
		Location       = '0,0'
		Visible        = 0
	}
	$UI_Main_View_Detailed_Show = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 600
		Width          = 880
		BorderStyle    = 0
		Location       = "15,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_View_Detailed_Canel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main_View_Detailed.Visible = $False
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
			Event_Need_Mount_Global_Variable -DevQueue "25" -Master $Global:Primary_Key_Image.Master -ImageFileName $Global:Primary_Key_Image.ImageFileName
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
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			
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
		Location       = "620,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "645,525"
		Height         = 60
		Width          = 255
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "620,595"
		Height         = 36
		Width          = 280
		Text           = $lang.OK
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			New-Variable -Scope global -Name "Queue_Is_Update_Add_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			$Temp_Queue_Update_Add_Select = @()
			$UI_Main_Rule.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							Write-Host "   $($_.Tag)" -ForegroundColor Green
							$Temp_Queue_Update_Add_Select += $_.Tag
						}
					}
				}
			}

			if ($Temp_Queue_Update_Add_Select.Count -gt 0) {
				$UI_Main.Hide()
				New-Variable -Scope global -Name "Queue_Is_Update_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				New-Variable -Scope global -Name "Queue_Is_Update_Add_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Queue_Update_Add_Select -Force

				<#
					.固化更新
				#>
				Write-Host "`n   $($lang.CuringUpdate)" -ForegroundColor Yellow
				New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
				if ($GUIUpdateAddCuring.Enabled) {
					if ($GUIUpdateAddCuring.Checked) {
						Write-Host "   $($lang.Operable)" -ForegroundColor Green

						New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					} else {
						Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
					}
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}

				<#
					.清理取代的
				#>
				New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
				New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
				Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
				if ($UI_Main_Superseded_Rule.Enabled) {
					if ($UI_Main_Superseded_Rule.Checked) {
						Write-Host "   $($lang.Operable)" -ForegroundColor Green

						New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					} else {
						Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
					}

					if ($UI_Main_Superseded_Rule_Exclude.Enabled) {
						if ($UI_Main_Superseded_Rule_Exclude.Checked) {
							New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
						}
					}
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
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
		Location       = "620,635"
		Height         = 36
		Width          = 280
		Text           = $lang.Cancel
		add_Click      = {
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			New-Variable -Scope global -Name "Queue_Is_Update_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Is_Update_Add_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

			<#
				.固化更新
			#>
			Write-Host "`n   $($lang.CuringUpdate)" -ForegroundColor Yellow
			New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			if ($GUIUpdateAddCuring.Enabled) {
				if ($GUIUpdateAddCuring.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green

					New-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			<#
				.清理取代的
			#>
			New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $False -Force
			Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
			if ($UI_Main_Superseded_Rule.Enabled) {
				if ($UI_Main_Superseded_Rule.Checked) {
					Write-Host "   $($lang.Operable)" -ForegroundColor Green

					New-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
				} else {
					Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
				}

				if ($UI_Main_Superseded_Rule_Exclude.Enabled) {
					if ($UI_Main_Superseded_Rule_Exclude.Checked) {
						New-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $True -Force
					}
				}
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			if ($UI_Main_Suggestion_Not.Checked) {
				Init_Canel_Event
			}
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_View_Detailed,
		$UI_Main_Menu,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_Refresh_Sources,
		$UI_Main_Select_Folder,
		$UI_Main_Select_Folder_Tips,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	$UI_Main_View_Detailed.controls.AddRange((
		$UI_Main_View_Detailed_Show,
		$UI_Main_View_Detailed_Canel
	))
	$UI_Main_Menu.controls.AddRange((
		$UI_Main_Adv,
		$UI_Main_Is_Chheck_Mount_Type,
		$UI_Main_Dont_Checke_Is_File,
		$UI_Main_Dont_Checke_Is_Folder,
		$GUIUpdateAddCuring,
		$GUIUpdateAddCuringTips,
		$UI_Main_Superseded_Rule,
		$UI_Main_Superseded_Rule_Tips,
		$UI_Main_Superseded_Rule_Exclude,
		$UI_Main_Superseded_Rule_View_Detailed,
		$UI_Main_Rule_Name,
		$UI_Main_Rule
	))

	<#
		.判断 boot.wim
	#>
	if (Image_Is_Select_Boot) {
		<#
			.清理取代的
		#>
		$UI_Main_Superseded_Rule.Checked = $False
		$UI_Main_Superseded_Rule.Enabled = $False
		$UI_Main_Superseded_Rule_Exclude.Enabled = $False

		<#
			.固化更新
		#>
		$GUIUpdateAddCuring.Checked = $False
		$GUIUpdateAddCuring.Enabled = $False
	}

	if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Superseded_Rule.Checked = $True
	} else {
		$UI_Main_Superseded_Rule.Checked = $False
	}

	if ((Get-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$GUIUpdateAddCuring.Checked = $True
	} else {
		$GUIUpdateAddCuring.Checked = $False
	}

	if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_Allow_Rule_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$UI_Main_Superseded_Rule_Exclude.Checked = $True
	} else {
		$UI_Main_Superseded_Rule_Exclude.Checked = $False
	}

	Update_Add_Refresh_Sourcs

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUIUpdateAddMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUIUpdateAddMenu.Items.Add($lang.AllSel).add_Click({
		$UI_Main_Rule.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$GUIUpdateAddMenu.Items.Add($lang.AllClear).add_Click({
		$UI_Main_Rule.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$UI_Main_Rule.ContextMenuStrip = $GUIUpdateAddMenu

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
	.Start processing to add updates
	.开始处理添加更新
#>
Function Update_Add_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = "$($lang.Update): $($lang.AddTo)"
	}

	$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_Update_Add_Custom_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	if ($Temp_Assign_Task_Select.count -gt 0) {
		Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		ForEach ($item in $Temp_Assign_Task_Select) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Assign_Task_Select) {
			Get-ChildItem $item -Recurse -Include ($Global:Search_KB_File_Type) -ErrorAction SilentlyContinue | ForEach-Object {
				if (Test-Path -Path $_.FullName -PathType Leaf) {
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)95" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Add-WindowsPackage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" -PackagePath ""$($_.FullName)""" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}

					Write-Host "   $($_.FullName)" -ForegroundColor Green
					Write-Host "   $($lang.AddTo)".PadRight(28) -NoNewline
					try {
						Add-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Add.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PackagePath "$($_.FullName)" -ErrorAction SilentlyContinue | Out-Null
						Write-Host $lang.Done -ForegroundColor Green
					} catch {
						Write-Host $lang.SelectFromError -ForegroundColor Red
						Write-Host "   $($_)" -ForegroundColor Yellow
						Write-Host "   $($lang.AddTo), $($lang.Failed)" -ForegroundColor Red
					}

					Write-Host ""
				}
			}
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}