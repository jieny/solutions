<#
	.Handle operations that need to be mounted after install.wim or boot.wim
	.处理需要挂载 install.wim 或 boot.wim 后的操作
#>
Function Event_Process_Task_Need_Mount
{
	<#
		.存储当前已知来源
	#>
	# 保存
	$IsEjectAfterSave = $False
	if ((Get-Variable -Scope global -Name "Queue_Eject_Only_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$IsEjectAfterSave = $True
	}
	if ((Get-Variable -Scope global -Name "Queue_Expand_Eject_Only_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$IsEjectAfterSave = $True
	}

	# 不保存
	$IsEjectAfterSaveNot = $False
	if ((Get-Variable -Scope global -Name "Queue_Eject_Do_Not_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$IsEjectAfterSaveNot = $True
	}
	if ((Get-Variable -Scope global -Name "Queue_Expand_Eject_Do_Not_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$IsEjectAfterSaveNot = $True
	}

	$Temp_Expand_Rule = (Get-Variable -Scope global -Name "Queue_Export_SaveTo_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	if (([string]::IsNullOrEmpty($Temp_Expand_Rule))) {
		$Temp_Export_SaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
	} else {
		$Temp_Export_SaveTo = $Temp_Expand_Rule
	}

	<#
		.初始化时间：每任务
	#>
	$Script:SingleTaskTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
	$Script:SingleTaskTime = New-Object System.Diagnostics.Stopwatch
	$Script:SingleTaskTime.Reset()
	$Script:SingleTaskTime.Start()

	Write-Host "`n   $($lang.ProcessingImage)" -ForegroundColor Yellow
	Write-Host "   $('-' * 80)"
	Write-Host "   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
	Write-Host $Global:Primary_Key_Image.Group -ForegroundColor Green

	Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
	Write-Host $Global:Primary_Key_Image.ImageFileName -ForegroundColor Green

	Write-host "`n   $($lang.TimeStart)" -ForegroundColor Green
	Write-Host "   $('-' * 80)"
	Write-host "   $($Script:SingleTaskTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

	<#
		.Start processing all tasks
		.开始处理所有任务
	#>

	<#
		.Running PowerShell Functions: Before Tasks
		.运行 PowerShell 函数：有任务前
	#>
	Write-Host "`n   $($lang.SpecialFunction): $($lang.Functions_Before)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	$Temp_Functions_Before_Task = (Get-Variable -Scope global -Name "Queue_Functions_Before_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	if ($Temp_Functions_Before_Task.Count -gt 0) {
		Write-Host "   $($lang.Choose)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Functions_Before_Task) {
			Write-Host "   $($item)"
		}

		Write-Host "`n   $($lang.LXPsWaitAdd)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Functions_Before_Task) {
			Invoke-Expression -Command $item
		}
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Generate solution
		.生成解决方案
	#>
	Write-Host "`n   $($lang.Solution)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Solutions_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.Operable)" -ForegroundColor Green

		<#
			.批量操作，挂载所有映像源，并添加
		#>
		Solutions_Generate_Process -Mount
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Windows Feature: Enabled, Match
	#>
	Write-Host "`n   $($lang.WindowsFeature): $($lang.Enable), $($lang.MatchMode)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Feature_Enable_Match_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Feature_Enabled_Match_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Windows Feature: Enabled
		.Windows 功能：启用
	#>
	Write-Host "`n   $($lang.WindowsFeature): $($lang.Enable)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Feature_Enable_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Feature_Enabled_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Windows Feature: Disable
		.Windows 功能：禁用
	#>
	Write-Host "`n   $($lang.WindowsFeature): $($lang.Disable)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Feature_Disable_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Feature_Disable_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	#-------------------------------- Language Start --------------------------------
	<#
		.Add Language
		.添加语言
	#>
	Write-Host "`n   $($lang.Language): $($lang.AddTo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LanguageAddTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LanguageAddTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LanguageAddTasksTime.Reset()
		$Script:LanguageAddTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LanguageAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Language_Add_Process

		<#
			.自动修复安装程序缺少项：已挂载
		#>
		Write-Host "`n   $($lang.Setup_Fix_Missing): $($lang.Mounted)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if ((Get-Variable -Scope global -Name "Queue_Is_Setup_Fix_Missing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			$SearchFolderRule = @(
				"$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Language\Repair"
				"$($Global:Image_source)_Custom\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Language\Repair"
			)
			$SearchFolderRule = $SearchFolderRule | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique

			Write-Host "`n   $($lang.ProcessSources)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			ForEach ($item in $SearchFolderRule) {
				Write-Host "   $($item)" -ForegroundColor Yellow
			}
	
			Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			foreach ($item in $SearchFolderRule) {
				Write-Host "   $($lang.Select_Path): " -noNewline
				Write-Host $item -ForegroundColor Yellow
				Write-host "   $('-' * 80)"

				if (Test-Path -Path $item -PathType Container) {
					Language_Repair_Cli -PathSources $item -SaveTo "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Sources"
				} else {
					Write-host "   $($lang.Inoperable)`n" -ForegroundColor Red
				} 
			}
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}

		<#
			.同步语言包到安装程序
		#>
		Write-Host "`n   $($lang.BootSyncToISO)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if ((Get-Variable -Scope global -Name "Queue_Is_Language_Sync_To_ISO_Sources_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			Language_Sync_To_ISO_Process
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}

		<#
			.Rebuild lang.ini
			.重建 lang.ini
		#>
		Write-Host "`n   $($lang.LangIni)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if ((Get-Variable -Scope global -Name "Queue_Is_Language_INI_Rebuild_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			Language_Refresh_Ini
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}

		$Script:LanguageAddTasksTime.Stop()
		Write-host "`n   $($lang.Language): $($lang.AddTo), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LanguageAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LanguageAddTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LanguageAddTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Change the global default language of the image
		.更改映像全局默认语言
	#>
	Write-Host "`n   $($lang.SwitchLanguage)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Change_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.Operable)" -ForegroundColor Green

		Language_Change_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Delete Language
		.删除语言
	#>
	Write-Host "`n   $($lang.Language): $($lang.Del)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Del_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LanguageDelTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LanguageDelTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LanguageDelTasksTime.Reset()
		$Script:LanguageDelTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LanguageDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Language_Delete_Process

		<#
			.同步语言包到安装程序
		#>
		Write-Host "`n   $($lang.BootSyncToISO)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if ((Get-Variable -Scope global -Name "Queue_Is_Language_Sync_To_ISO_Sources_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			Language_Sync_To_ISO_Process
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}

		<#
			.Rebuild lang.ini
			.重建 lang.ini
		#>
		Write-Host "`n   $($lang.LangIni)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		if ((Get-Variable -Scope global -Name "Queue_Is_Language_INI_Rebuild_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			Language_Refresh_Ini
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
		
		$Script:LanguageDelTasksTime.Stop()
		Write-host "`n   $($lang.Language): $($lang.Del), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LanguageDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LanguageDelTasksTime.Elapsed)" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LanguageDelTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Change the global default language of the image
		.更改映像全局默认语言
	#>
	Write-Host "`n   $($lang.SwitchLanguage)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Change_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.Operable)" -ForegroundColor Green

		Language_Change_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.clean up components: Language
		.清理组件：语言
	#>
	Write-Host "`n   $($lang.OnlyLangCleanup)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Components_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:ComponentsClearTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:ComponentsClearTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:ComponentsClearTasksTime.Reset()
		$Script:ComponentsClearTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:ComponentsClearTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Cleanup_Components_Process

		$Script:ComponentsClearTasksTime.Stop()
		Write-host "`n   $($lang.OnlyLangCleanup), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:ComponentsClearTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:ComponentsClearTasksTime.Elapsed)" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:ComponentsClearTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}
	#-------------------------------- Language End --------------------------------


	<#
		.Warning: Do not change the order
		.警告：请勿更改顺序
	#>
	<#
		.Verify whether to remove old pre-installed software
		.验证是否删除旧的预安装软件
	#>
	Write-Host "`n   $($lang.InboxAppsClear)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Clear_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:InBoxAppsDeletePreTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:InBoxAppsDeletePreTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:InBoxAppsDeletePreTasksTime.Reset()
		$Script:InBoxAppsDeletePreTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:InBoxAppsDeletePreTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_LIPs_Clean_Process

		$Script:InBoxAppsDeletePreTasksTime.Stop()
		Write-host "`n   $($lang.InboxAppsClear), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:InBoxAppsDeletePreTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:InBoxAppsDeletePreTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:InBoxAppsDeletePreTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 1: Add local language experience packs (LXPs)
		.第一步：添加本地语言体验包 (LXPs)
	#>
	Write-Host "`n   $($lang.StepOne)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_One_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:InBoxAppsAddTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:InBoxAppsAddTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:InBoxAppsAddTasksTime.Reset()
		$Script:InBoxAppsAddTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:InBoxAppsAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_LIPs_Add_Mark_Process

		$Script:InBoxAppsAddTasksTime.Stop()
		Write-host "`n   $($lang.StepOne), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:InBoxAppsAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:InBoxAppsAddTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:InBoxAppsAddTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 2: Install (UWP) applications from the Inbox Apps installation source
		.第二步：从 Inbox Apps 安装源里安装（UWP）应用
	#>
	Write-Host "`n   $($lang.StepTwo)$($lang.AddTo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:InBoxAppsInstallNewTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:InBoxAppsInstallNewTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:InBoxAppsInstallNewTasksTime.Reset()
		$Script:InBoxAppsInstallNewTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:InBoxAppsInstallNewTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_Add_Process

		$Script:InBoxAppsInstallNewTasksTime.Stop()
		Write-host "`n   $($lang.StepTwo)$($lang.AddTo), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:InBoxAppsInstallNewTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:InBoxAppsInstallNewTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:InBoxAppsInstallNewTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 3: Remove local language experience packs (LXPs)
		.第三步：删除本地语言体验包 (LXPs)
	#>
	Write-Host "`n   $($lang.Del) ( $($lang.LocalExperiencePackTips) )" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LXPsDelTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LXPsDelTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LXPsDelTasksTime.Reset()
		$Script:LXPsDelTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LXPsDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_LIPs_Delete_Process
		
		$Script:LXPsDelTasksTime.Stop()
		Write-host "`n   $($lang.Del) ( $($lang.LocalExperiencePackTips) ), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LXPsDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LXPsDelTasksTime.Elapsed)" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LXPsDelTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 4: Add only local language experience packs (LXPs)
		.第四步：仅添加本地语言体验包 (LXPs)
	#>
	Write-Host "`n   $($lang.StepThree)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_LXPs_Add_Step_There_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LXPsAddTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LXPsAddTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LXPsAddTasksTime.Reset()
		$Script:LXPsAddTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LXPsAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_LIPs_Add_Process

		$Script:LXPsAddTasksTime.Stop()
		Write-host "`n   $($lang.StepTwo)$($lang.AddTo), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LXPsAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LXPsAddTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LXPsAddTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 5: Remove local language experience packs (LXPs)
		.第五步：删除本地语言体验包 (LXPs)
	#>
	Write-Host "`n   $($lang.Del) ( $($lang.LocalExperiencePackTips) )" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_LXPs_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LXPsDeleteOldTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LXPsDeleteOldTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LXPsDeleteOldTasksTime.Reset()
		$Script:LXPsDeleteOldTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LXPsDeleteOldTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_LIPs_Delete_Process

		$Script:LXPsDeleteOldTasksTime.Stop()
		Write-host "`n   $($lang.Del) ( $($lang.LocalExperiencePackTips) ), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOldTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOldTasksTime.Elapsed)" -ForegroundColor Yellow

		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOldTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 6: Remove selected UWP preinstalled software by rule matching
		.第六步：按规则匹配删除已选择的 UWP 预安装软件
	#>
	Write-Host "`n   $($lang.InboxAppsMatchDel)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Match_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LXPsDeleteMatchTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LXPsDeleteMatchTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LXPsDeleteMatchTasksTime.Reset()
		$Script:LXPsDeleteMatchTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LXPsDeleteMatchTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_Match_Delete_Process

		$Script:LXPsDeleteMatchTasksTime.Stop()
		Write-host "`n   $($lang.InboxAppsMatchDel), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LXPsDeleteMatchTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LXPsDeleteMatchTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LXPsDeleteMatchTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Step 7: Delete installed UWP apps offline
		.第七步：离线删除已安装的 UWP 应用
	#>
	Write-Host "`n   $($lang.InboxAppsOfflineDel)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Mount_Rule_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:LXPsDeleteOfflineTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:LXPsDeleteOfflineTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:LXPsDeleteOfflineTasksTime.Reset()
		$Script:LXPsDeleteOfflineTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:LXPsDeleteOfflineTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		InBox_Apps_Offline_Delete_Process

		$Script:LXPsDeleteOfflineTasksTime.Stop()
		Write-host "`n   $($lang.InboxAppsOfflineDel), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOfflineTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOfflineTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:LXPsDeleteOfflineTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Optimize the provisioning of Appx packages by replacing the same files with hard links
		.优化预配 Appx 包，通过用硬链接替换相同的文件
	#>
	Write-Host "`n   $($lang.UWPOptimize)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Optimize_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:InBoxAppsOptimizeTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:InBoxAppsOptimizeTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:InBoxAppsOptimizeTasksTime.Reset()
		$Script:InBoxAppsOptimizeTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:InBoxAppsOptimizeTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Inbox_Apps_Hard_Links_Optimize

		$Script:InBoxAppsOptimizeTasksTime.Stop()
		Write-host "`n   $($lang.UWPOptimize), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:InBoxAppsOptimizeTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:InBoxAppsOptimizeTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:InBoxAppsOptimizeTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Cumulative updates: Add
		.累积更新：添加
	#>
	Write-Host "`n   $($lang.CUpdate): $($lang.AddTo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Update_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:OSUpdateAddTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:OSUpdateAddTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:OSUpdateAddTasksTime.Reset()
		$Script:OSUpdateAddTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:OSUpdateAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Update_Add_Process

		$Script:OSUpdateAddTasksTime.Stop()
		Write-host "`n   $($lang.CUpdate): $($lang.AddTo), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:OSUpdateAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:OSUpdateAddTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:OSUpdateAddTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Cumulative updates: Delete
		.累积更新：删除
	#>
	Write-Host "`n   $($lang.CUpdate): $($lang.Del)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Update_Del_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:OSUpdateDelTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:OSUpdateDelTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:OSUpdateDelTasksTime.Reset()
		$Script:OSUpdateDelTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:OSUpdateDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Update_Del_Process

		$Script:OSUpdateDelTasksTime.Stop()
		Write-host "`n   $($lang.CUpdate): $($lang.Del), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:OSUpdateDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:OSUpdateDelTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:OSUpdateDelTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Drive: Add
		.驱动：添加
	#>
	Write-Host "`n   $($lang.Drive): $($lang.AddTo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Drive_Add_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:DriveAddTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:DriveAddTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:DriveAddTasksTime.Reset()
		$Script:DriveAddTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:DriveAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"
	
		Drive_Add_Process

		$Script:DriveAddTasksTime.Stop()
		Write-host "`n   $($lang.Drive): $($lang.AddTo), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:DriveAddTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:DriveAddTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:DriveAddTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Drive: Delete
		.驱动: 删除
	#>
	Write-Host "`n   $($lang.Drive): $($lang.Del)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Drive_Delete_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:DriveDelTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:DriveDelTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:DriveDelTasksTime.Reset()
		$Script:DriveDelTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:DriveDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"
	
		Drive_Delete_Process

		$Script:DriveDelTasksTime.Stop()
		Write-host "`n   $($lang.Drive): $($lang.Del), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:DriveDelTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:DriveDelTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:DriveDelTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Curing Update
		.固化更新
	#>
	Write-Host "`n   $($lang.CuringUpdate)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Update_Curing_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:CuringUpdateTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:CuringUpdateTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:CuringUpdateTasksTime.Reset()
		$Script:CuringUpdateTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:CuringUpdateTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
			Write-Host "   $($lang.Command)" -ForegroundColor Green
			Write-host "   $($lang.Developers_Mode_Location)11" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			write-host "   Dism /Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /cleanup-image /StartComponentCleanup /ResetBase" -ForegroundColor Green
			Write-host "   $('-' * 80)`n"
		}

		Dism /Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /cleanup-image /StartComponentCleanup /ResetBase

		$Script:CuringUpdateTasksTime.Stop()
		Write-host "`n   $($lang.CuringUpdate), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:CuringUpdateTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:CuringUpdateTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:CuringUpdateTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.清理取代的
	#>
	Write-Host "`n   $($lang.Superseded)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Superseded_Clean_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:SupersededClearTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:SupersededClearTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:SupersededClearTasksTime.Reset()
		$Script:SupersededClearTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:SupersededClearTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Image_Clear_Superseded

		$Script:SupersededClearTasksTime.Stop()
		Write-host "`n   $($lang.Superseded), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:SupersededClearTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:SupersededClearTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:SupersededClearTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.打印报告
	#>
	<#
		.获取预安装应用 UWP
	#>
	Write-Host "`n   $($lang.GetImageUWP)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.ExportShow)" -ForegroundColor Yellow
		Image_Get_Apps_Package -Save $Temp_Export_SaveTo -View
	} else {
		Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
		if ((Get-Variable -Scope global -Name "Queue_Is_InBox_Apps_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Image_Get_Apps_Package -Save $Temp_Export_SaveTo
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
	}

	<#
		.查看安装的所有软件包的列表
	#>
	Write-Host "`n   $($lang.GetImagePackage)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Components_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.ExportShow)" -ForegroundColor Yellow
		Image_Get_Components_Package -Save $Temp_Export_SaveTo -View
	} else {
		Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
		if ((Get-Variable -Scope global -Name "Queue_Is_Language_Components_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Image_Get_Components_Package -Save $Temp_Export_SaveTo
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
	}

	<#
		.查看已安装的驱动列表
	#>
	Write-Host "`n   $($lang.ViewDrive)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Is_Drive_Report_View_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		Write-Host "   $($lang.ExportShow)" -ForegroundColor Yellow
		Image_Get_Installed_Drive -Save $Temp_Export_SaveTo -View
	} else {
		Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
		if ((Get-Variable -Scope global -Name "Queue_Is_Drive_Report_Logs_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
			Image_Get_Installed_Drive -Save $Temp_Export_SaveTo
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
	}

	<#
		.映像语言
	#>
	Write-Host "`n   $($lang.ImageLanguage)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "   $($lang.ExportToLogs)" -ForegroundColor Yellow
	if ((Get-Variable -Scope global -Name "Queue_Is_Language_Report_Image_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green

			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)12" -ForegroundColor Green
				Write-host "   $('-' * 77)"
				write-host "   Dism.exe /Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /Get-Intl" -ForegroundColor Green
				Write-host "   $('-' * 77)`n"
			}

			$Get_Index_Now = Image_Get_Mount_Index
			Check_Folder -chkpath $Temp_Export_SaveTo
			$TempSaveTo = "$($Temp_Export_SaveTo)\Index.$($Get_Index_Now).Language.$(Get-Date -Format "yyyyMMddHHmmss").$($Global:EventProcessGuid).log"

			Write-Host "`n   $($lang.SaveTo)"
			Write-Host "   $($TempSaveTo)" -ForegroundColor Green

			start-process "Dism.exe" -ArgumentList "/Image:""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"" /Get-Intl" -wait -WindowStyle Hidden -RedirectStandardOutput $TempSaveTo
		} else {
			Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
		}
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.健康
	#>
	Write-Host "`n   $($lang.Healthy)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ((Get-Variable -Scope global -Name "Queue_Healthy_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
		$Script:HealthyTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:HealthyTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:HealthyTasksTime.Reset()
		$Script:HealthyTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:HealthyTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green

		<#
			.触发此事件强制结束
		#>
		if (Healthy_Check_Process -NewPath "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount") {

		} else {
			Write-Host "   $($lang.HealthyForceStop)" -ForegroundColor Red
			Write-host "   $('-' * 80)"

			Write-Host "   $($lang.Healthy_Save)`n" -ForegroundColor Red
			if ((Get-Variable -Scope global -Name "Queue_Healthy_Dont_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value) {
				Write-Host "   $($lang.Operable)`n" -ForegroundColor Green
		
				<#
					.重置：完成后事件
				#>
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AllowAfterFinishing" -value "True" -String
				Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AfterFinishing" -value "2" -String

				<#
					.清空所有任务
				#>
				New-Variable -Scope global -Name "Queue_Process_Image_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force
				New-Variable -Scope global -Name "Queue_Process_Image_Select_Pending_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value @() -Force

				$IsEjectAfterSave = $Flase
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}
		}

		$Script:HealthyTasksTime.Stop()
		Write-host "`n   $($lang.Healthy), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:HealthyTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:HealthyTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:HealthyTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Running PowerShell Functions: After Completing a Task
		.运行 PowerShell 函数：完成任务后
	#>
	Write-Host "`n   $($lang.SpecialFunction): $($lang.Functions_Rear)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	$Temp_Functions_Rear_Task = (Get-Variable -Scope global -Name "Queue_Functions_Rear_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	if ($Temp_Functions_Rear_Task.Count -gt 0) {
		Write-Host "   $($lang.Choose)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Functions_Rear_Task) {
			Write-Host "   $($item)"
		}

		Write-Host "`n   $($lang.LXPsWaitAdd)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		ForEach ($item in $Temp_Functions_Rear_Task) {
			Invoke-Expression -Command $item
		}
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.弹出：保存

		1、获取已预分配的保存规则，来源：Queue_Eject_Expand_Save_*
			条件：优先按规则设置，并操作。

		2、如果没有规则，则根据用户勾选：“未指定映像内卸载动作时，不保存”按钮来操作。
	#>
	Write-Host "`n   $($lang.UnmountAndSave)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "   $($lang.Save)" -ForegroundColor Yellow
	if ($IsEjectAfterSave) {
		$Script:EjectSaveTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:EjectSaveTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:EjectSaveTasksTime.Reset()
		$Script:EjectSaveTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:EjectSaveTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Write-Host "   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
		Write-Host $Global:Primary_Key_Image.Group -ForegroundColor Green

		<#
			.优先卸载扩展项
		#>
		<#
			.匹配主要项里，是否挂载映像内的其它映像文件
		#>
		ForEach ($item in $Global:Image_Rule) {
			if ($item.Main.Uid -eq $Global:Primary_Key_Image.Uid) {
				if ($item.Expand.Count -gt 0) {
					Write-host "`n   $($lang.Event_Assign_Expand)" -ForegroundColor Yellow
					Write-host "   $('-' * 80)"

					ForEach ($itemExpandNew in $item.Expand) {
						<#
							.初始化变量
						#>
						$Temp_Do_Not_Save_Path = "$($Global:Mount_To_Route)\$($item.Main.ImageFileName)\$($itemExpandNew.ImageFileName)\Mount"

						Write-Host "   $($lang.YesWork)" -ForegroundColor Yellow
						Write-host "   $('-' * 80)"

						Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
						Write-Host $itemExpandNew.Uid -ForegroundColor Green

						Write-Host "   $($lang.Select_Path): " -NoNewline -ForegroundColor Yellow
						Write-host $Temp_Do_Not_Save_Path -ForegroundColor Green

						<#
							.Determine if it is mounted
							.判断是否已挂载
						#>
						Write-host "`n   $($lang.Mounted_Status)" -ForegroundColor Yellow
						if ((Get-Variable -Scope global -Name "Mark_Is_Mount_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
							Write-Host "   $($lang.Mounted)"
					
							<#
								.健康
							#>
							Write-Host "`n   $($lang.Healthy)" -ForegroundColor Yellow
							if ((Get-Variable -Scope global -Name "Queue_Expand_Healthy_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
								<#
									.触发此事件强制结束
								#>
								if (Healthy_Check_Process -NewPath "$($Global:Mount_To_Route)\$($item.Main.ImageFileName)\$($itemExpandNew.ImageFileName)\Mount") {
								} else {
									<#
										.强行终止保存功能，不建议强行开启，

										 因为映像内的文件不支持这功能，该功能在特定环境，仅支持 install.wim，
									#>

#									New-Variable -Scope global -Name "Queue_Expand_Eject_Only_Save_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)" -Value $False -Force
								}
								Write-Host "   $($lang.Done)" -ForegroundColor Green
							} else {
								Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
							}

							<#
								.保存
							#>
							Write-Host "`n   $($lang.Save)" -ForegroundColor Yellow
							Write-host "   $('-' * 80)"
							Write-host "   $($Temp_Do_Not_Save_Path)" -ForegroundColor Green
							if ((Get-Variable -Scope global -Name "Queue_Expand_Eject_Only_Save_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)15" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Save-WindowsImage -Path ""$($Global:Mount_To_Route)\$($item.Main.ImageFileName)\$($itemExpandNew.ImageFileName)\Mount""" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Save-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Save.log" -Path "$($Global:Mount_To_Route)\$($item.Main.ImageFileName)\$($itemExpandNew.ImageFileName)\Mount" | Out-Null
								Write-Host "   $($lang.Done)" -ForegroundColor Green
							} else {
								Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
							}
					
							<#
								.不保存
								 保存带不保存，优先判断：主映像文件卸载，再判断自定义选择单独项
							#>
							Write-Host "`n   $($lang.DoNotSave)" -ForegroundColor Yellow

							<#
								.判断是否主映像卸载
							#>
							$Mark_Is_Unmount_Current_Image = $False
							$IsEjectAfterSaveNot = (Get-Variable -Scope global -Name "Queue_Eject_Do_Not_Save_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
							if ($IsEjectAfterSaveNot) {
								$Mark_Is_Unmount_Current_Image = $True
							}
							
							if ((Get-Variable -Scope global -Name "Queue_Expand_Eject_Do_Not_Save_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
								$Mark_Is_Unmount_Current_Image = $True
							}

							if ($Mark_Is_Unmount_Current_Image) {
								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)16" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
								Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
								
								<#
									.检查了已挂载后，判断目录是否存在，再次删除。
								#>
								if (Test-Path $Temp_Do_Not_Save_Path -PathType Container -ErrorAction SilentlyContinue) {
									if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
										Write-Host "`n   $($lang.Command)" -ForegroundColor Green
										Write-host "   $($lang.Developers_Mode_Location)18" -ForegroundColor Green
										Write-host "   $('-' * 80)"
										write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
										Write-host "   $('-' * 80)`n"
									}

									Dismount-WindowsImage -ScratchDirectory $(Get_Mount_To_Temp) -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
									Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
								}

								Write-Host "   $($lang.Done)" -ForegroundColor Green
							} else {
								Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
							}

							<#
								.重建
							#>
							Write-Host "`n   $($lang.Rebuilding)" -ForegroundColor Yellow
							Write-host "   $('-' * 80)"
							if ((Get-Variable -Scope global -Name "Queue_Expand_Rebuild_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
								Rebuild_Image_File -Filename $itemExpandNew.Path
							} else {
								Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
							}
						} else {
							Write-host "   $($lang.NotMounted)" -ForegroundColor Red
						}

						Write-Host "`n   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
						Write-Host $itemExpandNew.Uid -ForegroundColor Green
						Write-Host "   $('-' * 80)"
						Write-Host "   $($lang.Done)" -ForegroundColor Green
					}
				}

				break
			}
		}

		Write-Host "`n   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
		Write-Host $Global:Primary_Key_Image.Uid -ForegroundColor Green

		Write-Host "`n   $($lang.Save)" -ForegroundColor Yellow
		Write-host "   $($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ForegroundColor Green

		if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
			Write-Host "`n   $($lang.Command)" -ForegroundColor Green
			Write-host "   $($lang.Developers_Mode_Location)19" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			write-host "   Save-WindowsImage -Path ""$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount""" -ForegroundColor Green
			Write-host "   $('-' * 80)`n"
		}

		Save-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Save.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | Out-Null

		$Script:EjectSaveTasksTime.Stop()
		Write-host "`n   $($lang.UnmountAndSave): $($lang.Save), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:EjectSaveTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:EjectSaveTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:EjectSaveTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.弹出：不保存

		 2、获取所有扩展项，判断是否有已挂载，指令：1、不保存，2、卸载。
	#>
	Write-Host "`n   $($lang.DoNotSave)" -ForegroundColor Yellow
	if ($IsEjectAfterSaveNot) {
		$Script:EjectDoNotSaveTasksTimeStart = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		$Script:EjectDoNotSaveTasksTime = New-Object System.Diagnostics.Stopwatch
		$Script:EjectDoNotSaveTasksTime.Reset()
		$Script:EjectDoNotSaveTasksTime.Start()
	
		Write-host "   $($lang.TimeStart)" -NoNewline
		Write-host " $($Script:EjectDoNotSaveTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Green
		Write-Host "   $('-' * 80)"

		Write-Host "   $($lang.Event_Group): " -NoNewline -ForegroundColor Yellow
		Write-Host $Global:Primary_Key_Image.Group -ForegroundColor Green

		Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
		Write-Host $Global:Primary_Key_Image.Uid -ForegroundColor Green

		<#
			.优先卸载扩展项
		#>
		<#
			.匹配主要项里，是否挂载映像内的其它映像文件
		#>
		Write-host "`n   $($lang.Event_Assign_Expand)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		ForEach ($item in $Global:Image_Rule) {
			if ($item.Main.Uid -eq $Global:Primary_Key_Image.Uid) {
				if ($item.Expand.Count -gt 0) {
					ForEach ($itemExpandNew in $item.Expand) {
						<#
							.初始化变量
						#>
						$Temp_Do_Not_Save_Path = "$($Global:Mount_To_Route)\$($item.Main.ImageFileName)\$($itemExpandNew.ImageFileName)\Mount"

						Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
						Write-Host $itemExpandNew.Uid -ForegroundColor Green

						Write-Host "   $($lang.Select_Path): " -NoNewline -ForegroundColor Yellow
						Write-host $Temp_Do_Not_Save_Path -ForegroundColor Green

						<#
							.检查了已挂载后，判断目录是否存在，再次删除。
						#>
						Write-host "`n   $($lang.Mounted_Status)" -ForegroundColor Yellow
						Write-Host "   $('-' * 80)"
						Write-Host "   $($lang.Unmount)"-ForegroundColor Yellow
						if (Test-Path $Temp_Do_Not_Save_Path -PathType Container -ErrorAction SilentlyContinue) {
							<#
								.Determine if it is mounted
								.判断是否已挂载
							#>
							if ((Get-Variable -Scope global -Name "Mark_Is_Mount_$($item.Main.ImageFileName)_$($itemExpandNew.ImageFileName)").Value) {
								Write-Host "   $($lang.Mounted)"
								Write-Host "   $('-' * 80)"

								Write-Host "   $($lang.DoNotSave)" -ForegroundColor Yellow
								Write-host "   $($Temp_Do_Not_Save_Path)" -ForegroundColor Green

								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)20" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
								Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
							}

							if (Test-Path $Temp_Do_Not_Save_Path -PathType Container -ErrorAction SilentlyContinue) {
								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)21" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Dismount-WindowsImage -ScratchDirectory $(Get_Mount_To_Temp) -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
								Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
							}

							Write-Host "   $($lang.Done)" -ForegroundColor Green
						} else {
							Write-Host "   $($lang.Done)" -ForegroundColor Green
						}
					}
					break
				} else {
					Write-Host "   $($lang.NoWork)" -ForegroundColor Red
				}
			}
		}

		$Temp_Do_Not_Save_Path = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount"

		Write-host "`n   $($lang.Event_Assign_Main)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.Event_Primary_Key): " -NoNewline -ForegroundColor Yellow
		Write-Host $Global:Primary_Key_Image.Uid -ForegroundColor Green

		Write-Host "`n   $($lang.DoNotSave)" -ForegroundColor Yellow
		Write-Host "   $($Temp_Do_Not_Save_Path)" -ForegroundColor Green

		<#
			.Determine if it is mounted
			.判断是否已挂载
		#>
		Write-host "`n   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-host "   $($lang.Unmount)" -ForegroundColor Yellow
		if ((Get-Variable -Scope global -Name "Mark_Is_Mount_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)").Value) {
			Write-Host "   $($lang.Mounted)"

			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)22" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
			Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
		}

		<#
			.检查了已挂载后，判断目录是否存在，再次删除。
		#>
		if (Test-Path $Temp_Do_Not_Save_Path -PathType Container) {
			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)23" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Dismount-WindowsImage -Path ""$($Temp_Do_Not_Save_Path)"" -Discard" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Dismount-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Dismount.log" -Path "$($Temp_Do_Not_Save_Path)" -Discard -ErrorAction SilentlyContinue | Out-Null
			Image_Mount_Force_Del -NewPath "$($Temp_Do_Not_Save_Path)"
		}

		$Script:EjectDoNotSaveTasksTime.Stop()
		Write-host "`n   $($lang.UnmountAndSave): $($lang.DoNotSave), $($lang.Done)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
		Write-Host "   $($lang.TimeStart)" -NoNewline
		Write-Host "$($Script:EjectDoNotSaveTasksTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEnd)" -NoNewline
		Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAll)" -NoNewline
		Write-Host "$($Script:EjectDoNotSaveTasksTime.Elapsed)" -ForegroundColor Yellow
	
		Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
		Write-Host "$($Script:EjectDoNotSaveTasksTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
		Write-Host "   $('-' * 80)"
	} else {
		Write-Host "   $($lang.NotMounted)" -ForegroundColor Red
	}

	$Script:SingleTaskTime.Stop()
	Write-Host "`n   $('-' * 80)"
	Write-Host "   $($lang.TimeStart)" -NoNewline
	Write-Host "$($Script:SingleTaskTimeStart -f "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

	Write-Host "   $($lang.TimeEnd)" -NoNewline
	Write-Host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")" -ForegroundColor Yellow

	Write-Host "   $($lang.TimeEndAll)" -NoNewline
	Write-Host "$($Script:SingleTaskTime.Elapsed)" -ForegroundColor Yellow

	Write-Host "   $($lang.TimeEndAllseconds)" -NoNewline
	Write-Host "$($Script:SingleTaskTime.ElapsedMilliseconds) $($lang.TimeMillisecond)" -ForegroundColor Yellow
	Write-Host "   $('-' * 80)"

	Write-Host "   $($lang.Done)`n" -ForegroundColor Green
}

<#
	.Events: Handling Allowed Items
	.事件：处理允许的项
#>
Function Event_Processing_Requires_Mounting
{
	if ($Global:Developers_Mode) {
		Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003100 ]`n   Start"
	}

	<#
		.处理：无需挂载项，主键
	#>
	$Temp_Save_Has_Been_Run = @()
	$IsEjectAfterSave = (Get-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	ForEach ($item in $IsEjectAfterSave) {
		$Temp_Save_Has_Been_Run += $item
	}

	if ($Global:Developers_Mode) {
		Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003190 ]`n   Start"
	}

	$Temp_Assign_Task = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Primary_Assign_Task_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))}
	if ($Temp_Assign_Task.Count -gt 0) {
		Write-Host "`n   $($lang.YesWork)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		ForEach ($item in $Temp_Assign_Task) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		if ($Global:Developers_Mode) {
			Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003111 ]`n   Start"
		}

		ForEach ($item in $Temp_Assign_Task) {
			$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Primary_Assign_Task_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value

			if (($Temp_Assign_Task_Select) -Contains $item) {
				if ($Global:Developers_Mode) {
					Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003150 ]`n   Start"
				}

				$Temp_Save_Has_Been_Run += $item
				New-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Save_Has_Been_Run -Force

				Invoke-Expression -Command $item

				if ($Global:Developers_Mode) {
					Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003150 ]`n   End"
				}
			}
		}

		if ($Global:Developers_Mode) {
			Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003111 ]`n   End"
		}
	}

	if ($Global:Developers_Mode) {
		Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003190 ]`n   End"
	}

	<#
		.扩展项
	#>
	$Temp_Assign_Task = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Expand_Assign_Task_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))}
	Write-Host "`n   $($lang.User_Interaction): $($lang.AssignNeedMount) ( $($Temp_Assign_Task.Count) ) $($lang.EventManagerCount)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ($Temp_Assign_Task.Count -gt 0) {
		if ($Global:Developers_Mode) {
			Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003200 ]`n   Start"
		}

		ForEach ($item in $Temp_Assign_Task) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		ForEach ($item in $Temp_Assign_Task) {
			$Temp_Assign_Task_Select = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Expand_Assign_Task_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
			if (($Temp_Assign_Task_Select) -Contains $item) {
				$Temp_Save_Has_Been_Run += $item
				New-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Save_Has_Been_Run -Force

				Invoke-Expression -Command $item
			}
		}

		if ($Global:Developers_Mode) {
			Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003200 ]`n   End"
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
	
	if ($Global:Developers_Mode) {
		Write-Host "`n   $('-' * 80)`n   $($lang.Developers_Mode_Location)E0x003100 ]`n   End"
	}
}

