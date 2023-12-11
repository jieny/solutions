<#
	.More features
	.更多功能
#>
Function Feature_More
{
	Clear-Host
	Logo -Title $($lang.MoreFeature)

	Write-Host "   $($lang.Menu)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-Host "      M   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.MoreFeature -ForegroundColor Green

	if ($Global:Developers_Mode) {
		Write-Host "      S   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Developers_Mode -ForegroundColor Green
	} else {
		Write-Host "      S   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Developers_Mode -ForegroundColor Red
	}

	write-host "      U   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.ChkUpdate -ForegroundColor Green

	Write-Host "      A   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.ViewMounted -ForegroundColor Green

	Write-Host "      B   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.UpBackup -ForegroundColor Green

	Write-Host "      H   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.ConvertToArchive -ForegroundColor Green

	Write-Host "      C   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.UpdateCreate -ForegroundColor Green

	Write-host "`n   $($lang.ViewWIMFileInfo)" -ForegroundColor Green
	Write-host "   $('-' * 80)"
	Write-host "   $($Global:Image_source)\sources\" -ForegroundColor Yellow

	if (Test-Path "$($Global:Image_source)\sources\Boot.wim" -PathType Leaf) {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Green
		Write-Host "Boot.wim" -ForegroundColor Yellow
	} else {
		Write-Host "      1   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Red
		Write-host "Boot.wim" -ForegroundColor Yellow
	}

	if (Test-Path "$($Global:Image_source)\sources\Install.wim" -PathType Leaf) {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Green
		Write-Host "Install.wim" -ForegroundColor Yellow
	} else {
		Write-Host "      2   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Red
		Write-host "Install.wim" -ForegroundColor Yellow
	}

	if (Test-Path "$($Global:Image_source)\sources\Install.swm" -PathType Leaf) {
		Write-Host "      3   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Green
		Write-Host "Install.swm" -ForegroundColor Yellow
	} else {
		Write-Host "      3   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Red
		Write-host "Install.swm" -ForegroundColor Yellow
	}

	if (Test-Path "$($Global:Image_source)\sources\Install.esd" -PathType Leaf) {
		Write-Host "      4   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Green
		Write-Host "Install.esd" -ForegroundColor Yellow
	} else {
		Write-Host "      4   " -NoNewline -ForegroundColor Yellow
		Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Red
		Write-host "Install.esd" -ForegroundColor Yellow
	}

	if (Image_Is_Select_Install) {
		Write-host "`n   $($Global:Mount_To_Route)\Install\Install\Mount" -ForegroundColor Yellow
		if (Test-Path "$($Global:Mount_To_Route)\Install\Install\Mount\Windows\System32\Recovery\WinRE.wim" -PathType Leaf) {
			Write-Host "      5   " -NoNewline -ForegroundColor Yellow
			Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Green
			Write-Host "Windows\System32\Recovery\WinRE.wim" -ForegroundColor Yellow
		} else {
			Write-Host "      5   " -NoNewline -ForegroundColor Yellow
			Write-host "$($lang.ViewWIMFileInfo): " -NoNewline -ForegroundColor Red
			Write-Host "Windows\System32\Recovery\WinRE.wim" -ForegroundColor Yellow
		}
	}

	Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	$SaveToLogsPath = "$($Global:LogsSaveFolder)\$($Global:LogSaveTo)"
	if (Test-Path $SaveToLogsPath -PathType Container) {
		Write-Host "     11   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Logging
		Write-Host "          $($SaveToLogsPath)" -ForegroundColor Green
	} else {
		Write-Host "     11   " -NoNewline -ForegroundColor Yellow
		Write-host $lang.Logging -ForegroundColor Red
	}

	Write-Host "`n     12   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.MainImageFolder
	if (Test-Path $Global:Image_source -PathType Container) {
		Write-Host "          $($Global:Image_source)" -ForegroundColor Green
	} else {
		Write-Host "          $($Global:Image_source)" -ForegroundColor Red
	}

	Write-Host "`n     13   " -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.MountImageTo), $($lang.MainImageFolder)"
	if (Test-Path $Global:Mount_To_Route -PathType Container) {
		Write-Host "          $($Global:Mount_To_Route)" -ForegroundColor Green
	} else {
		Write-Host "          $($Global:Mount_To_Route)" -ForegroundColor Red
	}

	Write-Host "`n     14   " -NoNewline -ForegroundColor Yellow
	Write-host $lang.SettingImageTempFolder
	if (Test-Path $Global:Mount_To_RouteTemp -PathType Container) {
		Write-Host "          $($Global:Mount_To_RouteTemp)" -ForegroundColor Green
	} else {
		Write-Host "          $($Global:Mount_To_RouteTemp)" -ForegroundColor Red
	}

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'm' {
			Write-host "`n   $($lang.MoreFeature)"
			Write-host "   $('-' * 80)"
			if (Image_Is_Select_IAB) {
				Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
				if (Verify_Is_Current_Same) {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Green
					Feature_More_UI_Menu
				} else {
					Write-Host "   $($lang.Mounted)" -ForegroundColor Red
				}
			} else {
				Write-Host "   $($lang.IABSelectNo)" -ForegroundColor Red
				Image_Assign_Event_Master
			}
		}
		'a' {
			Clear-Host
			Write-Host "`n   $($lang.ViewMounted)" -ForegroundColor Green

			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)97" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Get-WindowsImage -Mounted" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}
	
			Get-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Mounted | ForEach-Object {
				Write-host "   $('-' * 80)"
				Write-Host "   $($lang.Select_Path)".PadRight(18) -NoNewline
				Write-Host $_.Path -ForegroundColor Green

				Write-Host "   $($lang.Image_Path)".PadRight(18) -NoNewline
				Write-Host $_.ImagePath -ForegroundColor Green

				Write-Host "   $($lang.MountedIndex)".PadRight(18) -NoNewline
				Write-Host $_.ImageIndex -ForegroundColor Green

				Write-Host "   $($lang.Mounted_Mode)".PadRight(18) -NoNewline
				Write-Host $_.MountMode -ForegroundColor Green

				Write-Host "   $($lang.Mounted_Status)".PadRight(18) -NoNewline
				Write-Host $_.MountStatus -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			Get_Next
			ToWait -wait 2
			Feature_More
		}
		'b' {
			UnPack_Create
			Get_Next
			ToWait -wait 2
			Feature_More
		}
		'c' {
			Update_Create_UI
			ToWait -wait 2
			Feature_More
		}
		'u' {
			Update
			Modules_Refresh -Function "ToWait -wait 2"
			Feature_More
		}
		's' {
			if ($Global:Developers_Mode) {
				$Global:Developers_Mode = $False
			} else {
				$Global:Developers_Mode = $True
			}
			
			ToWait -wait 2
			Feature_More
		}
		'h' {
			Covert_Software_Package_Unpack

			ToWait -wait 2
			Feature_More
		}
		'1' {
			Image_Get_Detailed -Filename "$($Global:Image_source)\sources\Boot.wim" -View
			Get_Next

			ToWait -wait 2
			Feature_More
		}
		'2' {
			Image_Get_Detailed -Filename "$($Global:Image_source)\sources\Install.wim" -View

			Get_Next
			ToWait -wait 2
			Feature_More
		}
		'3' {
			Image_Get_Detailed -Filename "$($Global:Image_source)\sources\Install.swm" -View

			Get_Next
			ToWait -wait 2
			Feature_More
		}
		'4' {
			Image_Get_Detailed -Filename "$($Global:Image_source)\sources\Install.esd" -View

			Get_Next
			ToWait -wait 2
			Feature_More
		}
		'5' {
			if (Image_Is_Select_Install) {
				Image_Get_Detailed -Filename "$($Global:Mount_To_Route)\Install\Install\Mount\Windows\System32\Recovery\winre.wim" -View
				Get_Next
			} else {
				Write-Host "   $($lang.BootProcess -f "install")" -ForegroundColor Red
			}

			ToWait -wait 2
			Feature_More
		}
		'11' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $SaveToLogsPath -PathType Container) {
				Write-Host "   $SaveToLogsPath"
				Start-Process $SaveToLogsPath
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($SaveToLogsPath)" -ForegroundColor Red
			}

			ToWait -wait 2
			Feature_More
		}
		'12' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $Global:Image_source -PathType Container) {
				Write-Host "   $($Global:Image_source)"
				Start-Process $($Global:Image_source)
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($Global:Image_source)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Feature_More
		}
		'13' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $Global:Mount_To_Route -PathType Container) {
				Write-Host "   $($Global:Mount_To_Route)"
				Start-Process $Global:Mount_To_Route
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($Global:Image_source)" -ForegroundColor Red
			}
			
			ToWait -wait 2
			Feature_More
		}
		'14' {
			Write-Host "`n   $($lang.OpenFolder)" -ForegroundColor Green
			Write-host "   $('-' * 80)"

			if (Test-Path $Global:Mount_To_RouteTemp -PathType Container) {
				Write-Host "   $($Global:Mount_To_RouteTemp)"
				Start-Process $Global:Mount_To_RouteTemp
			} else {
				Write-Host "   $($lang.NoInstallImage)"
				Write-host "   $($Global:Image_source)" -ForegroundColor Red
			}

			ToWait -wait 2
			Feature_More
		}
		default { Mainpage }
	}
}

