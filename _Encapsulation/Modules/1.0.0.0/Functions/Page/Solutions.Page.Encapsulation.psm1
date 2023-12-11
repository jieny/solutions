Function Logo
{
	param
	(
		$Title
	)

	Clear-Host
	$Host.UI.RawUI.WindowTitle = "$((Get-Module -Name Solutions).Author)'s Solutions | $($Title)"
	Write-Host "`n   $((Get-Module -Name Solutions).Author)'s Solutions, v$((Get-Module -Name Solutions).Version.ToString())"
	Write-host "   $((Get-Module -Name Solutions).PrivateData.PSData.ProjectUri)" -ForegroundColor Yellow

	Write-host
}

Function ToWait
{
	param
	(
		[int]$Wait,
		[int]$To
	)

	Write-Host "   $($lang.ToMsg -f $wait)" -ForegroundColor Red
	start-process "timeout.exe" -argumentlist "/t $($wait) /nobreak" -wait -nonewwindow
}

Function Mainpage
{
	$Global:EventQueueMode = $False

	if (-not $Global:EventQueueMode) {
		Logo -Title $($lang.Menu)
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
			Mainpage
		}

		Image_Get_Mount_Status
	}

	Write-Host "`n   $($lang.Menu)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      1   " -NoNewline -ForegroundColor Yellow
	Write-Host "$($lang.Mount), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.AddTo), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.Del), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.Update), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.LanguageExtract), " -ForegroundColor Green -NoNewline
