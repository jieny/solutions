﻿<#
	.Personalized desktop right click
	.个性化桌面右键
#>
Function Personalise
{
	param
	(
		[switch]$Add,
		[switch]$Del,
		[switch]$Hide
	)

	Write-Host "   $($lang.DesktopMenu)" -ForegroundColor Green
	if ($Del) {
		Write-Host "   $($lang.Delete)".PadRight(28) -NoNewline
		Remove-Item -Path "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
		Write-Host "   $($lang.Done)`n" -ForegroundColor Green
	}

	if ($Add) {
		Write-Host "   $($lang.AddTo)".PadRight(28) -NoNewline
		$IconFolder = Convert-Path -Path "$($PSScriptRoot)\..\..\..\.." -ErrorAction SilentlyContinue
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel" -force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel\command" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\MainPanel.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel" -Name "MUIVerb" -Value "$((Get-Module -Name Engine).Author)'s Solutions" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).MainPanel\command" -Name '(default)' -Value "powershell.exe -Command ""Start-Process 'Powershell.exe' -Argument '-File ""$((Convert-Path -Path "$($PSScriptRoot)\..\..\..\..\Engine.ps1" -ErrorAction SilentlyContinue))""' -Verb RunAs""" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir" -force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir\command" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\Engine.Gift.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir" -Name "MUIVerb" -Value $($lang.Location) -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Dir\command" -Name '(default)' -Value "explorer $($Global:UniqueMainFolder)" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg" -force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg\command" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\FirstExperience.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg" -Name "MUIVerb" -Value $($lang.FirstDeployment) -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Reg\command" -Name '(default)' -Value "powershell.exe -Command ""Start-Process 'Powershell.exe' -Argument '-File ""$((Convert-Path -Path "$($PSScriptRoot)\..\..\..\..\Engine.ps1" -ErrorAction SilentlyContinue))"" -Functions \""FirstExperience -Quit\""' -Verb RunAs""" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update" -force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update\command" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\update.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update" -Name "MUIVerb" -Value $($lang.ChkUpdate) -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).Update\command" -Name '(default)' -Value "powershell.exe -Command ""Start-Process 'Powershell.exe' -Argument '-File ""$((Convert-Path -Path "$($PSScriptRoot)\..\..\..\..\Engine.ps1" -ErrorAction SilentlyContinue))"" -Functions \""Update -Quit\""' -Verb RunAs""" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About" -force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About\command" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\about.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About" -Name "MUIVerb" -Value $($lang.About) -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\$((Get-Module -Name Engine).Author).About\command" -Name '(default)' -Value "explorer ""$((Get-Module -Name Engine).HelpInfoURI)/go/os""" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-Item "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name "MUIVerb" -Value "$((Get-Module -Name Engine).Author)'s Solutions" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name 'Icon' -Value "$($IconFolder)\Assets\icons\Engine.ico" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name "SeparatorAfter" -Value "" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name "Position" -Value 'Top' -PropertyType String -Force -ea SilentlyContinue | Out-Null

		if ($Hide) {
			New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name "Extended" -Value '' -PropertyType String -Force -ea SilentlyContinue | Out-Null
		}

		New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\Background\shell\$((Get-Module -Name Engine).Author)" -Name 'SubCommands' -Value "$((Get-Module -Name Engine).Author).MainPanel;$((Get-Module -Name Engine).Author).Dir;|;$((Get-Module -Name Engine).Author).Update;$((Get-Module -Name Engine).Author).Reg;|;$((Get-Module -Name Engine).Author).About;" -PropertyType String -Force -ea SilentlyContinue | Out-Null
		Write-Host "   $($lang.Done)`n" -ForegroundColor Green
	}
}