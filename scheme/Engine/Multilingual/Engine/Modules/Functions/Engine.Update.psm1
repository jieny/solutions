﻿<#
 .Synopsis
  Update

 .Description
  Update Feature Modules
#>

<#
	.Current version
	.当前版本
#>
$Global:ProductVersion = "1.0.0.3"

<#
	.Update minimum version requirements
	.更新最低版本要求
#>
$Global:chkLocalver    = "1.0.0.0"

<#
	.Server test
	.服务器测试
#>
$ServerTest     = $false
$IsCorrectAuVer = $false

<#
	.Available servers
	.可用的服务器
#>
$Global:ServerList = @()
$PreServerList = @(
	("$($Global:AuthorURL)",
	 "/download/solutions/update/Multilingual/latest.xml"),
	("https://github.com",
	 "/ilikeyi/solutions/raw/main/update/Multilingual/latest.xml")
)

<#
	.Update the user interface
	.更新用户界面
#>
Function Update
{
	param
	(
		[switch]$Auto,
		[switch]$Force,
		[switch]$IsProcess
	)
	
	$Global:ServerList = @()
	if ($Force) {
		$Global:ForceUpdate = $True
	} else {
		$Global:ForceUpdate = $False
	}
	
	if ($IsProcess) {
		$Global:IsProcess = $True
	} else {
		$Global:IsProcess = $False
	}

	Logo -Title $($lang.Update)
	Write-Host "   $($lang.PlanTask)`n   ---------------------------------------------------"

	if ($Auto) {
		foreach ($item in $PreServerList | Sort-Object { Get-Random } ) {
			$Global:ServerList += $item[0] + $item[1]
		}
		UpdateProcess
	} else {
		UpdateGUI
	}
}

<#
	.Update interface
	.更新界面
