<#
	.Language Module
	.语言模块
#>
Function Language
{
	param
	(
		[string]$Force,
		[switch]$Reset,
		[switch]$Auto
	)
	$Host.UI.RawUI.WindowTitle = "$($Global:UniqueID)'s Solutions | Choose your country or region."

	<#
		.Reset
		.重置
	#>
	if ($Reset)
	{
		$Global:IsLang = $null
	}

	<#
		.Automatic
		.自动
	#>
	if ($Auto)
	{
		LanguageChange -lang (Get-Culture).Name
		ImportModules
		return
	}

	<#
		.Mandatory use of the specified language
		.强制使用指定语言
	#>
	if (-not ([string]::IsNullOrEmpty($Force)))
	{
		LanguageChange -lang $Force
		ImportModules
		return
	}

	<#
		.Saved language
		.已保存语言
	#>
	if (([string]::IsNullOrEmpty($Global:IsLang)))
	{
		switch ((Get-Culture).Name) {
			"ja-JP" { $DefaultSelectLanguage = 1 }
			"ko-KR" { $DefaultSelectLanguage = 2 }
			"ru-RU" { $DefaultSelectLanguage = 3 }
			"zh-CN" { $DefaultSelectLanguage = 4 }
			Default { $DefaultSelectLanguage = 0 }
		}
		Clear-Host
		$eng = New-Object System.Management.Automation.Host.ChoiceDescription "&0 en-US", "eng"
		$jajp = New-Object System.Management.Automation.Host.ChoiceDescription "&1 ja-JP", "jp"
		$kokr = New-Object System.Management.Automation.Host.ChoiceDescription "&2 ko-KR", "kr"
		$ruru = New-Object System.Management.Automation.Host.ChoiceDescription "&3 ru-RU", "ru"
		$chs = New-Object System.Management.Automation.Host.ChoiceDescription "&4 zh-CN", "chs"
		$options = [System.Management.Automation.Host.ChoiceDescription[]]($eng, $jajp, $kokr, $ruru,  $chs)
		$title = '    Choose your country or region.'
		$message = "`n    North America`n[0] English ( United States )`n`n    Asia Pacific`n[1] Japanese (Japan)`n[2] Korean (Korea)`n[3] Russian (Russia)`n[4] Chinese ( Simplified, China )`n`n"
		$result = $host.ui.PromptForChoice($title, $message, $options, $DefaultSelectLanguage)
		switch ($result)
		{
			0 {
				LanguageChange -lang "en-US"
			}
			1 {
				LanguageChange -lang "ja-JP"
			}
			2 {
				LanguageChange -lang "ko-KR"
			}
			3 {
				LanguageChange -lang "ru-RU"
			}
			4 {
				LanguageChange -lang "zh-CN"
			}
			default {
				LanguageChange -lang "en-US"
			}
		}
		ImportModules
	} else {
		LanguageChange -lang $Global:IsLang
	}
}

<#
	.Change language
	.更改语言
#>
Function LanguageChange
{
	param (
		[string]$lang
	)

	if (Test-Path "$PSScriptRoot\langpacks\$lang\lang.psd1" -PathType Leaf)
	{
		$Global:IsLang = $lang
		Import-LocalizedData -BindingVariable Global:Lang -UICulture $lang -FileName "lang.psd1" -BaseDirectory "$PSScriptRoot\langpacks\$lang"
	} else {
		if (Test-Path "$PSScriptRoot\langpacks\en-US\lang.psd1" -PathType Leaf) {
			$Global:IsLang = "en-US"
			Import-LocalizedData -BindingVariable Global:Lang -UICulture $lang -FileName "lang.psd1" -BaseDirectory "$PSScriptRoot\langpacks\en-US"
		} else {
			Clear-Host
			Write-Host "`n  There is no language pack locally, it will automatically exit after 6 seconds." -ForegroundColor Red
			Start-Sleep -s 6
			exit
		}
	}
}

<#
	.Refresh all modules and languages
	.刷新所有模块和语言
#>
Function ImportModules
{
	param
	(
		[switch]$Quick
	)

	<#
		.Remove all Engine modules
		.删除所有 Engine 模块
	#>
	Get-Module -Name Engine* | Where-Object -Property Name -like "Engine*" | ForEach-Object {
		Remove-Module -Name $_.Name -Force -ErrorAction Ignore
	}

	<#
		.Import all *.psm1
		.导入所有 *.psm1
	#>
	Get-ChildItem –Path  "$PSScriptRoot\Functions" –Recurse -include "Engine*.psm1" | ForEach-Object {
		Import-Module $_.FullName -Scope Global -Force
	}

	if (-not ($Quick)) {
		Remove-Module -Name Engine -Force -ErrorAction Ignore
		Import-Module -Name $PSScriptRoot\Engine.psd1 -PassThru -Force | Out-Null
	
		Language
	}
}