<#
	.Events: Handling disallowed items
	.事件：分配无需挂载的项
#>
Function Event_Assign_Not_Allowed_UI
{
	<#
		.处理：无需挂载项，主键
	#>
	$Temp_Save_Has_Been_Run = @()
	$IsEjectAfterSave = (Get-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	ForEach ($item in $IsEjectAfterSave) {
		$Temp_Save_Has_Been_Run += $item
	}

	Write-Host "`n   $($lang.User_Interaction): $($lang.AssignNoMount) ( $($Global:Queue_Assign_Not_Monuted_Primary.Count) ) $($lang.EventManagerCount)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ($Global:Queue_Assign_Not_Monuted_Primary.Count -gt 0) {
		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Primary) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Primary) {
			$Temp_Save_Has_Been_Run += $item
			New-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Save_Has_Been_Run -Force

			Invoke-Expression -Command $item
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}

	Write-Host "`n   $($lang.User_Interaction): $($lang.AssignNoMount) ( $($Global:Queue_Assign_Not_Monuted_Expand_Select.Count) ) $($lang.EventManagerCount)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ($Global:Queue_Assign_Not_Monuted_Expand_Select.Count -gt 0) {
		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Expand_Select) {
			Write-Host "   $($item)" -ForegroundColor Green
		}

		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Expand_Select) {
			if (($Global:Queue_Assign_Not_Monuted_Primary) -NotContains $item) {
				if (($Global:Queue_Assign_Not_Monuted_Expand_Select) -Contains $item) {
					$Temp_Save_Has_Been_Run += $item
					New-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Save_Has_Been_Run -Force

					Invoke-Expression -Command $item
				}
			}
		}
	} else {
		Write-Host "   $($lang.NoWork)" -ForegroundColor Red
	}
}