Function Image_Get_Apps_Package
{
	param
	(
		[Switch]$View,
		$Save
	)

	if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		$custom_array = @()
		try {
			Write-Host "   $($lang.Operable)" -ForegroundColor Green
			Get-AppxProvisionedPackage -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | ForEach-Object {
				$custom_array += [PSCustomObject]@{
					DisplayName = $_.DisplayName
					PackageName = $_.PackageName
					Version     = $_.Version
				}
			}
		} catch {
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			return
		}

		$Get_Index_Now = Image_Get_Mount_Index
		Check_Folder -chkpath $Save
		$TempSaveTo = "$($Save)\Index.$($Get_Index_Now).InBox.Apps.$(Get-Date -Format "yyyyMMddHHmmss").csv"

		Write-Host "`n   $($lang.SaveTo)"
		Write-Host "   $($TempSaveTo)" -ForegroundColor Green
		$custom_array | Export-CSV -NoType -Path $TempSaveTo

@"
	`$custom_array_Export = @()
	`$multiple_output = Import-Csv "`$(`$PSScriptRoot)\$([IO.Path]::GetFileName($TempSaveTo))" | Out-GridView -Title "$($lang.GetImageUWP)" -passthru

	if (`$null -eq `$multiple_output) {
		Write-Host "   User Cancel" -ForegroundColor Red
	} else {
		ForEach (`$item in `$multiple_output) {
			`$custom_array_Export += [PSCustomObject]@{
				DisplayName = `$item.DisplayName
				PackageName = `$item.PackageName
				Version     = `$item.Version
			}
		}

		Add-Type -AssemblyName System.Windows.Forms

		`$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
			Filter    = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
			FileName  = "Export.InBox.Apps.`$(Get-Date -Format "yyyyMMddHHmmss")"
		}

		if (`$FileBrowser.ShowDialog() -eq "OK") {
			Write-Host "`n   Save To:"
			Write-Host "   `$(`$FileBrowser.FileName)" -ForegroundColor Green
			`$custom_array_Export | Export-CSV -NoType -Path `$FileBrowser.FileName
		} else {
			Write-Host "   User Cancel" -ForegroundColor Red
		}
	}