#	Write-Host "$($lang.Wim_Rename), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.Export_Image), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.Rebuild), " -ForegroundColor Green -NoNewline
	Write-Host "$($lang.Apply)" -ForegroundColor Green

	Write-Host "      2   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.UnpackISO -ForegroundColor Yellow

	Write-Host "      3   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.MoreFeature -ForegroundColor Yellow

	Write-Host "      4   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Mount_Specified -Master "Install" -ImageFileName "Install") {
		Write-host "$($lang.Convert_Only), $($lang.Conver_Merged), $($lang.Conver_Split_To_Swm)" -ForegroundColor Red
	} else {
		Write-Host "$($lang.Convert_Only), $($lang.Conver_Merged), $($lang.Conver_Split_To_Swm)" -ForegroundColor Green
	}

	Write-host "`n   $($lang.AssignNeedMount)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "     11   " -NoNewline -ForegroundColor Yellow
	Write-Host "$($lang.Mounted_Status): " -ForegroundColor Yellow -NoNewline
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host "$($lang.Mount), $($lang.Unmount)" -ForegroundColor Green
		} else {
			Write-host "$($lang.Mount), $($lang.Unmount)" -ForegroundColor Red
		}
	} else {
		Write-host "$($lang.Mount), $($lang.Unmount)" -ForegroundColor Red
	}

	Write-Host "     12   $($lang.Solution): " -NoNewline -ForegroundColor Yellow
	Write-Host "$($lang.IsCreate), " -NoNewline -ForegroundColor Green
	if ((Test-Path "$($Global:Image_source)\Autounattend.xml" -PathType Leaf) -or
		(Test-Path "$($Global:Image_source)\Sources\Unattend.xml" -PathType Leaf) -or
		(Test-Path "$($Global:Image_source)\Sources\`$OEM$" -PathType Container))
	{
		Write-host "$($lang.Del)" -ForegroundColor Green
	} else {
		Write-host "$($lang.Del)" -ForegroundColor Red
	}

	Write-Host "     13   $($lang.Language): " -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.LanguageExtract), " -NoNewline -ForegroundColor Green
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.AddTo), " -ForegroundColor Green -NoNewline
			Write-Host "$($lang.Del), " -ForegroundColor Green -NoNewline
			Write-host "$($lang.SwitchLanguage)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
			Write-Host "$($lang.Del), " -ForegroundColor Red -NoNewline
			Write-host "$($lang.SwitchLanguage)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Del), " -ForegroundColor Red -NoNewline
		Write-host "$($lang.SwitchLanguage)" -ForegroundColor Red
	}

	Write-Host "     14   $($lang.InboxAppsManager): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_Install) {
		Write-Host "$($lang.AddTo), " -ForegroundColor Green -NoNewline
		Write-Host "$($lang.Del), " -ForegroundColor Green -NoNewline
		Write-Host "$($lang.Update)" -ForegroundColor Green
	} else {
		Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Del), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Update)" -ForegroundColor Red
	}

	Write-Host "     15   $($lang.CUpdate): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.AddTo), " -ForegroundColor Green -NoNewline
			Write-host "$($lang.Del)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
			Write-Host "$($lang.Del)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Del)" -ForegroundColor Red
	}

	Write-Host "     16   $($lang.Drive): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.AddTo), " -ForegroundColor Green -NoNewline
			Write-host "$($lang.Del)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
			Write-Host "$($lang.Del)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.AddTo), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Del)" -ForegroundColor Red
	}

	Write-Host "     17   $($lang.Editions): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.Change), $($lang.EditionsProductKey)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.Change), $($lang.EditionsProductKey)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.Change), $($lang.EditionsProductKey)" -ForegroundColor Red
	}

	Write-Host "     18   $($lang.WindowsFeature): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.Enable), " -ForegroundColor Green -NoNewline
			Write-Host "$($lang.Disable)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.Enable), " -ForegroundColor Red -NoNewline
			Write-Host "$($lang.Disable)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.Enable), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Disable)" -ForegroundColor Red
	}

	Write-Host "     19   $($lang.SpecialFunction): " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-Host "$($lang.Functions_Before), " -ForegroundColor Green -NoNewline
			Write-Host "$($lang.Functions_Rear)" -ForegroundColor Green
		} else {
			Write-Host "$($lang.Functions_Before), " -ForegroundColor Red -NoNewline
			Write-Host "$($lang.Functions_Rear)" -ForegroundColor Red
		}
	} else {
		Write-Host "$($lang.Functions_Before), " -ForegroundColor Red -NoNewline
		Write-Host "$($lang.Functions_Rear)" -ForegroundColor Red
	}

	Write-Host "`n      A   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.OnDemandPlanTask -ForegroundColor Green
	Write-Host "      S   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.Setting

	Write-Host "      H   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.Help

	Write-Host "      R   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.RefreshModules

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'1' {
			Image_Assign_Event_Master
			ToWait -wait 2
			Mainpage
		}
		'2' {
			ISO_Create
			ToWait -wait 2
			Mainpage
		}
		'3' {
			Feature_More
			ToWait -wait 2
			Mainpage
		}
		'4' {
			Image_Convert
			ToWait -wait 2
			Mainpage
		}
		'11' {
			Image_Eject
			ToWait -wait 2
			Mainpage
		}
		'12' {
			Solutions_Menu
			ToWait -wait 2
			Mainpage
		}
		'13' {
			Language_Menu
			ToWait -wait 2
			Mainpage
		}
		'14' {
			inBox_Apps_Menu
			ToWait -wait 2
			Mainpage
		}
		'15' {
			Update_Menu
			ToWait -wait 2
			Mainpage
		}
		'16' {
			Drive_Menu
			ToWait -wait 2
			Mainpage
		}
		'17' {
			Editions_GUI
			ToWait -wait 2
			Mainpage
		}
		'18' {
			Feature_Menu
			ToWait -wait 2
			Mainpage
		}
		'19' {
			Functions_Menu
			ToWait -wait 2
			Mainpage
		}
		'a' {
			Event_Assign_Task_Customize

			ToWait -wait 2
			Mainpage
		}
		'i' {
			Write-Host "`n   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
			Write-Host "Install;Install;" -ForegroundColor Green

			Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
			Write-Host "Install;Install;wim;" -ForegroundColor Green

			Write-Host "   $($lang.Select_Path): " -NoNewline -ForegroundColor Yellow
			Write-Host "$($Global:Image_source)\sources\install.wim" -ForegroundColor Green

			if (Test-Path "$($Global:Image_source)\sources\install.wim" -PathType Leaf) {
				Image_Set_Global_Primary_Key -Uid "Install;Install;wim;" -Detailed -DevCode "27"
			} else {
				Write-Host "`n   $($lang.NoInstallImage)"
				Write-host "   $($Global:Image_source)\sources\install.wim" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}
		'w' {
			Write-Host "`n   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
			Write-Host "Install;Install;" -ForegroundColor Green

			Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
			Write-Host "Install;WinRE;wim;" -ForegroundColor Green

			Write-Host "   $($lang.Select_Path)"
			Write-Host "   $($Global:Mount_To_Route)\Install\Install\Mount\Windows\System32\Recovery\WinRe.wim" -ForegroundColor Green

			if (Test-Path "$($Global:Mount_To_Route)\Install\Install\Mount\Windows\System32\Recovery\WinRe.wim" -PathType Leaf) {
				Image_Set_Global_Primary_Key -Uid "Install;WinRE;wim;" -Detailed -DevCode "28"
			} else {
				Write-Host "`n   $($lang.NoInstallImage)"
				Write-host "   $($Global:Mount_To_Route)\Install\Install\Mount\Windows\System32\Recovery\WinRe.wim" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}
		'b' {
			Write-Host "`n   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
			Write-Host "Boot;Boot;" -ForegroundColor Green

			Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
			Write-Host "Boot;Boot;wim;" -ForegroundColor Green

			Write-Host "   $($lang.Select_Path)" -ForegroundColor Yellow
			Write-Host "   $($Global:Image_source)\sources\boot.wim" -ForegroundColor Green

			if (Test-Path "$($Global:Image_source)\sources\boot.wim" -PathType Leaf) {
				Image_Set_Global_Primary_Key -Uid "Boot;Boot;wim;" -Detailed -DevCode "29"
			} else {
				Write-Host "`n   $($lang.NoInstallImage)"
				Write-host "   $($Global:Image_source)\sources\boot.wim" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			设置、选择映像源
		#>
		's' {
			Image_Select
			ToWait -wait 2
			Mainpage
		}

		<#
			重新加载脚本
		#>
		"r" {
			Modules_Refresh -Function "Requirements", "Mainpage"
		}

		<#
			快捷指令
		#>
		<#
			.快捷指令：挂载
		#>
		'mount' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Mount)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				} else {
					Image_Set_Global_Primary_Key -Uid $Global:Primary_Key_Image.Uid -Detailed -DevCode "1026"
					Image_Select_Index_UI
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
				Image_Assign_Event_Master
			}

			ToWait -wait 2
			Mainpage
		}
		
		<#
			.快捷指令：卸载，默认不保存
		#>
		'unmount' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Unmount)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green

					Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -Discard -ErrorAction SilentlyContinue | Out-Null
					Image_Mount_Force_Del -NewPath "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"
					Write-Host "   $($lang.Done)" -ForegroundColor Green
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：添加
		#>
		'Add' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.AddTo)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				} else {
					Image_Select_Add_UI
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：删除
		#>
		'Delete' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Del)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				} else {
					Image_Select_Del_UI
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：提取语言
		#>
		'EL' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.LanguageExtract)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Language_Extract_UI

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：重建映像文件
		#>
		'Rebuild' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Rebuild)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				} else {
					Rebuild_Image_File -Filename $Global:Primary_Key_Image.FullPath
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：导出
		#>
		'Apply' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Apply)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				Image_Select_Index_UI
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：导出
		#>
		'Export' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Export_Image)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				} else {
					Image_Select_Export_UI
					Get_Next
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：保存当前映像
		#>
		'Save' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow

			Write-host "`n   $($lang.Save)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Save-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Save.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | Out-Null
					Write-Host "   $($lang.Done)" -ForegroundColor Green
					Get_Next
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：提取、更新映像内里的文件
		#>
		'euwl' {
			Write-Host "`n   $($lang.Short_Cmd)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-host "`n   $($lang.Wim_Rule_Update)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Image_Set_Global_Primary_Key -Uid $Global:Primary_Key_Image.Uid -Detailed -DevCode "9846"
				Wimlib_Extract_And_Update
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：解决方案：创建
		#>
		'sc' {
			Solutions
			ToWait -wait 2
			Mainpage
		}

		<#
			.快捷指令：在线更新
		#>
		'Update' {
			Update
			ToWait -wait 2
			Mainpage
		}

		<#
			.帮助
		#>
		'h' {
			Clear-Host
			Logo -Title $($lang.Help)

			Write-Host "   $($lang.Short_Cmd)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($lang.Event_Primary_Key)"
			Write-host "      b".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host "Boot.wim"

			Write-host "      i".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host "Install.wim"

			Write-host "      w".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host "WinRE.wim"

			Write-host "`n   $($lang.SelectSettingImage)"
			write-host "      Mount".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Mount


			Write-Host "      Add".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.AddTo

			Write-Host "      Delete".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Del

			Write-Host "      Export".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Export_Image

			Write-Host "      Rebuild".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Rebuild

			Write-Host "      Apply".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Apply

			Write-Host "      Euwl".PadRight(18) -NoNewline -ForegroundColor Yellow

			Write-host $lang.Wim_Rule_Update
			Write-host "`n   $($lang.Unzip_Language), $($lang.Unzip_Fod)"
			Write-Host "      EL".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.LanguageExtract

			Write-host "`n   $($lang.Mounted_Status)"
			Write-Host "      Save".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Save

			Write-Host "      Unmount".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host $lang.Unmount

			Write-host "`n   $($lang.RuleOther)"
			Write-Host "      SC".PadRight(18) -NoNewline -ForegroundColor Yellow
			Write-host "$($lang.Solution): $($lang.IsCreate)"

			Get_Next
			ToWait -wait 2
			Mainpage
		}

		<#
			.退出
		#>
		'q' {
			Modules_Import
			Stop-Process $PID
			exit
		}
		default {
			Mainpage
		}

		<#
			.快速测试区域
		#>
		't' {
			# Temp test Code






			<#
				.暂停
			#>
			Get_Next

			<#
				.添加 ToWait 防止直接退出
			#>
			ToWait -wait 2
			Mainpage
		}
	}
}