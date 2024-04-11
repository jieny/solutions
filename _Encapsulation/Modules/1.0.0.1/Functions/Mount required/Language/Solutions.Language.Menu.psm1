﻿<#
	.Menu: Language
	.菜单：语言
#>
Function Language_Menu
{
	Logo -Title $lang.Language
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
		Language_Menu
	}

	Image_Get_Mount_Status

	Write-Host "`n   $($lang.Language)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "      E   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.LanguageExtract -ForegroundColor Green

	Write-Host "      1   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		Write-host $lang.AddTo -ForegroundColor Green
	} else {
		Write-host $lang.AddTo -ForegroundColor Red
	}

	Write-Host "      2   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		Write-host $lang.Del -ForegroundColor Green
	} else {
		Write-host $lang.Del -ForegroundColor Red
	}

	Write-Host "      3   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		Write-host $lang.SwitchLanguage -ForegroundColor Green
	} else {
		Write-host $lang.SwitchLanguage -ForegroundColor Red
	}

	$LanguageRepair_ISO_Path = "$($Global:Image_source)\sources"
	$LanguageRepair_Path = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Sources"
		$SearchFolderRule = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Language\Repair"
		$SearchFolderRuleCustom = "$($Global:Image_source)_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Language\Repair"

	Write-Host "`n   $($lang.BootSyncToISO)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if (Verify_Is_Current_Same) {
		if (Image_Is_Select_Boot) {
			Write-Host "      4   " -NoNewline -ForegroundColor Yellow
			if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
				Write-host $lang.BootSyncToISO -ForegroundColor Green
			} else {
				Write-host $lang.BootSyncToISO -ForegroundColor Red
			}

			Write-Host "          > $($lang.ProcessSources): "
			Write-host "            $($LanguageRepair_Path)" -ForegroundColor Yellow

			Write-host "          + $($Lang.Sync_Language_To): "
			Write-host "            $($LanguageRepair_ISO_Path)" -ForegroundColor Yellow
		} else {
			Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
		}
	} else {
		Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
	}

	Write-Host "`n   $($lang.Setup_Fix_Missing)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if (Verify_Is_Current_Same) {
		if (Image_Is_Select_Boot) {
			if (Test-Path $SearchFolderRule -PathType Container) {
				Write-host "   $($SearchFolderRule)" -ForegroundColor Yellow

				Write-Host "     11   " -NoNewline -ForegroundColor Yellow
				if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
					Write-host $lang.Mounted -ForegroundColor Green
				} else {
					Write-host $lang.Mounted -ForegroundColor Red
				}
			
				Write-Host "     12   " -NoNewline -ForegroundColor Yellow
				if (Test-Path -Path $LanguageRepair_ISO_Path -PathType Container) {
					Write-host "ISO" -ForegroundColor Green
				} else {
					Write-host "ISO" -ForegroundColor Red
				}

				Write-Host "     13   " -NoNewline -ForegroundColor Yellow
				Write-Host $lang.OpenFolder -ForegroundColor Green
				Write-host ""
			} else {
				Write-host "   $($SearchFolderRule)" -ForegroundColor Red
			}
				
			if (Test-Path $SearchFolderRuleCustom -PathType Container) {
				Write-host "   $($SearchFolderRuleCustom)" -ForegroundColor Yellow

				Write-Host "     21   " -NoNewline -ForegroundColor Yellow
				if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
					Write-host $lang.Mounted -ForegroundColor Green
				} else {
					Write-host $lang.Mounted -ForegroundColor Red
				}

				Write-Host "     22   " -NoNewline -ForegroundColor Yellow
				if (Test-Path -Path $LanguageRepair_ISO_Path -PathType Container) {
					Write-host "ISO" -ForegroundColor Green
				} else {
					Write-host "ISO" -ForegroundColor Red
				}

				Write-Host "     23   " -NoNewline -ForegroundColor Yellow
				Write-Host $lang.OpenFolder -ForegroundColor Green
			} else {
				Write-host "   $($SearchFolderRuleCustom)" -ForegroundColor Red
			}
		} else {
			Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
		}
	} else {
		Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
	}

	Write-Host "`n   $($lang.MoreFeature)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      C   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		Write-host $lang.OnlyLangCleanup -ForegroundColor Green
	} else {
		Write-host $lang.OnlyLangCleanup -ForegroundColor Red
	}

	Write-Host "      R   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		if (Image_Is_Select_Boot) {
			Write-host $lang.LangIni -ForegroundColor Green
		} else {
			Write-host $lang.LangIni -ForegroundColor Red
		}
	} else {
		Write-host $lang.LangIni -ForegroundColor Red
	}

	Write-Host "      V   " -NoNewline -ForegroundColor Yellow
	if (Verify_Is_Current_Same) {
		Write-host $lang.ViewLanguage -ForegroundColor Green
	} else {
		Write-host $lang.ViewLanguage -ForegroundColor Red
	}

	Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "      P   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.ExportToLogs -ForegroundColor Green
		} else {
			Write-host $lang.ExportToLogs -ForegroundColor Red
		}
	} else {
		Write-host $lang.ExportToLogs -ForegroundColor Red
	}

	Write-Host "      S   " -NoNewline -ForegroundColor Yellow
	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			Write-host $lang.ExportShow -ForegroundColor Green
		} else {
			Write-host $lang.ExportShow -ForegroundColor Red
		}
	} else {
		Write-Host $lang.ExportShow -ForegroundColor Red
	}

	if (Image_Is_Select_IAB) {
		if (Verify_Is_Current_Same) {
			$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value

			Write-host "`n          $($lang.SaveTo)" -ForegroundColor Yellow
			Write-host "          $('-' * 73)"
			Write-host "     SS   " -NoNewline -ForegroundColor Yellow
			Write-host $Temp_Expand_Rule -ForegroundColor Green
		}
	}

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'e' {
			Language_Extract_UI
			ToWait -wait 2
			Language_Menu
		}
		'1' {
			Write-Host "`n   $($lang.Language): $($lang.AddTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Language_Add_UI" -Run
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'2' {
			Write-Host "`n   $($lang.Language): $($lang.Del)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Language_Delete_UI" -Run
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		'3' {
			Write-Host "`n   $($lang.SwitchLanguage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					<#
						.Assign available tasks
						.分配可用的任务
					#>
					Event_Assign -Rule "Language_Change_UI" -Run
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		'4' {
			Write-Host "`n   $($lang.BootSyncToISO)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($LanguageRepair_Path)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Test-Path $LanguageRepair_Path -PathType Container) {
				if (Image_Is_Select_Boot) {
					if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
						Language_Sync_To_ISO_Process
						Get_Next
					} else {
						Write-host $lang.Mounted -ForegroundColor Red
					}
				} else {
					Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
				}
			} else {
				Write-host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'11' {
			Write-Host "`n   $($lang.Setup_Fix_Missing): $($Lang.Mounted)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($SearchFolderRule)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Test-Path $SearchFolderRule -PathType Container) {
				if (Image_Is_Select_Boot) {
					if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
						Language_Repair_Cli -PathSources $SearchFolderRule -SaveTo $LanguageRepair_Path
						Get_Next
					} else {
						Write-host $lang.Mounted -ForegroundColor Red
					}
				} else {
					Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
				}
			} else {
				Write-host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'12' {
			Write-Host "`n   $($lang.Setup_Fix_Missing): $($Lang.Mounted)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($SearchFolderRule)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Test-Path $SearchFolderRule -PathType Container) {
				if (Test-Path -Path $LanguageRepair_ISO_Path -PathType Container) {
					Language_Repair_Cli -PathSources $SearchFolderRule -SaveTo $LanguageRepair_ISO_Path
					Get_Next
				} else {
					Write-host $lang.Mounted -ForegroundColor Red
				}
			} else {
				Write-host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'13' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $SearchFolderRule -PathType Container) {
				Write-Host "   $SearchFolderRule"
				Start-Process $SearchFolderRule
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($SearchFolderRule)" -ForegroundColor Red
			}
		}
		'21' {
			Write-Host "`n   $($lang.Setup_Fix_Missing): $($Lang.Mounted)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($SearchFolderRuleCustom)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Test-Path $SearchFolderRuleCustom -PathType Container) {
				if (Image_Is_Select_Boot) {
					if (Test-Path -Path $LanguageRepair_Path -PathType Container) {
						Language_Repair_Cli -PathSources $SearchFolderRuleCustom -SaveTo $LanguageRepair_Path
						Get_Next
					} else {
						Write-host $lang.Mounted -ForegroundColor Red
					}
				} else {
					Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
				}
			} else {
				Write-host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'22' {
			Write-Host "`n   $($lang.Setup_Fix_Missing): $($Lang.Mounted)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($SearchFolderRuleCustom)" -ForegroundColor Yellow

			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Test-Path $SearchFolderRuleCustom -PathType Container) {
				if (Test-Path -Path $LanguageRepair_ISO_Path -PathType Container) {
					Language_Repair_Cli -PathSources $SearchFolderRuleCustom -SaveTo $LanguageRepair_ISO_Path
					Get_Next
				} else {
					Write-host $lang.Mounted -ForegroundColor Red
				}
			} else {
				Write-host "   $($lang.Inoperable)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'23' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $SearchFolderRuleCustom -PathType Container) {
				Write-Host "   $SearchFolderRuleCustom"
				Start-Process $SearchFolderRuleCustom
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($SearchFolderRuleCustom)" -ForegroundColor Red
			}
		}
		'c' {
			Write-Host "`n   $($lang.OnlyLangCleanup)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
			if (Verify_Is_Current_Same) {
				Write-Host "   $($lang.Mounted)" -ForegroundColor Green
				<#
					.Assign available tasks
					.分配可用的任务
				#>
				Event_Assign -Rule "Language_Cleanup_Components_UI" -Run
			} else {
				Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		'r' {
			Write-Host "`n   $($lang.LangIni)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Verify_Is_Current_Same) {
				if (Image_Is_Select_Boot) {
					Language_Refresh_Ini
					Get_Next
				} else {
					Write-Host "   $($lang.BootProcess -f "boot")" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		"v" {
			Write-Host "`n   $($lang.ViewLanguage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
						Write-Host "`n   $($lang.Command)" -ForegroundColor Green
						Write-host "   $($lang.Developers_Mode_Location)65" -ForegroundColor Green
						Write-host "   $('-' * 80)"
						write-host "   Dism.exe /Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /Get-Intl" -ForegroundColor Green
						Write-host "   $('-' * 80)`n"
					}
			
					start-process "Dism.exe" -ArgumentList "/Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /Get-Intl" -wait -nonewwindow
					Get_Next
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		'p' {
			Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Components_Package -Save $Temp_Export_SaveTo
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		's' {
			Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow

			if (Image_Is_Select_IAB) {
				$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
				if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
					$Temp_Export_SaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
				} else {
					$Temp_Export_SaveTo = $Temp_Expand_Rule
				}

				Image_Get_Components_Package -Save $Temp_Export_SaveTo -View
				Get_Next
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Language_Menu
		}
		'ss' {
			Write-Host "`n   $($lang.Setting): $($lang.SaveTo)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green

					Setting_Export_To_UI
				} else {
					Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
			}

			ToWait -wait 2
			Language_Menu
		}
		default {
			Mainpage
		}
	}
}

<#
	.同步语言包到安装程序
#>
Function Language_Sync_To_ISO_Process
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = $lang.BootSyncToISO
	}

	$Region = Language_Region
	ForEach ($itemRegion in $Region) {
		<#
			.同步已挂载的语言包到 ISO 安装程序
		#>
		if (Test-Path -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\sources\$($itemRegion.Region)" -PathType Container) {
			Write-Host "   $($lang.Paste)"
			Write-Host "   > $($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\sources\$($itemRegion.Region)"
			Write-Host "   + $($Global:Image_source)\sources\$($itemRegion.Region)"

			Copy-Item -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\sources\$($itemRegion.Region)" -Destination "$($Global:Image_source)\sources\$($itemRegion.Region)" -Recurse -Force -ErrorAction SilentlyContinue

			Write-Host "   $($lang.Done)" -ForegroundColor Green
		}
	}
}

<#
	.自动修复安装程序缺少项：已挂载
#>
Function Language_Repair_Cli
{
	param (
		$PathSources,
		$SaveTo
	)

	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = $lang.Setup_Fix_Missing
	}

	$Language_Repair_FileList = @(
		"arunres.dll.mui"
		"spwizres.dll.mui"
		"w32uires.dll.mui"
	)

	$Region = Language_Region
	ForEach ($itemRegion in $Region) {
		$LanguageRepair_Path = "$($PathSources)\$($itemRegion.Region)"
		$Offline_Mount_Path_Sources = "$($SaveTo)\$($itemRegion.Region)"

		if (Test-Path -Path $Offline_Mount_Path_Sources -PathType Container) {
			Write-host "   $($lang.SaveTo): " -NoNewline
			Write-host $Offline_Mount_Path_Sources -ForegroundColor Yellow

			ForEach ($itemCheckRepir in $Language_Repair_FileList) {
				$NewRepairFullPath = "$($LanguageRepair_Path)\$($itemCheckRepir)"

				Write-Host "      $($itemCheckRepir.PadRight(22))" -NoNewline -ForegroundColor Yellow
				if (Test-Path -Path $NewRepairFullPath -PathType leaf) {
					Write-Host "   $($lang.Paste)".PadRight(18) -NoNewline
						Check_Folder -chkpath $Offline_Mount_Path_Sources
						Copy-Item -Path $NewRepairFullPath -Destination $Offline_Mount_Path_Sources -Force -ErrorAction SilentlyContinue

						if (Test-Path -Path "$($Offline_Mount_Path_Sources)\$($itemCheckRepir)" -PathType leaf) {
							Write-Host "   $($lang.Done)" -ForegroundColor Green
						} else {
							Write-Host "   $($lang.AddTo), $($lang.Failed)" -ForegroundColor Red
						}
				} else {
					Write-Host "   $($lang.MatchMode), $($lang.Failed)" -ForegroundColor Red
				}
			}

			Write-host ""
		}
	}
}

<#
	.生成同步语言列表
#>
Function Language_Refresh_Ini
{
	if (-not $Global:EventQueueMode) {
		$Host.UI.RawUI.WindowTitle = $lang.LangIni
	}

	Write-Host "   $($lang.Rebuilding)".PadRight(28) -NoNewline
	if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
		Write-Host "`n   $($lang.Command)" -ForegroundColor Green
		Write-host "   $($lang.Developers_Mode_Location)66" -ForegroundColor Green
		Write-host "   $('-' * 80)"
		write-host "   dism /image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /gen-langini /distribution:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount""" -ForegroundColor Green
		Write-host "   $('-' * 80)`n"
	}

	dism /image:"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" /gen-langini /distribution:"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"

	if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
		Write-Host "`n   $($lang.Command)" -ForegroundColor Green
		Write-host "   $($lang.Developers_Mode_Location)67" -ForegroundColor Green
		Write-host "   $('-' * 80)"
		write-host "   dism /image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /gen-langini /distribution:""$($Global:Image_source)""" -ForegroundColor Green
		Write-host "   $('-' * 80)`n"
	}

	dism /image:"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" /gen-langini /distribution:"$($Global:Image_source)"

	Write-Host "   $($lang.Done)" -ForegroundColor Green
}