"@ | Out-File -FilePath "$($TempSaveTo).ps1" -Encoding UTF8 -ErrorAction SilentlyContinue

		if ($View) {
			powershell -NoLogo -NonInteractive -file "$($TempSaveTo).ps1" -wait
		}
	} else {
		Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
	}
}

Function Image_Get_Detailed
{
	param
	(
		$Filename,
		[Switch]$View
	)

	Write-Host "`n   $($lang.ViewWIMFileInfo)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-host "   $($Filename)`n" -ForegroundColor Green

	if (Test-Path $Filename -PathType Leaf) {
		$custom_array = @()

		try {
			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)98" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Get-WindowsImage -ImagePath ""$($Filename)""" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}
	
			Get-WindowsImage -ImagePath $Filename -ErrorAction SilentlyContinue | ForEach-Object {
				$SetCurreltIndex = $_.ImageIndex

				if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
					Write-Host "   $($lang.Command)" -ForegroundColor Green
					Write-host "   $($lang.Developers_Mode_Location)99" -ForegroundColor Green
					Write-host "   $('-' * 80)"
					write-host "   Get-WindowsImage -ImagePath ""$($Filename)"" -index ""$($SetCurreltIndex)""" -ForegroundColor Green
					Write-host "   $('-' * 80)`n"
				}
		
				Get-WindowsImage -ImagePath $Filename -index $SetCurreltIndex -ErrorAction SilentlyContinue | ForEach-Object {
					$custom_array += [PSCustomObject]@{
						ImageIndex       = $_.ImageIndex
						ImageName        = $_.ImageName
						ImageDescription = $_.ImageDescription
						ImageSize        = $_.ImageSize
						WIMBoot          = $_.WIMBoot
						Architecture     = $_.Architecture
						Hal              = $_.Hal
						Version          = $_.Version
						SPBuild          = $_.SPBuild
						SPLevel          = $_.SPLevel
						EditionId        = $_.EditionId
						InstallationType = $_.InstallationType
						ProductType      = $_.ProductType
						ProductSuite     = $_.ProductSuite
						SystemRoot       = $_.SystemRoot
						DirectoryCount   = $_.DirectoryCount
						FileCount        = $_.FileCount
						CreatedTime      = $_.CreatedTime
						ModifiedTime     = $_.ModifiedTime
						Languages        = $_.Languages
					}
				}
			}
		} catch {
			Write-Host "   $($lang.SelectFromError)" -ForegroundColor Red
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			return
		}

		$Get_Index_Now = Image_Get_Mount_Index
		Check_Folder -chkpath "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report"
		$TempSaveTo = "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Report\Index.$($Get_Index_Now).Image.$(Get-Date -Format "yyyyMMddHHmmss").csv"

		Write-Host "`n   $($lang.SaveTo)"
		Write-Host "   $($TempSaveTo)" -ForegroundColor Green
		$custom_array | Export-CSV -NoType -Path $TempSaveTo