<#
	.Handle events that don't require the image source to be mounted
	.处理不需要挂载映像源的事件
#>
Function Event_Process_Task_Sustainable
{
	<#
		.生成解决方案：ISO
	#>
	Solutions_Quick_Copy_Process_To_ISO

	<#
		.Convert image
		.转换映像
	#>
	Write-Host "`n   $($lang.Convert_Only), $($lang.Conver_Merged), $($lang.Conver_Split_To_Swm)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	if ($Global:QueueConvert) {
		<#
			.判断先决条件：没有挂载项时才生效。
		#>
		Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
		if (Image_Is_Mount) {
			Write-Host "   $($lang.Mounted)"
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		} else {
			Image_Convert_Process
		}
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}

	<#
		.Generate ISO
		.生成 ISO
	#>
	Write-Host "`n   $($lang.UnpackISO)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	if ($Global:Queue_ISO) {
		ISO_Create_Process
	} else {
		Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
	}
}

<#
	.Events: Handling Allowed Items
	.事件：有可用的事件时
#>
Function Event_Process_Available_UI
{
	Write-Host "`n   $($lang.User_Interaction): $($lang.AfterFinishingNotExecuted)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	if ($Global:Queue_Assign_Available_Select.Count -gt 0) {
		<#
			.分配任务已选择
		#>
		ForEach ($item in $Global:Queue_Assign_Available_Select) {
			if ($Global:Queue_Assign_Available_Select.Count -gt 0) {
				Invoke-Expression -Command $item
			}
		}
	} else {
		Write-Host "   $($lang.NoWork)`n" -ForegroundColor Red

		$Init_IsEvent = @(
			"Event_Completion_Setting_UI"
			"Event_Completion_Start_Setting_UI"
		)

		if ($Global:EventQueueMode) {
			$EventMaps = "Queue"
		} else {
			$EventMaps = "Assign"
		}

		if (($Init_IsEvent) -NotContains "Event_Completion_Setting_UI") {
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AllowAfterFinishing" -value "True" -String
			Save_Dynamic -regkey "Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -name "AfterFinishing" -value "2" -String

			switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions\ImageSources\$($Global:MainImage)\Deploy\Event\$($EventMaps)\$($Global:EventProcessGuid)" -Name "AfterFinishing" -ErrorAction SilentlyContinue) {
				2 {
					Write-Host "   $($lang.AfterFinishingPause)" -ForegroundColor Green
					Get_Next
					Write-Host "   $($lang.Done)" -ForegroundColor Green
				}
				3 {
					Write-Host "   $($lang.AfterFinishingReboot)" -ForegroundColor Green
					start-process "timeout.exe" -argumentlist "/t 10 /nobreak" -wait -nonewwindow
					Restart-Computer -Force -ErrorAction SilentlyContinue
					Write-Host "   $($lang.Done)" -ForegroundColor Green
				}
				4 {
					Write-Host "   $($lang.AfterFinishingShutdown)" -ForegroundColor Green
					start-process "timeout.exe" -argumentlist "/t 10 /nobreak" -wait -nonewwindow
					Stop-Computer -Force -ErrorAction SilentlyContinue
					Write-Host "   $($lang.Done)" -ForegroundColor Green
				}
			}
		}

		Write-Host "`n   $($lang.WaitTimeTitle)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		Write-Host "   $($lang.TimeExecute)" -ForegroundColor Green
		if (($Init_IsEvent) -NotContains "Event_Completion_Start_Setting_UI") {
			$Global:QueueWaitTime = $False
		}
	}
}

