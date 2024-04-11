﻿<#
	.Export image source user interface
	.导出映像源用户界面
#>
Function Image_Select_Export_UI
{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 876
		Text           = "$($lang.PleaseChoose): $($lang.Export_Image)"
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
	}
	$UI_Main_Menu      = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 580
		Width          = 500
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "15,8,0,0"
		Dock           = 3
	}

	<#
		.Note
		.注意
	#>
	$UI_Main_Tips   = New-Object System.Windows.Forms.RichTextBox -Property @{
		Height         = 300
		Width          = 270
		BorderStyle    = 0
		Location       = "575,15"
		Text           = $lang.SelectTips
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "570,523"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "595,525"
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
			$MarkSelectIndexin = @()
	
			 <#
				 .Mark: Check the selection status
				 .标记：检查选择状态
			 #>
	
			$UI_Main_Menu.Controls | ForEach-Object {
				if ($_.Enabled) {
					if ($_.Checked) {
						$MarkSelectIndexin += $_.Tag
					}
				}
			}
	
			if ($MarkSelectIndexin.Count -gt 0) {
				Write-Host "   $($lang.AddSources)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				ForEach ($item in $MarkSelectIndexin) {
					ForEach ($itemDetail in $Global:Primary_Key_Image.Index) {
						if ($item -eq $itemDetail.ImageIndex) {
							Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
							Write-Host $itemDetail.ImageName -ForegroundColor Yellow
	
							Write-Host "   $($lang.MountedIndex): " -NoNewline
							Write-Host $itemDetail.ImageIndex -ForegroundColor Yellow

							Write-host ""
						}
					}
				}
	
				Write-Host "   $($lang.AddQueue)" -ForegroundColor Yellow
				Write-host "   $('-' * 80)"
				switch ($Global:Primary_Key_Image.Suffix) {
					"swm" {
						$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
							FileName = "$($Global:Primary_Key_Image.ImageFileName).wim"
							Filter   = "Export WIM Files (*.wim;)|*.wim;"
						}
	
						if ($FileBrowser.ShowDialog() -eq "OK") {
							$UI_Main.Hide()
	
							ForEach ($item in $MarkSelectIndexin) {
								ForEach ($itemDetail in $Global:Primary_Key_Image.Index) {
									if ($item -eq $itemDetail.ImageIndex) {
										Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
										Write-Host $itemDetail.ImageName -ForegroundColor Yellow
	
										Write-Host "   $($lang.MountedIndex): " -NoNewline
										Write-Host $itemDetail.ImageIndex -ForegroundColor Yellow

										Write-Host "   $($lang.AddTo)".PadRight(28) -NoNewline
	
										try {
											if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
												Write-Host "`n   $($lang.Command)" -ForegroundColor Green
												Write-host "   $($lang.Developers_Mode_Location)86" -ForegroundColor Green
												Write-host "   $('-' * 80)"
	
												dism /ScratchDir:"""$(Get_Mount_To_Temp)""" /LogPath:"$(Get_Mount_To_Logs)\Export.log" /export-image /SourceImageFile:"""$($Global:Primary_Key_Image.FullPath)""" /swmfile:"""$($Global:Primary_Key_Image.Path)\$($Global:Primary_Key_Image.ImageFileName)*.$($Global:Primary_Key_Image.Suffix)""" /SourceIndex:"""$($itemDetail.ImageIndex)""" /DestinationImageFile:"""$($FileBrowser.FileName)""" /Compress:max /CheckIntegrity
												Write-host "   $('-' * 80)`n"
											}
	
											dism /ScratchDir:"""$(Get_Mount_To_Temp)""" /LogPath:"$(Get_Mount_To_Logs)\Export.log" /export-image /SourceImageFile:"""$($Global:Primary_Key_Image.FullPath)""" /swmfile:"""$($Global:Primary_Key_Image.Path)\$($Global:Primary_Key_Image.ImageFileName)*.$($Global:Primary_Key_Image.Suffix)""" /SourceIndex:"""$($itemDetail.ImageIndex)""" /DestinationImageFile:"""$($FileBrowser.FileName)""" /Compress:max /CheckIntegrity
	
											Write-Host $lang.Done -ForegroundColor Green
										} catch {
											Write-Host $lang.SelectFromError -ForegroundColor Red
											Write-Host "   $($_)" -ForegroundColor Yellow
											Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
										}

										Write-host ""
									}
								}
							}
							$UI_Main.Close()
						} else {
							Write-host "   $($lang.UserCancel)"
						}
					}
					"esd" {
						$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
							FileName = "$($Global:Primary_Key_Image.ImageFileName).wim"
							Filter   = "Export WIM Files (*.wim;)|*.wim;"
						}
	
						if ($FileBrowser.ShowDialog() -eq "OK") {
							$UI_Main.Hide()
	
							ForEach ($item in $MarkSelectIndexin) {
								ForEach ($itemDetail in $Global:Primary_Key_Image.Index) {
									if ($item -eq $itemDetail.ImageIndex) {
										Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
										Write-Host $itemDetail.ImageName -ForegroundColor Yellow
	
										Write-Host "   $($lang.MountedIndex): " -NoNewline
										Write-Host $itemDetail.ImageIndex -ForegroundColor Yellow
	
										Write-Host "   $($lang.Export_Image)".PadRight(28) -NoNewline
	
										try {
											if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
												Write-Host "`n   $($lang.Command)" -ForegroundColor Green
												Write-host "   $($lang.Developers_Mode_Location)86" -ForegroundColor Green
												Write-host "   $('-' * 80)"
	
												write-host "   Export-WindowsImage -SourceImagePath ""$($Global:Primary_Key_Image.FullPath)"" -SourceIndex ""$($item)"" -DestinationImagePath ""$($FileBrowser.FileName)"" -CompressionType max -CheckIntegrity" -ForegroundColor Green
												Write-host "   $('-' * 80)`n"
											}
	
											Export-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Export.log" -SourceImagePath "$($Global:Primary_Key_Image.FullPath)" -SourceIndex $item -DestinationImagePath $FileBrowser.FileName -CompressionType max -CheckIntegrity -ErrorAction SilentlyContinue | Out-Null
	
											Write-Host $lang.Done -ForegroundColor Green
										} catch {
											Write-Host $lang.SelectFromError -ForegroundColor Red
											Write-Host "   $($_)" -ForegroundColor Yellow
											Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
										}

										Write-host ""
									}
								}
							}
	
							$UI_Main.Close()
						} else {
							Write-host "   $($lang.UserCancel)"
						}
					}
					Default {
						$UI_Main.Hide()
						Remove-Item -Path "$($Global:Image_source)\sources\ReBuild.wim" -ErrorAction SilentlyContinue
	
						Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
						Write-host "   $('-' * 80)"
						ForEach ($item in $MarkSelectIndexin) {
							ForEach ($itemDetail in $Global:Primary_Key_Image.Index) {
								if ($item -eq $itemDetail.ImageIndex) {
									Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
									Write-Host $itemDetail.ImageName -ForegroundColor Yellow
	
									Write-Host "   $($lang.MountedIndex): " -NoNewline
									Write-Host $itemDetail.ImageIndex -ForegroundColor Yellow	

									Write-Host "   $($lang.Export_Image)".PadRight(28) -NoNewline
	
									try {
										if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
											Write-Host "`n   $($lang.Command)" -ForegroundColor Green
											Write-host "   $($lang.Developers_Mode_Location)86" -ForegroundColor Green
											Write-host "   $('-' * 80)"
	
											write-host "   Export-WindowsImage -SourceImagePath ""$($Global:Primary_Key_Image.FullPath)"" -SourceIndex ""$($item)"" -DestinationImagePath ""$($Global:Image_source)\sources\ReBuild.wim"" -CompressionType max -CheckIntegrity" -ForegroundColor Green
											Write-host "   $('-' * 80)`n"
										}
	
										Export-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Export.log" -SourceImagePath "$($Global:Primary_Key_Image.FullPath)" -SourceIndex $($item) -DestinationImagePath "$($Global:Image_source)\sources\ReBuild.wim" -CompressionType max -CheckIntegrity -ErrorAction SilentlyContinue | Out-Null

										Write-Host $lang.Done -ForegroundColor Green
									} catch {
										Write-Host $lang.SelectFromError -ForegroundColor Red
										Write-Host "   $($_)" -ForegroundColor Yellow
										Write-Host "   $($lang.Del), $($lang.Failed)" -ForegroundColor Red
									}

									Write-host ""
								}
							}
						}
	
						<#
							.导出，检查是否成功
						#>
						if (Test-Path -Path "$($Global:Image_source)\sources\ReBuild.wim" -PathType Leaf) {
							Remove-Item -Path "$($Global:Primary_Key_Image.FullPath)" -ErrorAction SilentlyContinue
							Rename-Item -Path "$($Global:Image_source)\sources\ReBuild.wim" -NewName "$($Global:Primary_Key_Image.FullPath)" -ErrorAction SilentlyContinue
	
							Write-Host "   $($lang.Done)" -ForegroundColor Green
						} else {
							Write-Host "   $($lang.AddTo), $($lang.Failed)" -ForegroundColor Red
						}
	
						$UI_Main.Close()
					}
				}
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
			Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$UI_Main_Tips,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK,
		$UI_Main_Canel
	))

	ForEach ($item in $Global:Primary_Key_Image.Index) {
		$CheckBox     = New-Object System.Windows.Forms.CheckBox -Property @{
			Height    = 55
			Width     = 450
			margin    = "0,0,0,18"
			Text      = "$($lang.Wim_Image_Name): $($item.ImageName)`n$($lang.MountedIndex): $($item.ImageIndex)"
			Tag       = $item.ImageIndex
			add_Click = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null
			}
		}

		$UI_Main_Menu.controls.AddRange($CheckBox)
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