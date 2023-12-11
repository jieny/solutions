<#
	.Language packs, search for file types
	.语言包，搜索文件类型
#>
$Global:Search_Language_File_Type = @(
	"*.esd"
	"*.cab"
)

$Global:Search_File_Order = @{
	<#
		.字体
	#>
	Fonts = @(
		"*LanguageFeatures-Fonts*"
		"*WinPE-FontSupport*"
	)

	<#
		.基本
	#>
	Basic = @(
		<#
			.新版文件名称
		#>
		"*Windows-Server-Language-Pack*"
		"*Windows-Client-Language-Pack*"
		"*Windows-Lip-Language-Pack*"

		<#
			.过时的，旧版
		#>
		"*LanguageFeatures-Basic*"
		"*WinPE-Setup*"
		"*lp.cab*"
	)

	<#
		.特定包
		 https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/features-on-demand-language-fod?view=windows-11#other-region-specific-requirements
	#>
	RegionSpecific = @(
		"*InternationalFeatures*"
	)

	<#
		.光学字符识别
	#>
	OCR = @(
		"*LanguageFeatures-OCR*"
	)

	<#
		.手写内容识别
	#>
	Handwriting = @(
		"*LanguageFeatures-Handwriting*"
	)

	<#
		.文本转语音
	#>
	TextToSpeech = @(
		"*LanguageFeatures-TextToSpeech*"
	)

	<#
		.语音识别
	#>
	Speech = @(
		"*LanguageFeatures-Speech*"
	)

	<#
		.按需功能
	#>
	Features_On_Demand = @(
		<#
			.Install
		#>
		"*InternetExplorer*"
		"*MSPaint*"
		"*Notepad*"
		"*MediaPlayer*"
		"*PowerShell*ISE*"
		"*StepsRecorder*"
		"*SnippingTool*"
		"*WMIC*"
		"*WordPad*"
		"*Printing-WFS*"
		"*Printing-PMCPPC*"
		"*Telnet-Client*"
		"*TFTP-Client*"
		"*VBSCRIPT*"
		"*WinOcr-FOD-Package*"
		"*ProjFS-OptionalFeature-FOD-Package*"

			<#	
				.WinRE
			#>
			"*winpe-appxdeployment*"
			"*winpe-appxpackaging*"
			"*winpe-storagewmi*"
			"*winpe-wifi*"
			"*winpe-windowsupdate*"
			"*winpe-rejuv*"
			"*winpe-opcservices*"
			"*winpe-hta*"

		<#
			.Boot
		#>
		"*winpe-securestartup*"
		"*winpe-atbroker*"
		"*winpe-audiocore*"
		"*winpe-audiodrivers*"
		"*winpe-enhancedstorage*"
		"*winpe-narrator*"
		"*winpe-scripting*"
		"*winpe-speech-tts*"
		"*winpe-srh*"
		"*winpe-srt*"
		"*winpe-wds*"
		"*winpe-wmi*"
	)

	<#
		.零售演示体验
	#>
	Retail = @(
		"*RetailDemo*"
	)
}

<#
	.搜索机制

	{Lang}  = 语言标记
	{ARCH}  = 架构：原始 amd64
	{ARCHC} = 架构：转换后的结果：x64

	.排序：内核、系统类型、boot 或 Install、所需文件、文件路径