#>
Function UpdateGUI
{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	Write-Host "`n   $($lang.Update)"

	$GUIUpdateAutoClick = {
		if ($GUIUpdateAuto.Checked) {
			$GUIUpdatePanel.Enabled = $False
		} else {
			$GUIUpdatePanel.Enabled = $True
		}
	}
	$GUIUpdateCanelClick = {
		$GUIUpdate.Hide()
		$Global:ServerList = @()
		$Global:UpdateAvailableSilent = $False
		$Global:UpdateAvailableReset = $False

		Write-Host "   $($lang.UserCancel)" -ForegroundColor Red
		$GUIUpdate.Close()
	}
	$GUIUpdateOKClick = {
		$Global:ServerList = @()

		if ($GUIUpdateSilent.Checked) {
			$Global:UpdateAvailableSilent = $True
		} else {
			$Global:UpdateAvailableSilent = $False
		}

		if ($GUIUpdateReset.Checked) {
			$Global:UpdateAvailableReset = $True
		} else {
			$Global:UpdateAvailableReset = $False
		}

		if ($GUIUpdateAuto.Checked) {
			$GUIUpdate.Hide()
			foreach ($item in $PreServerList | Sort-Object { Get-Random } ) {
				$Global:ServerList += $item[0] + $item[1]
			}
			UpdateProcess
			$GUIUpdate.Close()
		} else {
			$FlagsVerifyServerlist = $False
			$GUIUpdatePanel.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Checked) {
						$FlagsVerifyServerlist = $true
						$Global:ServerList += $_.Tag
					}
				}
			}

			if ($FlagsVerifyServerlist) {
				$GUIUpdate.Hide()
				UpdateProcess
				$GUIUpdate.Close()
			} else {
				$GUIUpdateErrorMsg.Text = "$($lang.UpdateServerNoSelect)"
			}
		}
	}
	$GUIUpdate         = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 568
		Width          = 450
		Text           = $lang.Update
		TopMost        = $True
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $False
		ControlBox     = $False
		BackColor      = "#ffffff"
	}
	$GUIUpdateAuto     = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 395
		Text           = $lang.UpdateServerSelect
		Location       = '10,6'
		add_Click      = $GUIUpdateAutoClick
		Checked        = $True
	}
	$GUIUpdatePanel    = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 320
		Width          = 428
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Padding        = "24,0,8,0"
		Dock           = 0
		Location       = "0,28"
		Enabled        = $False
	}
	$GUIUpdateSilent   = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 395
		Text           = $lang.UpdateSilent
		Location       = '10,368'
		Checked        = $True
	}
	$GUIUpdateReset    = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 22
		Width          = 395
		Text           = $lang.UpdateReset
		Location       = '10,395'
	}
	$GUIUpdateResetTips = New-Object system.Windows.Forms.Label -Property @{
		Location       = "26,418"
		Height         = 28
		Width          = 390
		Text           = $lang.UpdateResetTips
	}
	$GUIUpdateErrorMsg = New-Object system.Windows.Forms.Label -Property @{
		Location       = "10,458"
		Height         = 22
		Width          = 405
		Text           = ""
	}
	$GUIUpdateOK       = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "10,482"
		Height         = 36
		Width          = 202
		add_Click      = $GUIUpdateOKClick
		Text           = $lang.OK
	}
	$GUIUpdateCanel    = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "218,482"
		Height         = 36
		Width          = 202
		add_Click      = $GUIUpdateCanelClick
		Text           = $lang.Cancel
	}
	$GUIUpdate.controls.AddRange((
		$GUIUpdateAuto,
		$GUIUpdatePanel,
		$GUIUpdateSilent,
		$GUIUpdateReset,
		$GUIUpdateResetTips,
		$GUIUpdateErrorMsg,
		$GUIUpdateOK,
		$GUIUpdateCanel
	))

	foreach ($list in $PreServerList) {
		$fullurl = $list[0] + $list[1]
		$CheckBox   = New-Object System.Windows.Forms.CheckBox -Property @{
			Height  = 26
			Width   = 395
			Text    = $list[0]
			Tag     = $fullurl
			Checked = $true
		}
		$GUIUpdatePanel.controls.AddRange($CheckBox)
	}

	<#
		.Add right-click menu: select all, clear button
		.添加右键菜单：全选、清除按钮
	#>
	$GUIUpdateAllSelClick = {
		$GUIUpdatePanel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	}
	$GUIUpdateAllClearClick = {
		$GUIUpdatePanel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	}
	$GUIUpdateMenu = New-Object System.Windows.Forms.ContextMenuStrip
	$GUIUpdateMenu.Items.Add($lang.AllSel).add_Click($GUIUpdateAllSelClick)
	$GUIUpdateMenu.Items.Add($lang.AllClear).add_Click($GUIUpdateAllClearClick)
	$GUIUpdatePanel.ContextMenuStrip = $GUIUpdateMenu

	switch ($Global:IsLang) {
		"zh-CN" {
			$GUIUpdate.Font = New-Object System.Drawing.Font("Microsoft YaHei", 9, [System.Drawing.FontStyle]::Regular)
		}
		Default {
			$GUIUpdate.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
		}
	}

	$GUIUpdate.FormBorderStyle = 'Fixed3D'
	$GUIUpdate.ShowDialog() | Out-Null
}

<#
	.Update process
	.更新处理
