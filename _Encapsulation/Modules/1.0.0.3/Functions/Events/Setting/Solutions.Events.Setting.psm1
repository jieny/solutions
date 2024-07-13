﻿<#
	.Event assignment settings
	.事件分配设置
#>
Function Event_Assign_Setting
{
	param
	(
		[Switch]$Setting,
		$RuleName
	)

	<#
		.Assign available tasks
		.分配可用的任务
	#>
	if ($Setting) {
		Event_Assign -Rule $RuleName
	}

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 1075
		Text           = $lang.AssignSetting
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
		TopMost        = $True
	}
	$UI_Main_Menu     = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 532
		Width          = 500
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "15,15,10,10"
		Dock           = 3
	}

	<#
		.组，有新的挂载映像时
	#>
	$UI_Main_Need_Mount_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Text           = $lang.AssignNeedMount
	}
	$UI_Main_Need_Mount_Solutions_Create = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "16,0,0,0"
		Text           = "$($lang.Solution): $($lang.IsCreate)"
		Tag            = "Solutions_Create_UI"
	}

	<#
		.组，语言
	#>
	$UI_Main_Need_Mount_Lang_Add = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.AddTo
		Tag            = "Language_Add_UI"
	}
	$UI_Main_Need_Mount_Lang_Del = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Del
		Tag            = "Language_Delete_UI"
	}
	$UI_Main_Need_Mount_Lang_Change = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.SwitchLanguage
		Tag            = "Language_Change_UI"
	}
	$UI_Main_Need_Mount_Lang_Components = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.OnlyLangCleanup
		Tag            = "Language_Cleanup_Components_UI"
	}

	<#
		.组，UWP 应用
	#>
	$UI_Main_Need_Mount_InBox_Apps_One = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.StepOne
		Tag            = "InBox_Apps_Mark_UI"
	}
	$UI_Main_Need_Mount_InBox_Apps_Two = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = "$($lang.StepTwo)$($lang.AddTo)"
		Tag            = "InBox_Apps_Add_UI"
	}
	$UI_Main_Need_Mount_InBox_Apps_Update = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = "$($lang.LocalExperiencePackTips): $($lang.Update)"
		Tag            = "InBox_Apps_Update_UI"
	}
	$UI_Main_Need_Mount_InBox_Apps_Remove = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = "$($lang.LocalExperiencePackTips): $($lang.Del)"
		Tag            = "InBox_Apps_Remove_UI"
	}
	$UI_Main_Need_Mount_InBox_Apps_Match_Del = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.InboxAppsMatchDel
		Tag            = "InBox_Apps_Match_Delete_UI"
	}

	<#
		.组，更新
	#>
	$UI_Main_Need_Mount_Update_Add = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.AddTo
		Tag            = "Update_Add_UI"
	}
	$UI_Main_Need_Mount_Update_Del = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Del
		Tag            = "Update_Delete_UI"
	}

	<#
		.组，驱动
	#>
	$UI_Main_Need_Mount_Drive_Add = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.AddTo
		Tag            = "Drive_Add_UI"
	}
	$UI_Main_Need_Mount_Drive_Del = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Del
		Tag            = "Drive_Delete_UI"
	}

	<#
		.组，Windows 功能
	#>
	$UI_Main_Need_Mount_Feature_Enabled_Match = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = "$($lang.Enable), $($lang.MatchMode)"
		Tag            = "Feature_Enabled_Match_UI"
	}
	$UI_Main_Need_Mount_Feature_Disable_Match = New-Object System.Windows.Forms.CheckBox -Property @{
		Name           = "IsAssign"
		Height         = 35
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = "$($lang.Disable), $($lang.MatchMode)"
		Tag            = "Feature_Disable_Match_UI"
	}
	$UI_Main_Need_Mount_Feature_Enabled = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Enable
		Tag            = "Feature_Enabled_UI"
	}
	$UI_Main_Need_Mount_Feature_Disable = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Disable
		Tag            = "Feature_Disable_UI"
	}

	<#
		.运行 PowerShell 函数
	#>
	$GUIImage_Functions_Before = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Functions_Before
		Tag            = "Functions_Before_UI"
	}
	$GUIImage_Functions_Rear = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 35
		Width          = 450
		Padding        = "31,0,0,0"
		Text           = $lang.Functions_Rear
		Tag            = "Functions_Rear_UI"
	}

	<#
		.无需挂载时
	#>
	$UI_Main_Select_No_Mounting_Group = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 310
		Width          = 485
		Location       = "560,20"
		autoSizeMode   = 0
		autoScroll     = $True
	}
	$UI_Main_Select_No_Mounting = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		AutoSize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
	}

	<#
		.组，无挂载时可用事件
	#>
	$GUIImageSelectEventNeedMount = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		Text           = $lang.AssignNoMount
	}
	$GUIImageSelectFunctionConvertImage = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "16,0,0,0"
		Text           = "$($lang.Convert_Only), $($lang.Conver_Merged), $($lang.Conver_Split_To_Swm)"
		Tag            = "Image_Convert_UI"
	}
	$GUIImageSelectFunctionISO = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "16,0,0,0"
		Text           = $lang.UnpackISO
		Tag            = "ISO_Create_UI"
	}

	<#
		.组，有任务可用时
	#>
	$GUIImageSelectEventHave_Group = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		AutoSize       = 1
		autoSizeMode   = 1
		autoScroll     = $False
	}
	$GUIImageSelectEventHave = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 450
		margin         = "0,15,0,0"
		Text           = $lang.AfterFinishingNotExecuted
	}
	$GUIImageSelectEventCompletionGUI = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "16,0,0,0"
		Text           = "$($lang.AfterFinishingPause), $($lang.AfterFinishingReboot), $($lang.AfterFinishingShutdown)"
		Tag            = "Event_Completion_Setting_UI"
		ForeColor      = "#DAA520"
	}
	$GUIImageSelectFunctionWaitTime = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 450
		Padding        = "16,0,0,0"
		Text           = $lang.WaitTimeTitle
		Tag            = "Event_Completion_Start_Setting_UI"
		ForeColor      = "#DAA520"
	}

	$UI_Main_Sync_To   = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 36
		Width          = 415
		Text           = $lang.SuggestedNext
		Location       = '562,595'
		Enabled        = $False
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "560,635"
		Height         = 36
		Width          = 240
		Text           = $lang.OK
		add_Click      = {
			$UI_Main.Hide()
			<#
				.分配无需挂载项
			#>
			$Global:Queue_Assign_Not_Monuted_Expand_Select = @()
			$UI_Main_Select_No_Mounting.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Global:Queue_Assign_Not_Monuted_Expand_Select += $_.Tag
						}
					}
				}
			}

			<#
				.所有任务，有可用挂载时
			#>
			$Global:Queue_Assign_Available_Select = @()
			$GUIImageSelectEventHave_Group.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Global:Queue_Assign_Available_Select += $_.Tag
						}
					}
				}
			}

			<#
				.初始化
			#>
			$Temp_Assign_Task_ing = @()
			$Temp_Assign_Task_Select = @()
			$UI_Main_Menu.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						if ($_.Checked) {
							$Temp_Assign_Task_Select += $_.Tag
						} else {
							$Temp_Assign_Task_ing += $_.Tag
						}
					}
				}
			}

			$Temp_Save_Has_Been_Run = (Get-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
			ForEach ($item in $Temp_Save_Has_Been_Run) {
				$Temp_Assign_Task_ing += $item
			}
			New-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Assign_Task_ing -Force

			<#
				.设置到当前
			#>
			New-Variable -Scope global -Name "Queue_Is_Mounted_Expand_Assign_Task_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -Value $Temp_Assign_Task_Select -Force
			if ($Setting) {
				Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "IsMountedExpand_Select" -value $TempSelectAssignTask -Multi
				Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "NotMonutedExpand_Select" -value $Global:Queue_Assign_Not_Monuted_Expand_Select -Multi
				Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "IsEvent_Select" -value $Global:Queue_Assign_Available_Select -Multi
			} else {
				if ($UI_Main_Sync_To.Enabled) {
					if ($UI_Main_Sync_To.Checked) {
						Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "IsMountedExpand_Select" -value $TempSelectAssignTask -Multi
						Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "NotMonutedExpand_Select" -value $Global:Queue_Assign_Not_Monuted_Expand_Select -Multi
						Save_Dynamic -regkey "Solutions\Suggested\$($Global:Event_Guid)" -name "IsEvent_Select" -value $Global:Queue_Assign_Available_Select -Multi
					}
				}
			}
			$UI_Main.Close()
		}
	}
	$UI_Main_Canel     = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "807,635"
		Height         = 36
		Width          = 240
		Text           = $lang.Cancel
		add_Click      = {
			$UI_Main.Close()
		}
	}
	$UI_Main.controls.AddRange((
		$UI_Main_Menu,
		$UI_Main_Select_No_Mounting_Group,
		$UI_Main_Sync_To,
		$UI_Main_OK,
		$UI_Main_Canel
	))
	$UI_Main_Menu.controls.AddRange((
		$UI_Main_Need_Mount_Name
	))

	$UI_Main_Select_No_Mounting_Group.controls.AddRange($GUIImageSelectEventHave_Group)
	$GUIImageSelectEventHave_Group.controls.AddRange((
		$GUIImageSelectEventHave,
		$GUIImageSelectEventCompletionGUI,
		$GUIImageSelectFunctionWaitTime
	))

	$Temp_Add_Not_Mounted_New = @()

	if ($Global:Queue_Assign_Not_Monuted_Primary.Count -gt 0) {
		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Primary) {
			$Temp_Add_Not_Mounted_New += $item
		}
	}

	if ($Global:Queue_Assign_Not_Monuted_Expand.Count -gt 0) {
		ForEach ($item in $Global:Queue_Assign_Not_Monuted_Expand) {
			$Temp_Add_Not_Mounted_New += $item
		}
	}

	$Temp_Add_Not_Mounted_New = $Temp_Add_Not_Mounted_New | Where-Object { -not ([string]::IsNullOrEmpty($_) -or [string]::IsNullOrWhiteSpace($_))} | Select-Object -Unique
	if ($Temp_Add_Not_Mounted_New.Count -gt 0) {
		$UI_Main_Select_No_Mounting_Group.controls.AddRange($UI_Main_Select_No_Mounting)
		$UI_Main_Select_No_Mounting.controls.AddRange($GUIImageSelectEventNeedMount)

		if ($Temp_Add_Not_Mounted_New -Contains "Image_Convert_UI") {
			$UI_Main_Select_No_Mounting.controls.AddRange($GUIImageSelectFunctionConvertImage)
			
			if (Image_Is_Mount) {
				$GUIImageSelectFunctionConvertImage.Enabled = $False
			}
		}

		if ($Temp_Add_Not_Mounted_New -Contains "ISO_Create_UI") {
			$UI_Main_Select_No_Mounting.controls.AddRange($GUIImageSelectFunctionISO)
		}
		
		$UI_Main_Select_No_Mounting.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($Global:Queue_Assign_Not_Monuted_Expand_Select -Contains $_.Tag) {
					$_.Checked = $True
				}
			}
		}
	}

	<#
		.有事件触发时：暂停，关闭计算机，重启计算机，何时开始等
	#>
	$UI_Main_Select_No_Mounting_Group.controls.AddRange($GUIImageSelectEventHave_Group)
	$GUIImageSelectEventHave_Group.controls.AddRange((
		$GUIImageSelectEventHave,
		$GUIImageSelectEventCompletionGUI,
		$GUIImageSelectFunctionWaitTime
	))

	<#
		.所有任务，有可用挂载时
	#>
	$GUIImageSelectEventHave_Group.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Global:Queue_Assign_Available_Select -Contains $_.Tag) {
				$_.Checked = $True
			}
		}
	}

	$MarkShareGroup = $False
	$Temp_Is_Mounted_Assign_Task_Check = @()
	$Temp_Queue_Is_Mounted_Primary_Assign_Task = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Primary_Assign_Task_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	$Temp_Queue_Is_Mounted_Expand_Assign_Task = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Expand_Assign_Task_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value

	ForEach ($item in $Temp_Queue_Is_Mounted_Primary_Assign_Task) {
		$Temp_Is_Mounted_Assign_Task_Check += $item
	}

	ForEach ($item in $Temp_Queue_Is_Mounted_Expand_Assign_Task) {
		$Temp_Is_Mounted_Assign_Task_Check += $item
	}

	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Solutions_Create_UI") { $MarkShareGroup = $True }

	if ($MarkShareGroup) {
		$UI_Main_Need_Mount = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Text           = $lang.AssignNoMount
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Solutions_Create_UI") {$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Solutions_Create) }

		$UI_Main_Not_Need_Mount_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
			}
		$UI_Main_Menu.controls.AddRange($UI_Main_Not_Need_Mount_Wrap)
	}

	$MarkLanguageGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Add_UI") { $MarkLanguageGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Delete_UI") { $MarkLanguageGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Change_UI") { $MarkLanguageGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Cleanup_Components_UI") { $MarkLanguageGroup = $True }

	if ($MarkLanguageGroup) {
		$UI_Main_Need_Mount_Lang_Name = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.Language
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Name)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Add_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Add) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Delete_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Del) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Change_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Change) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Language_Cleanup_Components_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Components) }

		$UI_Main_Need_Mount_Lang_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Wrap)
	}

	$MarkUwpGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Mark_UI") { $MarkUwpGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Add_UI") { $MarkUwpGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Update_UI") { $MarkUwpGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Match_Delete_UI") { $MarkUwpGroup = $True }

	if ($MarkUwpGroup) {
		$GUIQueueUWP       = New-Object System.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.InboxAppsManager
		}
		$UI_Main_Menu.controls.AddRange($GUIQueueUWP)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Mark_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_One) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Add_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_Two) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Update_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_Update) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Remove_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_Remove) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "InBox_Apps_Match_Delete_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_Match_Del) }

		$UI_Main_Need_Mount_InBox_Apps_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_InBox_Apps_Wrap)
	}

	$MarkUpdateGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Update_Add_UI") {  $MarkUpdateGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Update_Delete_UI") { $MarkUpdateGroup = $True }

	if ($MarkUpdateGroup) {
		$UI_Main_Need_Mount_Update_Name = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.CUpdate
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Update_Name)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Update_Add_UI") {  $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Update_Add) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Update_Delete_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Update_Del) }

		$UI_Main_Need_Mount_Update_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Update_Wrap)
	}

	$MarkDriveGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Drive_Add_UI") { $MarkDriveGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Drive_Delete_UI") { $MarkDriveGroup = $True }

	if ($MarkDriveGroup) {
		$UI_Main_Need_Mount_Drive_Name = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.Drive
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Drive_Name)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Drive_Add_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Drive_Add) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Drive_Delete_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Drive_Del) }

		$UI_Main_Need_Mount_Drive_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Drive_Wrap)
	}

	$MarkWinFeatureGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Enabled_Match_UI") { $MarkWinFeatureGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Disable_Match_UI") { $MarkWinFeatureGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Enabled_UI") { $MarkWinFeatureGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Disable_UI") { $MarkWinFeatureGroup = $True }

	if ($MarkWinFeatureGroup) {
		$UI_Main_Need_Mount_Windows_Feature = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.WindowsFeature
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Windows_Feature)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Enabled_Match_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Feature_Enabled_Match) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Disable_Match_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Feature_Disable_Match) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Enabled_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Feature_Enabled) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Feature_Disable_UI") { $UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Feature_Disable) }

		$UI_Main_Need_Mount_Lang_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Wrap)
	}

	$MarkFunctionsGroup = $False
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Functions_Before_UI") { $MarkFunctionsGroup = $True }
	if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Functions_Rear_UI") { $MarkFunctionsGroup = $True }

	if ($MarkFunctionsGroup) {
		$UI_Main_Need_Mount_Functions = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 450
			Padding        = "16,0,0,0"
			Text           = $lang.SpecialFunction
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Functions)

		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Functions_Before_UI") { $UI_Main_Menu.controls.AddRange($GUIImage_Functions_Before) }
		if ($Temp_Is_Mounted_Assign_Task_Check -Contains "Functions_Rear_UI") { $UI_Main_Menu.controls.AddRange($GUIImage_Functions_Rear) }

		$UI_Main_Need_Mount_Lang_Wrap = New-Object system.Windows.Forms.Label -Property @{
			Height         = 30
			Width          = 460
		}
		$UI_Main_Menu.controls.AddRange($UI_Main_Need_Mount_Lang_Wrap)
	}

	<#
		.正在执行或已执行，将字体变为绿色并禁用
	#>
	$Temp_Save_Has_Been_Run = (Get-Variable -Scope global -Name "Queue_Assign_Has_Been_Run_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	$UI_Main_Menu.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Temp_Save_Has_Been_Run -Contains $_.Tag) {
				$_.ForeColor = "GREEN"
				$_.Checked = $True
				if ($Global:EventQueueMode) {
					$_.Enabled = $False
				}
			}
		}
	}
	$UI_Main_Select_No_Mounting.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Temp_Save_Has_Been_Run -Contains $_.Tag) {
				$_.ForeColor = "GREEN"
				$_.Checked = $True
				$_.Enabled = $False
			}
		}
	}

	<#
		.将“主键”设置为：1、选择、2、禁用；
	#>
	$Temp_Queue_Is_Mounted_Primary_Assign_Task = @()
	$Temp_Queue_Is_Mounted_Primary_Assign_Task += (Get-Variable -Scope global -Name "Queue_Is_Mounted_Primary_Assign_Task_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	$Temp_Queue_Is_Mounted_Primary_Assign_Task += $Global:Queue_Assign_Not_Monuted_Primary

	$UI_Main_Menu.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Temp_Queue_Is_Mounted_Primary_Assign_Task -Contains $_.Tag) {
				$_.ForeColor = "GREEN"
				$_.Checked = $True
				$_.Enabled = $False
			}
		}
	}
	$UI_Main_Select_No_Mounting.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Temp_Queue_Is_Mounted_Primary_Assign_Task -Contains $_.Tag) {
				$_.ForeColor = "GREEN"
				$_.Checked = $True
				$_.Enabled = $False
			}
		}
	}

	<#
		.仅勾选已勾选的。
	#>
	$Temp_Queue_Is_Mounted_Primary_Assign_Task = (Get-Variable -Scope global -Name "Queue_Is_Mounted_Expand_Assign_Task_Select_$($Global:Primary_Key_Image.Master)_$($Global:Primary_Key_Image.ImageFileName)" -ErrorAction SilentlyContinue).Value
	$UI_Main_Menu.Controls | ForEach-Object {
		if ($_ -is [System.Windows.Forms.CheckBox]) {
			if ($Temp_Queue_Is_Mounted_Primary_Assign_Task -Contains $_.Tag) {
				$_.Checked = $True
			}
		}
	}

	<#
		.默认到下一次
	#>
	if ($Setting) {
		$UI_Main_Sync_To.visible = $False
	} else {
		if ($Global:EventQueueMode) {
			$UI_Main_Sync_To.visible = $False
		} else {
			$UI_Main_Sync_To.visible = $True
			$UI_Main_Sync_To.Enabled = $True
		}
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

	if ($Global:EventQueueMode) {
		if ($Global:AutopilotMode) {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Autopilot) ]"
		} else {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.OnDemandPlanTask), $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
		}
	} else {
		if (Image_Is_Select_IAB) {
			$UI_Main.Text = "$($UI_Main.Text) [ $($lang.Event_Primary_Key): $($Global:Primary_Key_Image.Uid) ]"
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
	.创建全局已选主键
#>
Function Image_Set_Global_Primary_Key
{
	param
	(
		$DevCode,
		$Uid,
		[switch]$Detailed,
		[switch]$Silent
	)

	if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
		Write-Host "`n   $($lang.Command)" -ForegroundColor Green
		Write-host "   $($lang.Developers_Mode_Location)$($DevCode)" -ForegroundColor Green
		Write-host "   $('-' * 80)`n"
	}

	$Global:Primary_Key_Image = @()
	$custom_array = @()

	ForEach ($item in $Global:Image_Rule) {
		if ($Uid -eq $item.Main.Uid) {
			if (-not $Silent) {
				Write-Host "`n   $($lang.Event_Primary_Key)" -ForegroundColor Yellow
				Write-Host "   $($Uid)" -ForegroundColor Green
			}

			if ($Detailed) {
				Write-Host "   $($lang.Refresh)".PadRight(28) -NoNewline
				if (Test-Path -Path "$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)" -PathType Leaf) {
					$RandomGuid = [guid]::NewGuid()
					$wimlib = "$(Get_Arch_Path -Path "$($PSScriptRoot)\..\..\..\..\AIO\wimlib")\wimlib-imagex.exe"

					$Export_To_New_Xml = "$($env:TEMP)\$($RandomGuid).xml"
					if (Test-Path $wimlib -PathType Leaf) {
						$Arguments = "info ""$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)"" --extract-xml ""$($Export_To_New_Xml)"""
						Start-Process -FilePath $wimlib -ArgumentList $Arguments -wait -nonewwindow

						if (Test-Path $Export_To_New_Xml -PathType Leaf) {
							[XML]$empDetails = Get-Content $Export_To_New_Xml

							ForEach ($empDetail in $empDetails.wim.IMAGE) {
								$New_Temp_CreatedTime = [DateTime]::FromFileTime($empDetail.LASTMODIFICATIONTIME.HIGHPART)

								$custom_array += @{
									ImageIndex         = $empDetail.index
									ImageName          = $empDetail.NAME
									ImageDescription   = $empDetail.DESCRIPTION
									DISPLAYNAME        = $empDetail.DISPLAYNAME
									DISPLAYDESCRIPTION = $empDetail.DISPLAYDESCRIPTION
									EditionId          = $empDetail.WINDOWS.EDITIONID
									Architecture       = $empDetail.WINDOWS.ARCH
									CreatedTime        = $(Get-Date $New_Temp_CreatedTime -Format "dd/MM/yyyy HH:mm:ss tt")
									ImageSize          = $empDetail.TOTALBYTES
									Version            = "$($empDetail.WINDOWS.VERSION.BUILD).$($empDetail.WINDOWS.VERSION.SPBUILD)"
								}
							}

							Remove-Item -Path $Export_To_New_Xml
							Write-Host $lang.Done -ForegroundColor Green
						} else {
							Write-Host $lang.SelectFromError -ForegroundColor Red
							Write-host "   $($lang.ConvertChk)"
							Write-host "   $($Export_To_New_Xml)" -ForegroundColor Red
							return
						}
					} else {
						try {
							if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
								Write-Host "`n   $($lang.Command)" -ForegroundColor Green
								Write-host "   $($lang.Developers_Mode_Location)29" -ForegroundColor Green
								Write-host "   $('-' * 80)"
								write-host "   Get-WindowsImage -ImagePath ""$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)""" -ForegroundColor Green
								Write-host "   $('-' * 80)`n"
							}

							Get-WindowsImage -ImagePath "$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)" -ErrorAction SilentlyContinue | ForEach-Object {
								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)30" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Get-WindowsImage -ImagePath ""$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)"" -index ""$($_.ImageIndex)""" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Get-WindowsImage -ImagePath "$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)" -index $_.ImageIndex -ErrorAction SilentlyContinue | ForEach-Object {
									$custom_array += @{
										ImageIndex         = $_.ImageIndex
										ImageName          = $_.ImageName
										ImageDescription   = $_.ImageDescription
										DISPLAYNAME        = ""
										DISPLAYDESCRIPTION = ""
										EditionId          = $_.EditionId
										Architecture       = $_.Architecture
										CreatedTime        = $_.CreatedTime
										ImageSize          = $_.ImageSize
										Version            = $_.Version
									}
								}
							}

							Write-Host $lang.Done -ForegroundColor Green
						} catch {
							Write-Host $lang.SelectFromError -ForegroundColor Red
							Write-Host "   $($_)" -ForegroundColor Yellow
							Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
						}
					}
				} else {
					Write-Host $lang.SelectFromError -ForegroundColor Red
					Write-Host "   $($lang.NoInstallImage)"
					Write-host "   $($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)" -ForegroundColor Red
				}
			}

			if (-not $Silent) {
				Write-Host "   $($lang.Setting)".PadRight(28) -NoNewline
			}

			$Global:Primary_Key_Image = @{
				ImageSources   = $Global:Image_source
				Group          = $item.Main.Group
				Uid            = $item.Main.Uid
				Master         = $item.Main.ImageFileName
				ImageFileName  = $item.Main.ImageFileName
				Suffix         = $item.Main.Suffix
				Path           = $item.Main.Path
				FullPath       = "$($item.Main.Path)\$($item.Main.ImageFileName).$($item.Main.Suffix)"
				Index          = $custom_array
			}

			if (-not $Silent) {
				Write-Host $lang.Done -ForegroundColor Green
			}
			return
		}

		if ($item.Expand.Count -gt 0) {
			ForEach ($Expand in $item.Expand) {
				if ($Uid -eq $Expand.Uid) {
					if (-not $Silent) {
						Write-Host "`n   $($Expand.ImageFileName).wim" -ForegroundColor Green
					}

					if ($Detailed) {
						Write-Host "   $($lang.Refresh)".PadRight(28) -NoNewline
						if (Test-Path -Path "$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)" -PathType Leaf) {
							try {
								if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
									Write-Host "`n   $($lang.Command)" -ForegroundColor Green
									Write-host "   $($lang.Developers_Mode_Location)31" -ForegroundColor Green
									Write-host "   $('-' * 80)"
									write-host "   Get-WindowsImage -ImagePath ""$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)""" -ForegroundColor Green
									Write-host "   $('-' * 80)`n"
								}

								Get-WindowsImage -ImagePath "$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)" -ErrorAction SilentlyContinue | ForEach-Object {
									Get-WindowsImage -ImagePath "$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)" -index $_.ImageIndex -ErrorAction SilentlyContinue | ForEach-Object {
										$custom_array += @{
											ImageIndex       = $_.ImageIndex
											ImageName        = $_.ImageName
											ImageDescription = $_.ImageDescription
											EditionId        = $_.EditionId
										}
									}
								}

								Write-Host $lang.Done -ForegroundColor Green
							} catch {
								Write-Host $lang.SelectFromError -ForegroundColor Red
								Write-Host "   $($_)" -ForegroundColor Yellow
								Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
								return
							}
						}
					}

					if (-not $Silent) {
						Write-Host "   $($lang.Setting)".PadRight(28) -NoNewline
					}

					$Global:Primary_Key_Image = @{
						ImageSources   = $Global:Image_source
						Group          = $Expand.Group
						Uid            = $Expand.Uid
						Master         = $item.Main.ImageFileName
						ImageFileName  = $Expand.ImageFileName
						Suffix         = $Expand.Suffix
						Path           = $Expand.Path
						FullPath       = "$($Expand.Path)\$($Expand.ImageFileName).$($Expand.Suffix)"
						Index          = $custom_array
					}

					if (-not $Silent) {
						Write-Host $lang.Done -ForegroundColor Green
					}
					return
				}
			}
		}
	}
}