#>
$Global:Preconfigured_Rule_Language = @(
	#region Windows Server vNext
	@{
		GUID        = "03adbaf0-80f0-4308-a660-2d9d065b181f"
		Author      = 'Yi'
		Copyright   = 'FengYi, Inc. All rights reserved.'
		Name        = "Windows Server vNext"
		Description = ""
		ISO         = @(
			@{
				ISO = "Windows_InsiderPreview_Server_vNext_en-us_26010.iso";
				CRCSHA = @{
					SHA256 = "";
				}
			}
		)
		InboxApps   = @{
			ISO = @()
			SN = @{}
			Edition = @()
			Rule = @()
		}
		Language = @{
			ISO = @(
				@{
					ISO = "Microsoft_Server_InsiderPreview_LangPack_FOD_26010.iso";
					CRCSHA = @{
						SHA256 = "";
					}
				}
			)
			Rule = @(
				@{
					Group = "Boot;Boot;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WINPE-SETUP-Server_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
				@{
					Group = "Install;Install;"
					Rule = @(
						@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Server-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";      Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-SnippingTool-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";               Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-ProjFS-OptionalFeature-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Telnet-Client-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-TFTP-Client-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-VBSCRIPT-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-VBSCRIPT-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WinOcr-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                      Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WinOcr-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                      Structure = "LanguagesAndOptionalFeatures"; }
					)
				}
				@{
					Group = "Install;WinRE;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-appxdeployment_{Lang}.cab";  Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-windowsupdate_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
			)
		}
	}
	#endregion

	#region Windows Server vNext
	@{
		GUID        = "ecf6ce99-0dff-439d-925e-e30fcdacfb72"
		Author      = 'Yi'
		Copyright   = 'FengYi, Inc. All rights reserved.'
		Name        = "Windows Server 23H2"
		Description = ""
		ISO         = @(
			@{
				ISO = "en-us_windows_server_version_23h2_x64_dvd_f8fdfa10.iso";
				CRCSHA = @{
					SHA256  = "3be14b7ca09408c8e959e5cbc008918ef2874c5003c5893ad1706c8c07df3af9"
					SHA512  = "d5e6bbc0baa82f8eccada10ae92addfe4f87c9dc76c9b2dc65272de88c330a422a2850c0426648e8343779fcbc8f44847526c05ed9538852110f6def952e0ba2"
				}
			}
		)
		InboxApps   = @{
			ISO = @(
				@{
					ISO = "";
					CRCSHA = @{
						SHA256 = "";
						SHA512 = "";
					}
				}
			)
			SN = @{}
			Edition = @()
			Rule = @()
		}
		Language = @{
			ISO = @(
				@{
					ISO = "mul_languages_and_optional_features_for_windows_server_version_23h2_x64_dvd_f49e7fd8.iso";
					CRCSHA = @{
						SHA256  = "800ed215d6b06b6831acd17c5e7c60c90d3b38a5e84cafd8018c9f9a77bc6641"
						SHA512  = "68eff849c34fabfee377bcacebc92c6b21fb7671929cb68a39d0ae3cc55d8a18196d708d104f2c84d43cb500a983f17f6544767cc4662779a1c0e6ca89467137"
					}
				}
			)
			Rule = @(
				@{
					Group = "Boot;Boot;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WINPE-SETUP-Server_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
				@{
					Group = "Install;Install;"
					Rule = @(
						@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Server-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";      Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-SnippingTool-FoD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";               Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-ProjFS-OptionalFeature-FOD-Package-{ARCH}-{Lang}.cab";                  Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-Telnet-Client-FOD-Package-{ARCH}-{Lang}.cab";                           Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-TFTP-Client-FOD-Package-{ARCH}-{Lang}.cab";                             Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-VBSCRIPT-FoD-Package-amd64-{Lang}.cab";                                 Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-VBSCRIPT-FoD-Package-wow64-{Lang}.cab";                                 Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-WinOcr-FOD-Package-amd64-{Lang}.cab";                                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "cabs_Microsoft-Windows-WinOcr-FOD-Package-wow64-{Lang}.cab";                                   Structure = "LanguagesAndOptionalFeatures"; }
					)
				}
				@{
					Group = "Install;WinRE;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-appxdeployment_{Lang}.cab";  Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-windowsupdate_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
			)
		}
	}
	#endregion

	#region Windows Server 2022
	@{
		GUID        = "a70389a7-bb7b-4774-91c7-2507c1472db0"
		Author      = 'Yi'
		Copyright   = 'FengYi, Inc. All rights reserved.'
		Name        = "Windows Server 2022"
		Description = ""
		ISO         = @(
			@{
				ISO = "en-us_windows_server_2022_x64_dvd_620d7eac.iso";
				CRCSHA = @{
					SHA256 = "5a077ee2a95976ef9f3623eb4040e25cdf7f8f01dee3b8165a32a7626f39f025";
				}
			}
			@{
				ISO = "cs-cz_windows_server_2022_x64_dvd_9cc09859.iso";
				CRCSHA = @{
					SHA256 = "45474f5a5ebdb3ead58c61aae6e24ecaef00996f263dffd2b4a5174f0f5e71a7";
				}
			}
			@{
				ISO = "de-de_windows_server_2022_x64_dvd_e2c1874e.iso";
				CRCSHA = @{
					SHA256 = "f04ae8464715d1cb00dd5408000f8631d0059ec719f64def25499eeffb4bbfa4";
				}
			}
			@{
				ISO = "es-es_windows_server_2022_x64_dvd_c25dea55.iso";
				CRCSHA = @{
					SHA256 = "5dce7b7d3457b3019e28edad8b4849fa12f9764a4bd6b524a80ed1c93ed6d3a8";
				}
			}
			@{
				ISO = "fr-fr_windows_server_2022_x64_dvd_9f7d1adb.iso";
				CRCSHA = @{
					SHA256 = "b9d23f781b5bdee592d337a733d324f6383cd1616b9ab3e88bc0991f3d8670de";
				}
			}
			@{
				ISO = "hu-hu_windows_server_2022_x64_dvd_d7eb4371.iso";
				CRCSHA = @{
					SHA256 = "864ac8749b16fb6368866adc3cea2b5c4d06a6638368bac06eb8b626f45df280";
				}
			}
			@{
				ISO = "it-it_windows_server_2022_x64_dvd_2ef5266d.iso";
				CRCSHA = @{
					SHA256 = "324d87f5211461dcb49a4bc1e78305ac0b8895ec4fcd28e1305d54f5e50cafac";
				}
			}
			@{
				ISO = "ja-jp_windows_server_2022_x64_dvd_d49acd0d.iso";
				CRCSHA = @{
					SHA256 = "d3ebef7670de39fb370da1b352046c9975a7765a6b19eae50632838d3d28635e";
				}
			}
			@{
				ISO = "ko-kr_windows_server_2022_x64_dvd_c14a04ba.iso";
				CRCSHA = @{
					SHA256 = "ec9b4487a8e60e2eb0d28eb175f60ed7a968dde383fe4a2a31e3023086422dd4";
				}
			}
			@{
				ISO = "nl-nl_windows_server_2022_x64_dvd_1421617b.iso";
				CRCSHA = @{
					SHA256 = "225d17ca91fdbb97dc79b35945586170429d8c8a0e61b590a5231f080290489d";
				}
			}
			@{
				ISO = "pl-pl_windows_server_2022_x64_dvd_ac6af29a.iso";
				CRCSHA = @{
					SHA256 = "81542db3227302d40d3fa38374773e856dc750a741bb5955549c42c401aba637";
				}
			}
			@{
				ISO = "pt-br_windows_server_2022_x64_dvd_b873861f.iso";
				CRCSHA = @{
					SHA256 = "eeb6fb306cfd9a15d234d2d80a37541eb29935f1e972c45a3a0e950b73d58f49";
				}
			}
			@{
				ISO = "pt-pt_windows_server_2022_x64_dvd_39cc8179.iso";
				CRCSHA = @{
					SHA256 = "71e23e54ce35a278e0c3eee60d0173aea744da8a356d4985b0721f3ffdf2d197";
				}
			}
			@{
				ISO = "ru-ru_windows_server_2022_x64_dvd_d8fd3d54.iso";
				CRCSHA = @{
					SHA256 = "3307a5b8ed5ca0688a44e9bc64d536a291b8d161b3e8c5e3616705b64ee4657c";
				}
			}
			@{
				ISO = "sv-se_windows_server_2022_x64_dvd_1b669ce4.iso";
				CRCSHA = @{
					SHA256 = "5462ed1435ba81374a42f97ebcb231250f4d9c9a9f9cca0550deb4e041e0c7ba";
				}
			}
			@{
				ISO = "tr-tr_windows_server_2022_x64_dvd_266ef676.iso";
				CRCSHA = @{
					SHA256 = "10f322d2276066e9640080e216b138b02d26ce27867b0b68bd955c7c185f8221";
				}
			}
			@{
				ISO = "zh-cn_windows_server_2022_x64_dvd_6c73507d.iso";
				CRCSHA = @{
					SHA256 = "e77bb4618182d1e5d0b39da7e72354f4167ebb859428e7482587dd5a2a72f599";
				}
			}
			@{
				ISO = "zh-tw_windows_server_2022_x64_dvd_02ed5775.iso";
				CRCSHA = @{
					SHA256 = "b75af547ea7a9b2e739e52b9e1cec56e6069f1d934896920e2941881f9e46be6";
				}
			}
		)
		InboxApps   = @{
			ISO = @()
			SN = @{
				Edition = @()
			}
			Edition = @(
				@{
					Name = @()
					Apps = @()
				}
			)
			Rule = @()
		}
		Language = @{
			ISO = @(
				@{
					ISO = "https://software-download.microsoft.com/download/sg/20348.1.210507-1500.fe_release_amd64fre_SERVER_LOF_PACKAGES_OEM.iso";
					CRCSHA = @{
						SHA256 = "";
					}
				}
			)
			Rule = @(
				@{
					Group = "Boot;Boot;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WinPE-Setup_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "WINPE-SETUP-Server_{Lang}.CAB";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
				@{
					Group = "Install;install;"
					Rule = @(
						@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Server-Language-Pack_{ARCHC}_{Lang}.cab";                                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Basic-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Handwriting-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";  Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-OCR-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";          Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-Speech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab";       Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-LanguageFeatures-TextToSpeech-{Lang}-Package~31bf3856ad364e35~{ARCH}~~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                     Structure = "LanguagesAndOptionalFeatures"; }
					)
				}
				@{
					Group = "Install;WinRE;"
					Rule = @(
						@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
						@{ Match = "lp.cab";                           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-securestartup_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-atbroker_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiocore_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-audiodrivers_{Lang}.cab";    Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-enhancedstorage_{Lang}.cab"; Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-narrator_{Lang}.cab";        Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-scripting_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-speech-tts_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srh_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-srt_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wds-tools_{Lang}.cab";       Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wmi_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-appxpackaging_{Lang}.cab";   Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-storagewmi_{Lang}.cab";      Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-wifi_{Lang}.cab";            Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-rejuv_{Lang}.cab";           Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-opcservices_{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
						@{ Match = "winpe-hta_{Lang}.cab";             Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs\{Lang}"; }
					)
				}
			)
		}
	}
	#endregion
)