#>
Function UpdateProcess
{
	<#
		.Disabled IE first-launch configuration
		.禁用 IE 首次启动配置
	#>
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2 -ErrorAction SilentlyContinue

	Write-Host "   $($lang.UpdateCheckServerStatus -f $($Global:ServerList.Count))
   ---------------------------------------------------"

	foreach ($item in $Global:ServerList) {
		Write-Host "   * $($lang.UpdateServerAddress -f $($item))"
		if (TestURI $item) {
			$versionxmlloc = $item
			$ServerTest = $true
			Write-Host "   - $($lang.UpdateServeravailable)" -ForegroundColor Green
			break
		} else {
			Write-Host "   - $($lang.UpdateServerUnavailable)`n" -ForegroundColor Red
		}
	}

	if ($ServerTest) {
		Write-Host "   ---------------------------------------------------"
		Write-Host "   - $($lang.UpdatePriority)" -ForegroundColor Green
	} else {
		Write-Host "   - $($lang.UpdateServerTestFailed)" -ForegroundColor Red
		Write-Host "   ---------------------------------------------------"
		return
	}

	Write-host "`n   $($lang.UpdateQueryingUpdate)"

	$error.Clear()
	$time = Measure-Command { Invoke-WebRequest -Uri $versionxmlloc -ErrorAction SilentlyContinue }

	if ($error.Count -eq 0) {
		Write-Host "`n   $($lang.UpdateQueryingTime -f $($time.TotalMilliseconds))"
	} else {
		Write-host "`n   $($lang.UpdateConnectFailed)"
		return
	}

	$getSerVer = (Invoke-WebRequest -Uri $versionxmlloc -UseBasicParsing -Body $body -Method:Get -Headers $head -ContentType "application/xml" -TimeoutSec 15 -ErrorAction:stop)
	$chkRemovever = ([xml]$getSerVer.Content).versioninfo.version.minau
	$PPocess = "$PSScriptRoot\Post.Processing.bat"
	$PsPocess = "$PSScriptRoot\Post.Processing.ps1"

	If ([String]::IsNullOrEmpty($chkRemovever)) {
		$IsCorrectAuVer = $false
	} else {
		if ($Global:chkLocalver.Replace('.', '') -ge $chkRemovever.Replace('.', '')) {
			$IsCorrectAuVer = $true
		} else {
			$IsCorrectAuVer = $false
		}
	}

	if ($IsCorrectAuVer) {
		Write-Host "`n   $($lang.UpdateMinimumVersion -f $($Global:chkLocalver))"
		$IsUpdateAvailable = $false
		$url = ([xml]$getSerVer.Content).versioninfo.download.url
		$output = Convert-Path "$PSScriptRoot\..\..\..\latest.zip" -ErrorAction SilentlyContinue | Out-Null

		if (([xml]$getSerVer.Content).versioninfo.version.version.Replace('.', '') -gt $Global:ProductVersion.Replace('.', '')) {
			$IsUpdateAvailable = $true
		} else {
			$IsUpdateAvailable = $false
		}

		if ($IsUpdateAvailable) {
			Write-host "`n   $($lang.UpdateVerifyAvailable)
   ---------------------------------------------------"

			Write-Host "   * $($lang.UpdateDownloadAddress)$($url)"
			if (TestURI $url) {
				Write-Host "   - $($lang.UpdateAvailable)" -ForegroundColor Green
				Write-Host "   ---------------------------------------------------"
			} else {
				Write-Host "   - $($lang.UpdateUnavailable)" -ForegroundColor Red
				Write-Host "   ---------------------------------------------------"
				ImportModules
				If ($Global:ForceUpdate) {
					return
				}
			}

			Write-host "`n   $($lang.UpdateCurrent)$($Global:ProductVersion)
   $($lang.UpdateLatest)$(([xml]$getSerVer.Content).versioninfo.version.version)

   $(([xml]$getSerVer.Content).versioninfo.changelog.title)
   $('-' * (([xml]$getSerVer.Content).versioninfo.changelog.title).Length)
$(([xml]$getSerVer.Content).versioninfo.changelog.'#text')"

			Write-host "   $($lang.UpdateNewLatest)`n" -ForegroundColor Green

			$FlagsCheckForceUpdate = $False
			If ($Global:ForceUpdate) {
				$FlagsCheckForceUpdate = $True
			}

			if ($Global:UpdateAvailableSilent) {
				$FlagsCheckForceUpdate = $True
			}

			if ($Global:UpdateAvailableReset) {
				$FlagsCheckForceUpdate = $True
			}

			If ($FlagsCheckForceUpdate) {
				$title = "   $($lang.UpdateForce)"

				ArchivePacker -output $output
			} else {
				$title = "$($lang.UpdateInstall)"
				$message = "$($lang.UpdateInstallSel)"
				$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
				$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
				$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
				$prompt=$host.ui.PromptForChoice($title, $message, $options, 0)
				Switch ($prompt)
				{
					0 {
						ArchivePacker -output $output
					}
					1 {
						Write-Host "`n   $($lang.UserCancel)"
						ImportModules
					}
				}
			}
		} else {
			if ($Global:UpdateAvailableReset) {
				$title = "   $($lang.UpdateForce)"
				ArchivePacker -output $output
			} else {
				Write-host "   $($lang.UpdateNoUpdateAvailable -f $($Global:UniqueID))"
			}
		}
	} else {
		Write-host "   $($lang.UpdateNotSatisfied -f $($Global:chkLocalver), $($Global:UniqueID))"
	}

	ImportModules
	If ($Global:ForceUpdate) {
		return
	}
}

