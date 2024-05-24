<#
	.To rebuild the image, please use ReBuild.wim as a temporary file, and the file cannot exist under any circumstances.
	.重建映像，临时文件一定请使用 ReBuild.wim，不管任何情况下，该文件都不能存在。
#>
Function Rebuild_Image_File
{
	param
	(
		$Filename
	)

	$RandomGuid = [guid]::NewGuid()

	Write-Host "`n   $($lang.Rebuilding)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"

	Write-host "   $($Filename)" -ForegroundColor Green
	if (Test-Path $Filename -PathType Leaf) {
		if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
			Write-Host "`n   $($lang.Command)" -ForegroundColor Green
			Write-host "   $($lang.Developers_Mode_Location)93" -ForegroundColor Green
			Write-host "   $('-' * 80)"
			write-host "   Get-WindowsImage -ImagePath ""$($Filename)""" -ForegroundColor Green
			Write-host "   $('-' * 80)`n"
		}

		Write-Host "`n   $($lang.AddSources)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"

		Get-WindowsImage -ImagePath $Filename -ErrorAction SilentlyContinue | ForEach-Object {
			Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
			Write-Host $_.ImageName -ForegroundColor Yellow

			Write-Host "   $($lang.MountedIndex): " -NoNewline
			Write-Host $_.ImageIndex -ForegroundColor Yellow

			Write-host ""
		}
		
		Write-Host "`n   $($lang.AddQueue)" -ForegroundColor Yellow
		Write-host "   $('-' * 80)"
		$Save_To_Temp_Folder_Path = Get_Mount_To_Temp

		Get-WindowsImage -ImagePath $Filename -ErrorAction SilentlyContinue | ForEach-Object {
			Write-Host "   $($lang.Wim_Image_Name): " -NoNewline
			Write-Host $_.ImageName -ForegroundColor Yellow

			Write-Host "   $($lang.MountedIndex): " -NoNewline
			Write-Host $_.ImageIndex -ForegroundColor Yellow

			Write-Host "   $($lang.Rebuilding)".PadRight(28) -NoNewline

			if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$((Get-Module -Name Solutions).Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
				Write-Host "`n   $($lang.Command)" -ForegroundColor Green
				Write-host "   $($lang.Developers_Mode_Location)94" -ForegroundColor Green
				Write-host "   $('-' * 80)"
				write-host "   Export-WindowsImage -SourceImagePath ""$($Filename)"" -SourceIndex ""$($_.ImageIndex)"" -DestinationImagePath ""$($Save_To_Temp_Folder_Path)\$($RandomGuid).wim"" -CompressionType max" -ForegroundColor Green
				Write-host "   $('-' * 80)`n"
			}

			try {
				Export-WindowsImage -ScratchDirectory "$(Get_Mount_To_Temp)" -LogPath "$(Get_Mount_To_Logs)\Export.log" -SourceImagePath "$($Filename)" -SourceIndex "$($_.ImageIndex)" -DestinationImagePath "$($Save_To_Temp_Folder_Path)\$($RandomGuid).wim" -CompressionType max -ErrorAction SilentlyContinue | Out-Null	
				Write-Host $lang.Done -ForegroundColor Green
			} catch {
				Write-host $lang.ConvertChk
				Write-host "   $($Filename)"
				Write-Host "   $($_)" -ForegroundColor Yellow
				Write-host "   $($lang.Inoperable)`n" -ForegroundColor Red
			}

			Write-host ""
		}

		if (Test-Path -Path "$($Save_To_Temp_Folder_Path)\$($RandomGuid).wim" -PathType Leaf) {
			Remove-Item -Path $Filename -ErrorAction SilentlyContinue
			Move-Item -Path "$($Save_To_Temp_Folder_Path)\$($RandomGuid).wim" -Destination $Filename -ErrorAction SilentlyContinue

			if (Test-Path $Filename -PathType Leaf) {
				Write-Host "   $($lang.Done)" -ForegroundColor Green
			} else {
				Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
			}
		} else {
			Write-Host "   $($lang.Inoperable)" -ForegroundColor Red
		}
	} else {
		Write-Host "   $($lang.NoInstallImage)"
		Write-host "   $($Filename)" -ForegroundColor Red
	}
}