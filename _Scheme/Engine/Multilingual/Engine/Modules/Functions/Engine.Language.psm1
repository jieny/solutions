<#
 .Synopsis
  Language Setting

 .Description
  Language Setting Feature Modules
#>

<#
	.Available languages
	.可用语言

	.Group type: 1. Language pack; 2. Language interface pack (LIP)
	.分组类型：1、语言包；2、语言界面包（LIP）

	https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows
#>
$AvailableLanguages = @(
	("1", "ar-SA",          "ar",              "Arabic - Saudi Arabia"),
	("1", "bg-BG",          "bg",              "Bulgarian (Bulgaria)"),
	("1", "zh-HK",          "hk",              "Chinese - Hong Kong SAR"),
	("1", "zh-CN",          "cn",              "Chinese - China"),
	("1", "zh-TW",          "tw",              "Chinese - Taiwan"),
	("1", "hr-HR",          "hr",              "Croatian (Croatia)"),
	("1", "cs-CZ",          "dz",              "Czech (Czech Republic)"),
	("1", "da-DK",          "dk",              "Danish (Denmark)"),
	("1", "nl-NL",          "nl",              "Dutch - Netherlands"),
	("1", "en-US",          "en",              "English - United States"),
	("1", "en-GB",          "gb",              "English - Great Britain"),
	("1", "et-EE",          "ee",              "Estonian (Estonia)"),
	("1", "fi-FI",          "fi",              "Finnish (Finland)"),
	("1", "fr-CA",          "ca",              "French - Canada"),
	("1", "fr-FR",          "fr",              "French - France"),
	("1", "de-DE",          "de",              "German - Germany"),
	("1", "el-GR",          "gr",              "Greek (Greece)"),
	("1", "he-IL",          "il",              "Hebrew (Israel)"),
	("1", "hu-HU",          "hu",              "Hungarian (Hungary)"),
	("1", "it-IT",          "it",              "Italian - Italy"),
	("1", "ja-JP",          "jp",              "Japanese (Japan)"),
	("1", "ko-KR",          "kr",              "Korean (Korea)"),
	("1", "lv-LV",          "lv",              "Latvian (Latvia)"),
	("1", "lt-LT",          "lt",              "Lithuanian (Lithuania)"),
	("1", "nb-NO",          "no",              "Norwegian (Bokm?l) (Norway)"),
	("1", "pl-PL",          "pl",              "Polish (Poland)"),
	("1", "pt-BR",          "br",              "Portuguese - Brazil"),
	("1", "pt-PT",          "pt",              "Portuguese - Portugal"),
	("1", "ro-RO",          "ro",              "Romanian (Romania)"),
	("1", "ru-RU",          "ru",              "Russian (Russia)"),
	("1", "sk-SK",          "sk",              "Slovak (Slovakia)"),
	("1", "sl-SI",          "si",              "Slovenian (Slovenia)"),
	("1", "es-MX",          "mx",              "Spanish (Mexico)"),
	("1", "es-ES",          "es-ES",           "Spanish (Castilian)"),
	("1", "sv-SE",          "se",              "Swedish (Sweden)"),
	("1", "th-TH",          "th",              "Thai (Thailand)"),
	("1", "tr-TR",          "tr",              "Turkish (Turkey)"),
	("1", "uk-UA",          "ua",              "Ukrainian (Ukraine)"),
	("2", "af-za",          "af",              "Afrikaans (South Africa)"),
	("2", "am-et",          "am-et",           "Amharic (Ethiopia)	"),
	("2", "as-in",          "as-in",           "Assamese (India)"),
	("2", "az-latn-az",     "az-latn-az",      "Azerbaijan"),
	("2", "be-by",          "be-by",           "Belarusian (Belarus)"),
	("2", "bn-bd",          "bn-bd",           "Bangla (Bangladesh)"),
	("2", "bn-in",          "bn-in",           "Bangla (India)"),
	("2", "bs-latn-ba",     "bs-latn-ba",      "Bosnian (Latin)"),
	("2", "ca-es",          "ca-es",           "Catalan (Spain)"),
	("2", "ca-es-valencia", "ca-es-valencia",  "Valencian"),
	("2", "chr-cher-us",    "chr-cher-us",     "Cherokee"),
	("2", "cy-gb",          "cy",              "Welsh (United Kingdom)"),
	("2", "eu-es",          "eu-es",           "Basque (Spain)"),
	("2", "fa-ir",          "fa",              "Farsi (Iran)"),
	("2", "fil-ph",         "fil-ph",          "Filipino"),
	("2", "ga-ie",          "ga-ie",           "Irish (Ireland)"),
	("2", "gd-gb",          "gd-gb",           "Scottish Gaelic	"),
	("2", "gl-es",          "gl",              "Galician (Spain)"),
	("2", "gu-in",          "gu",              "Gujarati (India)"),
	("2", "ha-latn-ng",     "ha-latn-ng",      "Hausa (Latin, Nigeria)"),
	("2", "hi-in",          "hi",              "Hindi (India)"),
	("2", "hy-am",          "hy",              "Armenian (Armenia)"),
	("2", "id-id",          "id",              "Indonesian (Indonesia)"),
	("2", "ig-ng",          "ig-ng",           "Igbo (Nigeria)"),
	("2", "is-is",          "is",              "Icelandic (Iceland)"),
	("2", "ka-ge",          "ka",              "Georgian (Georgia)"),
	("2", "kk-kz",          "kk",              "Kazakh (Kazakhstan)"),
	("2", "km-kh",          "km-kh",           "Khmer (Cambodia)"),
	("2", "kn-in",          "kn",              "Kannada (India)"),
	("2", "kok-in",         "kok",             "Konkani (India)"),
	("2", "ku-arab-iq",     "ku-arab-iq",      "Central Kurdish"),
	("2", "ky-kg",          "ky",              "Kyrgyz (Kyrgyzstan)"),
	("2", "lb-lu",          "lb-lu",           "Luxembourgish (Luxembourg)"),
	("2", "lo-la",          "lo-la",           "Lao (Laos)"),
	("2", "mi-nz",          "mi",              "Maori (New Zealand)"),
	("2", "mk-mk",          "mk",              "FYRO Macedonian"),
	("2", "ml-in",          "ml-in",           "Malayalam (India)"),
	("2", "mn-mn",          "mn",              "Mongolian (Mongolia)"),
	("2", "mr-in",          "mr",              "Marathi (India)"),
	("2", "ms-my",          "ms-my",           "Malay (Malaysia)"),
	("2", "mt-mt",          "mt",              "Maltese (Malta)"),
	("2", "ne-np",          "ne-np",           "Nepali (Federal Democratic Republic of Nepal)"),
	("2", "nn-no",          "nn-no",           "Norwegian (Nynorsk) (Norway)"),
	("2", "nso-za",         "nso-za",          "Sesotho sa Leboa (South Africa)"),
	("2", "or-in",          "or-in",           "Odia (India)"),
	("2", "pa-arab-pk",     "pa-arab-pk",      "pa-arab-pk"),
	("2", "pa-in",          "pa",              "Punjabi (India)"),
	("2", "prs-af",         "prs-af",          "Dari"),
	("2", "quc-latn-gt",    "quc-latn-gt",     "K'iche' (Guatemala)"),
	("2", "quz-pe",         "quz-pe",          "Quechua (Peru)"),
	("2", "rw-rw",          "rw-rw",           "Kinyarwanda"),
	("2", "sd-arab-pk",     "sd-arab-pk",      "Sindhi (Arabic)"),
	("2", "si-lk",          "si-lk",           "Sinhala (Sri Lanka)"),
	("2", "sq-al",          "sq",              "Albanian (Albania)"),
	("2", "sr-cyrl-ba",     "sr-cyrl-ba",      "Serbian (Cyrillic, Bosnia and Herzegovina)"),
	("2", "sr-cyrl-rs",     "sr-cyrl-rs",      "Serbian (Cyrillic, Serbia)"),
	("2", "sr-latn-rs",     "sr-latn-rs",      "Serbian (Latin, Serbia)"),
	("2", "sw-ke",          "sw-ke",           "Kiswahili (Kenya)"),
	("2", "ta-in",          "ta-in",           "Tamil (India)"),
	("2", "te-in",          "te-in",           "Telugu (India)"),
	("2", "tg-cyrl-tj",     "tg-cyrl-tj",      "Tajik (Cyrillic)"),
	("2", "ti-et",          "ti-et",           "Tigrinya"),
	("2", "tk-tm",          "tk-tm",           "Turkmen"),
	("2", "tn-za",          "tn-za",           "Tswana (South Africa)"),
	("2", "tt-ru",          "tt-ru",           "Tatar (Russia)"),
	("2", "ug-cn",          "ug-cn",           "Uyghur"),
	("2", "ur-pk",          "ur-pk",           "Urdu (Islamic Republic of Pakistan)"),
	("2", "uz-latn-uz",     "uz-latn-uz",      "Uzbek (Latin)"),
	("2", "vi-vn",          "vi-vn",           "Vietnamese (Viet Nam)"),
	("2", "wo-sn",          "wo-sn",           "Wolof"),
	("2", "xh-za",          "xh-za",           "Xhosa (South Africa)"),
	("2", "yo-ng",          "yo-ng",           "Yoruba (Nigeria)"),
	("2", "zu-za",          "zu-za",           "Zulu (South Africa)")
)

