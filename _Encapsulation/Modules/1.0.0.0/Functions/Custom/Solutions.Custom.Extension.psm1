<#
	.预配置规则

	 Name         = 名称
	 GUID         = 规则唯一标识符
	 Description  = 描述

	* InBox Apps
	 	ISO       = 规则命名通过验证 ISO 文件。
		SN        = S 版、SN 版
		            Edition = Windows 操作系统版本识别

		N         = N 版
				    Edition = Windows 操作系统版本识别
					Exclude = 遇到 N 版时，排除的应用规则

	 	Rule      = 规则
	    	        安装包类型，唯一识别名，模糊查找名，依赖

	* Language
		ISO       = 规则命名通过验证 ISO 文件。
		Rule      = Boot
				  = Install

#>
$Global:Custom_Rule = @(
	@{
		GUID         = "794e9610-d174-4db1-9cc6-7394526edc52"
		Author       = ""
		Copyright    = ""
		Name         = "Template"
		Description  = ""
		InboxApps   = @{
			ISO = @(
				""
			)
			SN = @{
				Edition = @(
					""
				)
			}
			N = @{
				Edition = @(
					""
				)
				Exclude = @(
					""
				)
			}
			Rule = (
				("11", "", "", (""))
			)
		}
		Language = @{
			ISO = (
				""
			)
			Rule = @{
				WinRE = @(
					("", "")
				)
				Boot = (
					("", "")
				)
				Install = (
					("", "")
				)
			}
		}
	}
)

<#
	.搜索机制

	{Lang}  = 语言标记
	{ARCH}  = 架构：原始 amd64
	{ARCHC} = 架构：转换后的结果：x64

	.排序：内核、系统类型、boot 或 Install、所需文件、文件路径
#>
$Global:Custom_Rule_Language = @(
	@{
		GUID         = "d8d9c961-3075-4492-acd7-1ce87cfda239"
		Author       = ''
		Copyright    = ''
		Name         = "Template"
		Description  = ""
		InboxApps   = @{
			ISO = @(
				""
			)
			SN = @{
				Edition = @(
					""
				)
			}
			N = @{
				Edition = @(
					""
				)
				Exclude = @(
					""
				)
			}
			Rule = (
				("11", "", "", (""))
			)
		}
		Language = @{
			ISO = (
				""
			)
			Rule = @{
				Boot = (
					@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
				)
				Install = (
					@{ Match = "Microsoft-Windows-LanguageFeatures-Fonts-{DiyLang}-Package~31bf3856ad364e35~{ARCH}~~.cab";     Structure = "LanguagesAndOptionalFeatures"; }
				)
				WinRE = @(
					@{ Match = "WinPE-FontSupport-{Lang}.cab";     Structure = "Windows Preinstallation Environment\{ARCHC}\WinPE_OCs"; }
				)
			}
		}
	}
)