﻿ConvertFrom-StringData -StringData @'
	# Translator                    = Yi

	AdvAppsDetailed                 = 生成报告
	AdvAppsDetailedTips             = 按区域标记搜索，发现可用的本地语言体验包后获取更多详细信息，生成一份报告文件：*.CSV。
	ProcessSources                  = 处理来源
	InboxAppsManager                = 收件箱应用
	InboxAppsMatchDel               = 按匹配规则删除
	InboxAppsOfflineDel             = 删除预配的应用程序
	InboxAppsClear                  = 强行删除已安装的所有预应用程序 ( UWP )
	InstallUWP                      = 匹配 UWP 应用
	InstallUWPCheck                 = 检查依赖包
	InstallUWPCheckTips             = 根据规则，获取已选择的所有安装项，校验是否已选择所依赖的安装项。
	LocalExperiencePackTips         = 本地语言体验包 ( LXPs )
	LEPBrandNew                     = 以全新方式，推荐
	UWPAutoMissingPacker            = 自动从所有磁盘搜索缺少的软件包
	UWPAutoMissingPackerSupport     = x64 架构，需要安装缺少的软件包。
	UWPAutoMissingPackerNotSupport  = 非 x64 架构，只支持 x64 架构时使用。
	UWPEdition                      = Windows 版本唯一识别码
	UWPOptimize                     = 优化预配 Appx 包，通过用硬链接替换相同的文件
	RemoveAllUWPTips                = 说明:\n\n第一步：添加本地语言体验包（LXPs），该步骤必须对应微软官方发行的对应包，前往此处并下载：\n       将语言包添加到 Windows 10 多会话映像\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/language-packs\n\n       向 Windows 11 企业版映像添加语言\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/windows-11-language-packs\n\n第二步：解压或挂载 *_InboxApps.iso，根据架构选择目录；\n\n第三步：如果微软官方尚未发行最新本地语言体验包（LXPs），跳过此步骤；如果有：请参照微软官方发布的公告：\n       1、对应本地语言体验包（LXPs）；\n       2、对应累积更新。 \n\n已预安装的应用程序 ( UWP ) 是单语言，需要重新安装才会获得多语言。 \n\n1、您可以选择开发者版本、初始版本制作；\n    开发者版本，例如版本号为：\n    Windows 11 系列\n    Windows 11 23H2, Build 22631.1\n    Windows 11 22H2, Build 22621.1\n    Windows 11 21H2, Build 22000.1\n\n    初始版本，已知初始版本：\n    Windows 11 系列\n    Windows 11 23H2, Build 22631.2428\n    Windows 11 22H2, Build 22621.382\n    Windows 11 21H2, Build 22000.194\n\n    Windows 10 系列\n    Windows 10 21H2, 2109, Build 19045.2006\n    Windows 10 21H2, 2109, Build 19044.1288\n    Windows 10 21H1, 2104, Build 19043.928\n    Windows 10 20H2, 2009, Build 19042.264\n    Windows 10 20H1, 2004, Build 19041.264\n    Windows 10 19H1, 1909, Build 18363.418\n\n    重要：\n      a. 每版本更新时，请重新制作镜像，例如从 21H1 跨越到 22H2 时，请勿在旧镜像基础上更新，应避免出现其它兼容性问题；再次提醒您，请使用初始版本制作。\n      b. 该条例已经在某些 OEM 厂商，通过各种形式向封装师明确传达了该法令，不允许直接从迭代版本里直接升级。\n      关键词：迭代、跨版本、累积更新。\n\n2、安装语言包后，必须添加累积更新，因为未添加累积更新之前，组件不会有任何变化，至直安装累积更新后才会发生新的变化，例如组件状态：已过时、待删除；\n\n3、使用已带累积更新的版本，到了最后还是得再次添加累积更新，已经重复操作了；\n\n4、所以在制作时建议您使用不带累积更新的版本制作，再最后一步添加累积更新。 \n\n选择目录后搜索条件：LanguageExperiencePack.*.Neutral.appx
	ImportCleanDuplicate            = 清理重复文件
	ForceRemovaAllUWP               = 跳过本地语言体验包 ( LXPs ) 添加，执行其它
	LEPSkipAddEnglish               = 安装时跳过 en-US 添加，建议
	LEPSkipAddEnglishTips           = 默认英文语言包，再添加就多此一举。	
	License                         = 有证书
	NoLicense                       = 无证书
	StepOne                         = 第一步：标记，本地语言体验包 ( LXPs )
	StepTwo                         = 第二步：
	CurrentIsNVeriosn               = N 版系列
	CurrentNoIsNVersion             = 全功能版本
	LXPsWaitAddUpdate               = 待更新
	LXPsWaitAdd                     = 待添加
	LXPsWaitRemove                  = 待删除
	LXPsAddDelTipsView              = 有新的提示，现在查看
	LXPsAddDelTipsGlobal            = 不再提示，同步至全局
	LXPsAddDelTips                  = 不再提示
'@