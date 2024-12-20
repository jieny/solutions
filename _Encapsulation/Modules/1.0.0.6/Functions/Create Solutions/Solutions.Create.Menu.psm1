﻿<#
	.Menu: Language
	.菜单：语言
#>
Function Solutions_Menu
{
	if (-not $Global:EventQueueMode) {
		Logo -Title $lang.Solution
		Write-Host "   $($lang.Dashboard)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		Write-Host "   $($lang.MountImageTo): " -NoNewline
		if (Test-Path -Path $Global:Mount_To_Route -PathType Container) {
			Write-Host $Global:Mount_To_Route -ForegroundColor Green
		} else {
			Write-Host $Global:Mount_To_Route -ForegroundColor Yellow
		}

		Write-Host "   $($lang.MainImageFolder): " -NoNewline
		if (Test-Path -Path $Global:Image_source -PathType Container) {
			Write-Host $Global:Image_source -ForegroundColor Green
		} else {
			Write-Host $Global:Image_source -ForegroundColor Red
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.NoInstallImage)" -ForegroundColor Red

			ToWait -wait 2
			Solutions_Menu
		}

		Image_Get_Mount_Status
	}

	Write-Host "`n   $($lang.Solution)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-Host "      C   $($lang.IsCreate)" -ForegroundColor Green

	Write-Host "`n   $($Global:Image_source)" -ForegroundColor Yellow

	$TestImageSourcesPath = Join-Path -Path $Global:Image_source -ChildPath "Sources\`$OEM$" -ErrorAction SilentlyContinue
	if (Test-Path -Path $TestImageSourcesPath -PathType Container) {
		Write-Host "      1   $($lang.Del): " -NoNewline -ForegroundColor Green
		Write-host "\Sources\`$OEM$" -ForegroundColor Yellow
	} else {
		Write-Host "      1   $($lang.Del): " -NoNewline -ForegroundColor Red
		Write-host "\Sources\`$OEM$" -ForegroundColor Yellow
	}

	$TestImageSourcesPath = Join-Path -Path $Global:Image_source -ChildPath "Sources\Unattend.xml" -ErrorAction SilentlyContinue
	if (Test-Path -Path $TestImageSourcesPath -PathType leaf) {
		Write-Host "      2   $($lang.Del): " -NoNewline -ForegroundColor Green
		Write-host "\Sources\Unattend.xml" -ForegroundColor Yellow
	} else {
		Write-Host "      2   $($lang.Del): " -NoNewline -ForegroundColor Red
		Write-host "\Sources\Unattend.xml" -ForegroundColor Yellow
	}

	$TestImageSourcesPath = Join-Path -Path $Global:Image_source -ChildPath "Autounattend.xml" -ErrorAction SilentlyContinue
	if (Test-Path -Path $TestImageSourcesPath -PathType leaf) {
		Write-Host "      3   $($lang.Del): " -NoNewline -ForegroundColor Green
		Write-host "\Autounattend.xml" -ForegroundColor Yellow
	} else {
		Write-Host "      3   $($lang.Del): " -NoNewline -ForegroundColor Red
		Write-host "\Autounattend.xml" -ForegroundColor Yellow
	}

	Write-host
	if ((Test-Path -Path $(Join-Path -Path $Global:Image_source -ChildPath "Autounattend.xml" -ErrorAction SilentlyContinue) -PathType Leaf) -or
		(Test-Path -Path $(Join-Path -Path $Global:Image_source -ChildPath "Sources\Unattend.xml" -ErrorAction SilentlyContinue) -PathType Leaf) -or
		(Test-Path -Path $(Join-Path -Path $Global:Image_source -ChildPath "Sources\`$OEM$" -ErrorAction SilentlyContinue) -PathType Container))
	{
		Write-Host "      A   $($lang.EnglineDoneClearFull)" -ForegroundColor Green
	} else {
		Write-Host "      A   $($lang.EnglineDoneClearFull)" -ForegroundColor Red
	}

	if (Image_Is_Select_IAB) {
		$TestNewFolder = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount" -ErrorAction SilentlyContinue
		Write-Host "`n   $($TestNewFolder)" -ForegroundColor Yellow

		$File_Path_MainFolder = "$($TestNewFolder)\$((Get-Module -Name Solutions).Author)"
		if (Test-Path -Path $File_Path_MainFolder -PathType Container) {
			Write-Host "     11   $($lang.Del): " -NoNewline -ForegroundColor Green
			Write-host $((Get-Module -Name Solutions).Author) -ForegroundColor Yellow
		} else {
			Write-Host "     11   $($lang.Del): " -NoNewline -ForegroundColor Red
			Write-host "\$((Get-Module -Name Solutions).Author)" -ForegroundColor Yellow
		}

		$File_Path_Unattend = "$($TestNewFolder)\Windows\Panther\Unattend.xml"
		if (Test-Path -Path $File_Path_Unattend -PathType leaf) {
			Write-Host "     12   $($lang.Del): " -NoNewline -ForegroundColor Green
			Write-host "\Windows\Panther\Unattend.xml" -ForegroundColor Yellow
		} else {
			Write-Host "     12   $($lang.Del): " -NoNewline -ForegroundColor Red
			Write-host "\Windows\Panther\Unattend.xml" -ForegroundColor Yellow
		}

		$File_Path_Office = "$($TestNewFolder)\Users\Public\Desktop\Office"
		if (Test-Path -Path $File_Path_Office -PathType Container) {
			Write-Host "     13   $($lang.Del): " -NoNewline -ForegroundColor Green
			Write-host "\Users\Public\Desktop\Office" -ForegroundColor Yellow
		} else {
			Write-Host "     13   $($lang.Del): " -NoNewline -ForegroundColor Red
			Write-host "\Users\Public\Desktop\Office" -ForegroundColor Yellow
		}

		Write-host
		if ((Test-Path -Path $File_Path_MainFolder -PathType Container) -or
			(Test-Path -Path $File_Path_Unattend -PathType Leaf) -or
			(Test-Path -Path $File_Path_Office -PathType Container))
		{
			Write-Host "     AA   $($lang.EnglineDoneClearFull)" -ForegroundColor Green
		} else {
			Write-Host "     AA   $($lang.EnglineDoneClearFull)" -ForegroundColor Red
		}
	}

	switch (Read-Host "`n   $($lang.PleaseChoose)")
	{
		'c' {
			Solutions
			ToWait -wait 2
			Solutions_Menu
		}
		'1' {
			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Sources\`$OEM$" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType Container) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'2' {
			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Sources\Unattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType leaf) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'3' {
			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Autounattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType leaf) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'a' {
			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Sources\`$OEM$" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType Container) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Sources\Unattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType leaf) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			$File_Path = Join-Path -Path $Global:Image_source -ChildPath "Autounattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path -PathType leaf) {
				Remove_Tree $File_Path
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'11' {
			$File_Path_MainFolder = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\$((Get-Module -Name Solutions).Author)" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_MainFolder)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_MainFolder -PathType Container) {
				Remove_Tree $File_Path_MainFolder
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'12' {
			$File_Path_Unattend = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows\Panther\Unattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_Unattend)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_Unattend -PathType Leaf) {
				Remove_Tree $File_Path_Unattend
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'13' {
			$File_Path_Office = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Users\Public\Desktop\Office" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_Office)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_Office -PathType Container) {
				Remove_Tree $File_Path_Office
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		'aa' {
			$File_Path_MainFolder = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\$((Get-Module -Name Solutions).Author)" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_MainFolder)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_MainFolder -PathType Container) {
				Remove_Tree $File_Path_MainFolder
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			$File_Path_Unattend = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Windows\Panther\Unattend.xml" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_Unattend)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_Unattend -PathType Leaf) {
				Remove_Tree $File_Path_Unattend
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			$File_Path_Office = Join-Path -Path $Global:Mount_To_Route -ChildPath "$($Global:Primary_Key_Image.Master)\$($Global:Primary_Key_Image.ImageFileName)\Mount\Users\Public\Desktop\Office" -ErrorAction SilentlyContinue

			Write-Host "`n   $($File_Path_Office)" -ForegroundColor Yellow
			Write-host "   $('-' * 80)"
			Write-Host "   $($lang.Del)".PadRight(28) -NoNewline
			if (Test-Path -Path $File_Path_Office -PathType Container) {
				Remove_Tree $File_Path_Office
				Write-Host $lang.Done -ForegroundColor Green
			} else {
				Write-Host $lang.Failed -ForegroundColor Red
			}

			ToWait -wait 2
			Solutions_Menu
		}
		default {
			Mainpage
		}
	}
}