Function ArchivePacker
{
	param
	(
		$output
	)

	$start_time = Get-Date
	remove-item -path $output -force -ErrorAction SilentlyContinue
	Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction SilentlyContinue
	Write-Host "`n   $($lang.UpdateTimeUsed)$((Get-Date).Subtract($start_time).Seconds) (s)"

	if ((Test-Path $output -PathType Leaf)) {
		Write-Host "`n   $($lang.UpdateUnpacking)$output"
		Archive -filename $output -to "$PSScriptRoot\..\..\..\"
		ImportModules
		Write-Host "`n   * $($lang.UpdatePostProc)"
		if ($Global:IsProcess) {
			Write-Host "   - $($lang.UpdateNotExecuted)" -ForegroundColor red
		} else {
			if ((Test-Path $PPocess -PathType Leaf)) {
				Start-Process -FilePath $PPocess -wait -WindowStyle Minimized
				remove-item -path $PPocess -force
				Write-Host "   - $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   - $($lang.UpdateNoPost)" -ForegroundColor red
			}
			if ((Test-Path $PsPocess -PathType Leaf)) {
				Start-Process powershell -ArgumentList "-file $($PsPocess)" -Wait -WindowStyle Minimized
				remove-item -path $PsPocess -force
				Write-Host "   - $($lang.Done)`n" -ForegroundColor Green
			} else {
				Write-Host "   - $($lang.UpdateNoPost)`n" -ForegroundColor red
			}
			ImportModules
			Write-host "`n   $($Global:UniqueID)'s Solutions $($lang.UpdateDone)`n"
		}
	} else {
		Write-host "`n   $($lang.UpdateUpdateStop)"
	}
	remove-item -path $output -force -ErrorAction SilentlyContinue
}

<#
	.Unzip
	.解压缩
#>
Function Archive
{
	param
	(
		$filename,
		$to
	)

	Convert-Path $filename -ErrorAction SilentlyContinue | Out-Null

	if (Compressing) {
		Write-host "   - $($lang.UseZip -f $($Global:Zip))"
		$arguments = "x ""-r"" ""-tzip"" ""$filename"" ""-o$to"" ""-y""";
		Start-Process $Global:Zip "$arguments" -Wait -WindowStyle Minimized
	} else {
		Write-host "    - $($lang.UseOSZip)"
		Expand-Archive -LiteralPath $filename -DestinationPath $to -force
	}
}

<#
	.Get compression software
	.获取压缩软件
#>
Function Compressing
{
	if (Test-Path "$env:ProgramFiles\7-Zip\7z.exe") {
		$Global:Zip = "$env:ProgramFiles\7-Zip\7z.exe"
		return $true
	}

	if (Test-Path "$env:ProgramFiles(x86)\7-Zip\7z.exe") {
		$Global:Zip = "$env:ProgramFiles(x86)\7-Zip\7z.exe"
		return $true
	}

	if (Test-Path "$(GetArchitecturePacker -Path "$($Global:UniqueMainFolder)\Engine\AIO\7zPacker")\7z.exe") {
		$Global:Zip = "$(GetArchitecturePacker -Path "$($Global:UniqueMainFolder)\Engine\AIO\7zPacker")\7z.exe"
		return $true
	}
	return $false
}

<#
	.Processing: clean up packages by architecture
	.处理：按架构清理软件包
