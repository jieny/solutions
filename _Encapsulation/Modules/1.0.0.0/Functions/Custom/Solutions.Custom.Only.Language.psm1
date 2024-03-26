<#
	.搜索机制

	{Lang}  = 语言标记
	{ARCH}  = 架构：原始 amd64
	{ARCHC} = 架构：转换后的结果：x64

	.排序：内核、系统类型、boot 或 Install、所需文件、文件路径
#>
$Global:Preconfigured_Rule_Language = @(
	#region Windows Server 2025
	@{
		GUID        = "03adbaf0-80f0-4308-a660-2d9d065b181f"
		Author      = 'Yi'
		Copyright   = 'FengYi, Inc. All rights reserved.'
		Name        = "Microsoft Windows Server vNext 2025"
		Description = ""
		Autopilot   = @{
			Prerequisite = @{
				x64 = @{
					ISO = @{
						Language  = @(
							"Microsoft_Server_InsiderPreview_LangPack_FOD_26080.iso"
						)
						InBoxApps = @()
					}
				}
			}
		}
		ISO         = @(
			@{
				ISO = "Windows_InsiderPreview_Server_vNext_en-us_26080.iso"
				CRCSHA = @{
					SHA256 = ""
					SHA512 = ""
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
					ISO = "Microsoft_Server_InsiderPreview_LangPack_FOD_26080.iso"
					CRCSHA = @{
						SHA256 = ""
						SHA512 = ""
					}
				}
			)
			Rule = @(
				@{
					Uid  = "Boot;Boot;Wim;"
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
					Uid  = "Install;Install;Wim;"
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
						@{ Match = "Microsoft-Windows-ProjFS-OptionalFeature-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-Telnet-Client-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";              Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-TFTP-Client-FOD-Package~31bf3856ad364e35~{ARCH}~{Lang}~.cab";                Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-VBSCRIPT-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-VBSCRIPT-FoD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                    Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WinOcr-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                      Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-WinOcr-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";                      Structure = "LanguagesAndOptionalFeatures"; }

						@{ Match = "Microsoft-Windows-EnterpriseClientSync-Host-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-EnterpriseClientSync-Host-FOD-Package~31bf3856ad364e35~wow64~{Lang}~.cab";   Structure = "LanguagesAndOptionalFeatures"; }

						@{ Match = "Microsoft-Windows-ServerCoreFonts-NonCritical-Fonts-BitmapFonts-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-ServerCoreFonts-NonCritical-Fonts-MinConsoleFonts-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab"; Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-ServerCoreFonts-NonCritical-Fonts-Support-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";         Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-ServerCoreFonts-NonCritical-Fonts-TrueType-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";        Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-ServerCoreFonts-NonCritical-Fonts-UAPFonts-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";        Structure = "LanguagesAndOptionalFeatures"; }

						@{ Match = "Microsoft-Windows-SenseClient-FoD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                 Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-SimpleTCP-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
						@{ Match = "Microsoft-Windows-SmbDirect-FOD-Package~31bf3856ad364e35~amd64~{Lang}~.cab";                   Structure = "LanguagesAndOptionalFeatures"; }
					)
				}
				@{
					Uid  = "Install;WinRE;Wim;"
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
		Name        = "Microsoft Windows Server 23H2"
		Description = ""
		Autopilot   = @{
			Prerequisite = @{
				x64 = @{
					ISO = @{
						Language  = @(
							"mul_languages_and_optional_features_for_windows_server_version_23h2_x64_dvd_f49e7fd8.iso"
						)
						InBoxApps = @()
					}
				}
			}
		}
		ISO         = @(
			@{
				ISO = "en-us_windows_server_version_23h2_x64_dvd_f8fdfa10.iso"
				CRCSHA = @{
					SHA256 = "3be14b7ca09408c8e959e5cbc008918ef2874c5003c5893ad1706c8c07df3af9"
					SHA512 = "d5e6bbc0baa82f8eccada10ae92addfe4f87c9dc76c9b2dc65272de88c330a422a2850c0426648e8343779fcbc8f44847526c05ed9538852110f6def952e0ba2"
				}
			}
		)
		InboxApps   = @{
			ISO = @(
				@{
					ISO = ""
					CRCSHA = @{
						SHA256 = ""
						SHA512 = ""
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
					ISO = "mul_languages_and_optional_features_for_windows_server_version_23h2_x64_dvd_f49e7fd8.iso"
					CRCSHA = @{
						SHA256 = "800ed215d6b06b6831acd17c5e7c60c90d3b38a5e84cafd8018c9f9a77bc6641"
						SHA512 = "68eff849c34fabfee377bcacebc92c6b21fb7671929cb68a39d0ae3cc55d8a18196d708d104f2c84d43cb500a983f17f6544767cc4662779a1c0e6ca89467137"
					}
				}
			)
			Rule = @(
				@{
					Uid  = "Boot;Boot;Wim;"
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
					Uid  = "Install;Install;Wim;"
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
					Uid  = "Install;WinRE;Wim;"
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
		Name        = "Microsoft Windows Server 2022"
		Description = ""
		Autopilot   = @{
			Prerequisite = @{
				x64 = @{
					ISO = @{
						Language  = @()
						InBoxApps = @()
					}
				}
			}
		}
		ISO         = @(
			@{
				ISO = "en-us_windows_server_2022_x64_dvd_620d7eac.iso"
				CRCSHA = @{
					SHA256 = "5a077ee2a95976ef9f3623eb4040e25cdf7f8f01dee3b8165a32a7626f39f025"
					SHA512 = "850f040f450a12f04c64aab66479dfc71ee82b6b71a3427a8a0a66dbbedbfc10dbfacf3b454456bf971571d435be886fdea08e2ed6de3a7dabb5918eab666246"
				}
			}
			@{
				ISO = "cs-cz_windows_server_2022_x64_dvd_9cc09859.iso"
				CRCSHA = @{
					SHA256 = "45474f5a5ebdb3ead58c61aae6e24ecaef00996f263dffd2b4a5174f0f5e71a7"
					SHA512 = "7fdc12530f5094603709488ab651b6f9cbf2a4472756d379dda44874732366e0d89ce751659b242ca0bd636085410c20daa485a53c0435cb5d7f4318916cacf7"
				}
			}
			@{
				ISO = "de-de_windows_server_2022_x64_dvd_e2c1874e.iso"
				CRCSHA = @{
					SHA256 = "f04ae8464715d1cb00dd5408000f8631d0059ec719f64def25499eeffb4bbfa4"
					SHA512 = "7d600ef11cdc96e7b120dcd9375f36d728efc3d33d4af8efd9f0f59fdaffee3d7800dbec3739ef31a69e98c5e1ad57ab5a2e866e8fc0c1ab30247de822396afb"
				}
			}
			@{
				ISO = "es-es_windows_server_2022_x64_dvd_c25dea55.iso"
				CRCSHA = @{
					SHA256 = "5dce7b7d3457b3019e28edad8b4849fa12f9764a4bd6b524a80ed1c93ed6d3a8"
					SHA512 = "c1761ba36ea40a68647b4ffacb0cba596a2488c8350356d88793a104c85ef83fd736af926208b9208da581b9a08aa101e24e2a32d7ba03335bf8235b2fb3fe43"
				}
			}
			@{
				ISO = "fr-fr_windows_server_2022_x64_dvd_9f7d1adb.iso"
				CRCSHA = @{
					SHA256 = "b9d23f781b5bdee592d337a733d324f6383cd1616b9ab3e88bc0991f3d8670de"
					SHA512 = "edbbb9d023399717a9ee7b1e3bb617d1d3cfc1e22fda7fd62373106badad6e5fbe8026f9120a36c10066e2cd35839b273d263133c26e3fbe131629910d8f4c5e"
				}
			}
			@{
				ISO = "hu-hu_windows_server_2022_x64_dvd_d7eb4371.iso"
				CRCSHA = @{
					SHA256 = "864ac8749b16fb6368866adc3cea2b5c4d06a6638368bac06eb8b626f45df280"
					SHA512 = "25b6b323a58f979cc18b1d04337d522644c9a2265524242ad194de4d85ff3fe9817efd40d64326015f5a4b4fd85b91c0fd269f3be818188ae7e6bb1947a902e3"
				}
			}
			@{
				ISO = "it-it_windows_server_2022_x64_dvd_2ef5266d.iso"
				CRCSHA = @{
					SHA256 = "324d87f5211461dcb49a4bc1e78305ac0b8895ec4fcd28e1305d54f5e50cafac"
					SHA512 = "59b5f616498e12f33145a4cad5c36c2c81c7665731cf070747d4803518b57f90cc1eaf469824d7f53ad6c7b2f974c94f44f0b75998536cb573c2729fab7a5071"
				}
			}
			@{
				ISO = "ja-jp_windows_server_2022_x64_dvd_d49acd0d.iso"
				CRCSHA = @{
					SHA256 = "d3ebef7670de39fb370da1b352046c9975a7765a6b19eae50632838d3d28635e"
					SHA512 = "dcdf38dd478a2126070b425de46708e98bbed26401354a3ceea4c98b40746a2dee1bf71a3f209017f03f096490f3d757779c7f8ad1d6900209cc9fd01d4bd278"
				}
			}
			@{
				ISO = "ko-kr_windows_server_2022_x64_dvd_c14a04ba.iso"
				CRCSHA = @{
					SHA256 = "ec9b4487a8e60e2eb0d28eb175f60ed7a968dde383fe4a2a31e3023086422dd4"
					SHA512 = "4da12a8f473b84c60afa7551b2c150292bfa0521b1683ed7d7f33c1c4c0b0e4d18d0af9b84e74946fbb95926bbaf900ad3bb3134373d1b76f4d7fe97f8d24a51"
				}
			}
			@{
				ISO = "nl-nl_windows_server_2022_x64_dvd_1421617b.iso"
				CRCSHA = @{
					SHA256 = "225d17ca91fdbb97dc79b35945586170429d8c8a0e61b590a5231f080290489d"
					SHA512 = "73a82b569e0782469b46d7b8f9f4f4d021e7911ca51affe0500b7fb54ce3f7c01f1d6fbd5b41dde70f0e43d739356b9b7be3e5252181a3bda8f6f44a10e7564e"
				}
			}
			@{
				ISO = "pl-pl_windows_server_2022_x64_dvd_ac6af29a.iso"
				CRCSHA = @{
					SHA256 = "81542db3227302d40d3fa38374773e856dc750a741bb5955549c42c401aba637"
					SHA512 = "ed515f8f63e13e181d9ab60349c0b35e1790725895775d49c9e290e39962f2f81ca35b76368fb72d89b24f0961137f54d6274d2a37f7483abbacce1dbc535170"
				}
			}
			@{
				ISO = "pt-br_windows_server_2022_x64_dvd_b873861f.iso"
				CRCSHA = @{
					SHA256 = "eeb6fb306cfd9a15d234d2d80a37541eb29935f1e972c45a3a0e950b73d58f49"
					SHA512 = "8462552133de089696181681f059b24d8e20211cc17b677bf88a85d866041377c34dc382cc5269ea2c73b2bee258db9e818a69d89fd4faa188e4fc40bc435b76"
				}
			}
			@{
				ISO = "pt-pt_windows_server_2022_x64_dvd_39cc8179.iso"
				CRCSHA = @{
					SHA256 = "71e23e54ce35a278e0c3eee60d0173aea744da8a356d4985b0721f3ffdf2d197"
					SHA512 = "5bb1183376282cb8eb8c82fb69ef4b5cf63eebce60cabcf841a38d46158ce482846e287d08c2e5679ad3652d2993ac7f8a62d6d582c91779f0cb5d793883ddc7"
				}
			}
			@{
				ISO = "ru-ru_windows_server_2022_x64_dvd_d8fd3d54.iso"
				CRCSHA = @{
					SHA256 = "3307a5b8ed5ca0688a44e9bc64d536a291b8d161b3e8c5e3616705b64ee4657c"
					SHA512 = "3787f0eb1ccdb75c12d588483a35ba7516fb0f57621d2c6c2fce4590fcb74f7470839621b9e629674b14a12f1503e232f61bb1b0070b42b5992ca2183b3a70fb"
				}
			}
			@{
				ISO = "sv-se_windows_server_2022_x64_dvd_1b669ce4.iso"
				CRCSHA = @{
					SHA256 = "5462ed1435ba81374a42f97ebcb231250f4d9c9a9f9cca0550deb4e041e0c7ba"
					SHA512 = "0d643b43934809c32029c5298e9b37aee4bdb7048cef2ac10a47adcce051370e4995a9ecf23d22b0f7d1196385b82f5c3063e1a8bcf5b0b17d9826ff539f17e5"
				}
			}
			@{
				ISO = "tr-tr_windows_server_2022_x64_dvd_266ef676.iso"
				CRCSHA = @{
					SHA256 = "10f322d2276066e9640080e216b138b02d26ce27867b0b68bd955c7c185f8221"
					SHA512 = "970df5e006a8a522f4e4dde7bac65d2076e3922266c2c2181824abc131adb8da01a9c9e29ac48bbaa21e4b4352c09661b489c7035ad6bfde3519c5273703fc3a"
				}
			}
			@{
				ISO = "zh-cn_windows_server_2022_x64_dvd_6c73507d.iso"
				CRCSHA = @{
					SHA256 = "e77bb4618182d1e5d0b39da7e72354f4167ebb859428e7482587dd5a2a72f599"
					SHA512 = "2633c08b264a776772c6e9039b5015fa05106bd5086af028bbef9112bdf584837d92c45f6de0012d6de57db5aee0e1905959032a4b7d6e8e248a59f6908e6c2c"
				}
			}
			@{
				ISO = "zh-tw_windows_server_2022_x64_dvd_02ed5775.iso"
				CRCSHA = @{
					SHA256 = "b75af547ea7a9b2e739e52b9e1cec56e6069f1d934896920e2941881f9e46be6"
					SHA512 = "cb8616f5cea165b7fa28a43de39be92a79caaa79ed82a2441bb7e9adae17fcc1d10388b61ddc1fd5c40211474260441f01010a12cb5aaca2766e2f59a543a432"
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
					ISO = "https://software-download.microsoft.com/download/sg/20348.1.210507-1500.fe_release_amd64fre_SERVER_LOF_PACKAGES_OEM.iso"
					CRCSHA = @{
						SHA256 = ""
						SHA512 = ""
					}
				}
			)
			Rule = @(
				@{
					Uid  = "Boot;Boot;Wim;"
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
					Uid  = "Install;Install;Wim;"
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
					Uid  = "Install;WinRE;Wim;"
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