<#
	.检查健康
#>
Function Healthy_Check_Process
{
	param
	(
		$NewPath
	)
	
	if (Test-Path $NewPath -PathType Container) {
		if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
			Write-Host "`n   $($lang.Command)" -ForegroundColor Green
			Write-host "   $($lang.Developers_Mode_Location)26" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			write-host "   Repair-WindowsImage -Path ""$($NewPath)"" -ScanHealth).ImageHealthState" -ForegroundColor Green
			Write-host "   $('-' * 80)`n"
		}

		try {
			$Get_Image_Halter = (Repair-WindowsImage -Path $NewPath -ScanHealth -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Repair.log").ImageHealthState

			Write-host "   $($lang.MatchMode) [ $($Get_Image_Halter) ]" -ForegroundColor Yellow

			switch ($Get_Image_Halter) {
				"Healthy" {
					Write-Host "   $($lang.Healthy)" -ForegroundColor Green
#					Logs_Write -Main -Verbose "[Onekey] index: $($Script:MarkNowItem), Mount: $($NewPath)" -Level Info -Tag "Check Damage"
				
					return $True
				}
				"Repairable" {
					Write-Host "   $($lang.Repairable)" -ForegroundColor Red
					Logs_Write -Main -Verbose "[Onekey] index: $($Script:MarkNowItem), Mount: $($NewPath)" -Level Error -Tag "Check Damage"
				
					return $False
				}
				"NonRepairable" {
					Write-Host "   $($lang.NonRepairable)" -ForegroundColor Red
					Logs_Write -Main -Verbose "[Onekey] index: $($Script:MarkNowItem), Mount: $($NewPath)" -Level Error -Tag "Check Damage"
				
					return $False
				}
				default {
					Write-Host "   Error" -ForegroundColor Red
					Logs_Write -Main -Verbose "[Onekey] index: $($Script:MarkNowItem), Mount: $($NewPath)" -Level Error -Tag "Check Damage"
				
					return $False
				}
			}
		} catch {
			return $False
		}
	} else {
		Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
	}

	return $False
}