#>
Function ArchitecturePacker
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path "$Path\arm64" -PathType Container) {
				RemoveTree -Path "$Path\AMD64"
				RemoveTree -Path "$Path\x86"
			} else {
				if (Test-Path "$Path\AMD64" -PathType Container) {
					RemoveTree -Path "$Path\arm64"
					RemoveTree -Path "$Path\x86"
				} else {
					if (Test-Path "$Path\x86" -PathType Container) {
						RemoveTree -Path "$Path\arm64"
						RemoveTree -Path "$Path\AMD64"
					}
				}
			}
		}
		"AMD64" {
			if (Test-Path "$Path\AMD64" -PathType Container) {
				RemoveTree -Path "$Path\arm64"
				RemoveTree -Path "$Path\x86"
			} else {
				if (Test-Path "$Path\x86" -PathType Container) {
					RemoveTree -Path "$Path\arm64"
					RemoveTree -Path "$Path\AMD64"
				}
			}
		}
		"x86" {
			RemoveTree -Path "$Path\arm64"
			RemoveTree -Path "$Path\AMD64"
		}
	}
}

<#
	.Clean up the interface
	.清理接口
#>
Function GetArchitecturePacker
{
	param
	(
		[string]$Path
	)

	switch ($env:PROCESSOR_ARCHITECTURE) {
		"arm64" {
			if (Test-Path "$Path\arm64" -PathType Container) {
				return "$Path\arm64"
			} else {
				if (Test-Path "$Path\AMD64" -PathType Container) {
					return "$Path\AMD64"
				} else {
					if (Test-Path "$Path\x86" -PathType Container) {
						return "$Path\x86"
					} else {
						return $Path
					}
				}
			}
		}
		"AMD64" {
			if (Test-Path "$Path\AMD64" -PathType Container) {
				return "$Path\AMD64"
			} else {
				if (Test-Path "$Path\x86" -PathType Container) {
					return "$Path\x86"
				} else {
					return $Path
				}
			}
		}
		"x86" {
			if (Test-Path "$Path\x86" -PathType Container) {
				return "$Path\x86"
			} else {
				return $Path
			}
		}
	}
}

<#
	.Test if the URL address is available
	.测试 URL 地址是否可用
#>
Function TestURI
{
	Param
	(
		[Parameter(Position=0,Mandatory,HelpMessage="HTTP or HTTPS")]
		[ValidatePattern( "^(http|https)://" )]
		[Alias("url")]
		[string]$URI,
		[Parameter(ParameterSetName="Detail")]
		[Switch]$Detail,
		[ValidateScript({$_ -ge 0})]
		[int]$Timeout = 30
	)
	Process
	{
		Try
		{
			$paramHash = @{
				UseBasicParsing = $True
				DisableKeepAlive = $True
				Uri = $uri
				Method = 'Head'
				ErrorAction = 'stop'
				TimeoutSec = $Timeout
			}
			$test = Invoke-WebRequest @paramHash
			if ($Detail) {
				$test.BaseResponse | Select-Object ResponseURI,ContentLength,ContentType,LastModified, @{Name="Status";Expression={$Test.StatusCode}}
			} else {
				if ($test.statuscode -ne 200) { $False } else { $True }
			}
		} Catch {
			write-verbose -message $_.exception
			if ($Detail) {
				$objProp = [ordered]@{
					ResponseURI = $uri
					ContentLength = $null
					ContentType = $null
					LastModified = $null
					Status = 404
				}
				New-Object -TypeName psobject -Property $objProp
			} else { $False }
		}
	}
}

Export-ModuleMember -Variable "$($Global:ProductVersion)"
Export-ModuleMember -Variable "$($Global:chkLocalver)"
Export-ModuleMember -Function "Update"
Export-ModuleMember -Function "UpdateGUI"
Export-ModuleMember -Function "UpdateProcess"
Export-ModuleMember -Function "ArchivePacker"
Export-ModuleMember -Function "Archive"
Export-ModuleMember -Function "Compressing"
Export-ModuleMember -Function "ArchitecturePacker"
Export-ModuleMember -Function "GetArchitecturePacker"
Export-ModuleMember -Function "TestURI"