@"
	`$custom_array_Export = @()
	`$multiple_output = Import-Csv "`$(`$PSScriptRoot)\$([IO.Path]::GetFileName($TempSaveTo))" | Out-GridView -Title "$($lang.ViewWIMFileInfo): $($Filename)" -passthru

	if (`$null -eq `$multiple_output) {
		Write-Host "   User Cancel" -ForegroundColor Red
	} else {
		ForEach (`$item in `$multiple_output) {
			`$custom_array_Export += [PSCustomObject]@{
				ImageIndex       = `$item.ImageIndex
				ImageName        = `$item.ImageName
				ImageDescription = `$item.ImageDescription
				ImageSize        = `$item.ImageSize
				WIMBoot          = `$item.WIMBoot
				Architecture     = `$item.Architecture
				Hal              = `$item.Hal
				Version          = `$item.Version
				SPBuild          = `$item.SPBuild
				SPLevel          = `$item.SPLevel
				EditionId        = `$item.EditionId
				InstallationType = `$item.InstallationType
				ProductType      = `$item.ProductType
				ProductSuite     = `$item.ProductSuite
				SystemRoot       = `$item.SystemRoot
				DirectoryCount   = `$item.DirectoryCount
				FileCount        = `$item.FileCount
				CreatedTime      = `$item.CreatedTime
				ModifiedTime     = `$item.ModifiedTime
				Languages        = `$item.Languages
			}
		}

		Add-Type -AssemblyName System.Windows.Forms

		`$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
			Filter    = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
			FileName  = "Export.Image.`$(Get-Date -Format "yyyyMMddHHmmss")"
		}

		if (`$FileBrowser.ShowDialog() -eq "OK") {
			Write-Host "`n   Save To:"
			Write-Host "   `$(`$FileBrowser.FileName)" -ForegroundColor Green
			`$custom_array_Export | Export-CSV -NoType -Path `$FileBrowser.FileName
		} else {
			Write-Host "   User Cancel" -ForegroundColor Red
		}
	}