<#
	.Set system language settings
	.设置系统语言设置
#>
Function LanguageSetting
{
	Write-Host "`n   $($lang.SettingLangAndKeyboard)"

	<#
		.Current UI main language
		.当前 UI 主语言
	#>
	$Global:UILanguage = (Get-Culture).Name

	<#
		.Reset the array and initialize the language
		.重置数组和初始化语言
	#>
	$Global:GroupLanguage = @()
	$Global:GroupLanguage = New-WinUserLanguageList $Global:UILanguage
	$Global:GroupLanguage[0].InputMethodTips.Clear()

	<#
		.Add current preferred language
		.添加当前首选语言
	#>
	Write-Host "   - $($lang.SetLang)$($Global:UILanguage)" -ForegroundColor Green
	ProcessLanguage -NewLang $Global:UILanguage

	<#
		.Specialized processing: monolingual, and non-monolingual
		.特殊化处理：单语言、和非单语
	#>
	$FlagsSingleLanguage = $False
	if ((Get-WindowsEdition -online).Edition -like "*Single*") {
		$FlagsSingleLanguage = $True
	}

	if ($FlagsSingleLanguage) {
		<#
			.Processing: Single language
			.处理：单语版
		#>
		if ($Global:UILanguage -ne "en-US" ) {
			ProcessLanguage -NewLang "en-US"
		}
	} else {
		<#
			.Processing: other unrestricted versions
			.处理：其它不受限制版本
		#>
		<#
			.Get the languages installed on the system
			.获取系统已安装的语言
		#>
		foreach ($item in (Get-WmiObject -Class Win32_OperatingSystem).MUILanguages) {
			if ($Global:UILanguage -ne $item) {
				ProcessLanguage -NewLang $item
			}
		}
	}

	<#
		.Execute add language
		.执行添加语言
	#>
	Set-WinUserLanguageList $Global:GroupLanguage -Force

	<#
		.Set the default keyboard: English
		.设置默认键盘：英文
	#>
	Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"

	<#
		.Set regional codes to match known languages to prevent illegal matches.
		.设置区域编码，根据已知语言匹配，防止非法匹配。
	#>
	for ($i=0; $i -lt $AvailableLanguages.Count; $i++) {
		$LanguageName = $AvailableLanguages[$i][1]

		if (Test-Path -Path "$PSScriptRoot\..\..\Deploy\Region\$($LanguageName)") {
			Set-WinSystemLocale $LanguageName
			break
		}
	}

	<#
		.Setting time
		.设置时间
	#>
#	Set-TimeZone -Id "China Standard Time" -PassThru | Out-Null

	<#
		.Beta: Use Unicode UTF-8 for worldwide language support
	#>
	if (Test-Path "$PSScriptRoot\..\..\Deploy\UseUTF8" -PathType Leaf) {
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage" -Name "ACP" -Type String -Value 65001 -ErrorAction SilentlyContinue | Out-Null
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage" -Name "OEMCP" -Type String -Value 65001 -ErrorAction SilentlyContinue | Out-Null
		Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage" -Name "MACCP" -Type String -Value 65001 -ErrorAction SilentlyContinue | Out-Null
	}
}