"@ | Out-File -FilePath "$($TempSaveTo).ps1" -Encoding UTF8 -ErrorAction SilentlyContinue

		if ($View) {
			powershell -NoLogo -NonInteractive -file "$($TempSaveTo).ps1" -wait
		}
	} else {
		Write-Host "   $($lang.NoInstallImage)"
		Write-host "   $($Filename)" -ForegroundColor Red
	}
}

Function Image_Get_Components_Package
{
	param
	(
		[Switch]$View,
		$Save
	)

	$custom_array = @()
	if (Test-Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -PathType Container) {
		try {
			Get-WindowsPackage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Get.log" -Path "$($Global:Mount_To_Route)\$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" | ForEach-Object {
				$custom_array += [PSCustomObject]@{
					PackageName  = $_.PackageName
					PackageState = $_.PackageState
					ReleaseType  = $_.ReleaseType
					InstallTime  = $_.InstallTime
				}
			}

			Write-Host "   $($lang.Operable)" -ForegroundColor Green
		} catch {
			Write-Host "   $($_)" -ForegroundColor Yellow
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			return
		}

		$Get_Index_Now = Image_Get_Mount_Index
		Check_Folder -chkpath $Save
		$TempSaveTo = "$($Save)\Index.$($Get_Index_Now).Components.$(Get-Date -Format "yyyyMMddHHmmss").csv"

		Write-Host "`n   $($lang.SaveTo)"
		Write-Host "   $($TempSaveTo)" -ForegroundColor Green
		$custom_array | Export-CSV -NoType -Path $TempSaveTo

@"
	`$custom_array_Export = @()
	`$multiple_output = Import-Csv "`$(`$PSScriptRoot)\$([IO.Path]::GetFileName($TempSaveTo))" | Out-GridView -Title "$($lang.GetImagePackage)" -passthru

	if (`$null -eq `$multiple_output) {
		Write-Host "   User Cancel" -ForegroundColor Red
	} else {
		ForEach (`$item in `$multiple_output) {
			`$custom_array_Export += [PSCustomObject]@{
				PackageName  = `$item.PackageName
				PackageState = `$item.PackageState
				ReleaseType  = `$item.ReleaseType
				InstallTime  = `$item.InstallTime
			}
		}

		Add-Type -AssemblyName System.Windows.Forms

		`$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
			Filter    = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
			FileName  = "Export_Package_`$(Get-Date -Format "yyyyMMddHHmmss")"
		}

		if (`$FileBrowser.ShowDialog() -eq "OK") {
			Write-Host "`n   Save To:"
			Write-Host "   `$(`$FileBrowser.FileName)" -ForegroundColor Green
			`$custom_array_Export | Export-CSV -NoType -Path `$FileBrowser.FileName
		} else {
			Write-Host "   User Cancel" -ForegroundColor Red
		}
	}
"@ | Out-File -FilePath "$($TempSaveTo).ps1" -Encoding UTF8 -ErrorAction SilentlyContinue

		if ($View) {
			powershell -NoLogo -NonInteractive -file "$($TempSaveTo).ps1" -wait
		}
	} else {
		Write-host "   $($lang.Mounted_Status)" -ForegroundColor Yellow
		Write-Host "   $($lang.NotMounted)`n" -ForegroundColor Red
	}
}