<#
	.Specialize different languages, specify and add hidden input methods
	.特殊化处理不同的语言，指定添加隐藏的输入法

     https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-input-locales-for-windows-language-packs	
#>
Function ProcessLanguage {
	param (
		$NewLang
	)

	<#
		.Set judgment language flag
		.设置判断语言标记
	#>
	$FlagsNewLanguage = $False

	if ($NewLang -eq "zh-CN" ) {
		$FlagsNewLanguage = $True
		Write-Host "   - $($lang.KeyboardSequence)$($lang.Pinyi)"
		$Global:GroupLanguage[0].InputMethodTips.add('0804:{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}{FA550B04-5AD7-411f-A5AC-CA038EC515D7}')      # Pinyin

		Write-Host "   - $($lang.KeyboardSequence)$($lang.Wubi)"
		$Global:GroupLanguage[0].InputMethodTips.add('0804:{6a498709-e00b-4c45-a018-8f9e4081ae40}{82590C13-F4DD-44f4-BA1D-8667246FDF8E}')      # Wubi
	}

	<#
		.Unmatched languages, add directly
		.未匹配的语言，直接添加
	#>
	if (-not ($FlagsNewLanguage)) {
		$Global:GroupLanguage.Add($NewLang)
	}
}

Export-ModuleMember -variable "AvailableLanguages"
Export-ModuleMember -Function "LanguageSetting"
Export-ModuleMember -Function "ProcessLanguage"