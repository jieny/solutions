﻿ConvertFrom-StringData -StringData @'
	# Translator                    = Yi

	AdvAppsDetailed                 = Generate a report
	AdvAppsDetailedTips             = Search by region tag, find available local language experience packs, get more details, generate a report file: *. CSV.
	ProcessSources                  = Process the source
	InboxAppsManager                = Inbox apps
	InboxAppsMatchDel               = Delete by matching rule
	InboxAppsOfflineDel             = Delete provisioned applications
	InboxAppsClear                  = Forcibly delete all installed pre-apps ( UWP )
	InstallUWP                      = Match UWP apps
	InstallUWPCheck                 = Check dependencies
	InstallUWPCheckTips             = According to the rules, get all the selected installation items, and check whether the dependent installation items have been selected.
	LocalExperiencePackTips         = Local language experience package ( LXPs )
	LEPBrandNew                     = In a new way, recommend
	UWPAutoMissingPacker            = Automatically search for missing packages from all disks
	UWPAutoMissingPackerSupport     = For x64 architecture, the missing software packages need to be installed.
	UWPAutoMissingPackerNotSupport  = It is not used for x64 architecture and only supports x64 architecture.
	UWPEdition                      = The Windows version unique identifier
	UWPOptimize                     = Optimize the Appx package, Replace the same file with a hard link
	RemoveAllUWPTips                = Instructions:\n\nStep 1: Add local language experience packs (LXPs), this step must correspond to the corresponding packs officially released by Microsoft, go here and download:\n       Add language packs to Windows 10 multi-session images\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/language-packs\n\n       Add languages to Windows 11 Enterprise images\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/windows-11-language-packs\n\nStep 2: Unzip or mount *_InboxApps.iso, select the directory according to the architecture;\n\nStep 3: If Microsoft has not officially released the latest local language experience packs (LXPs), skip this step; if so: please refer to the official Microsoft announcement:\n       1. Corresponding local language experience packs (LXPs);\n       2. Corresponding cumulative update.\n\nPre-installed apps (UWP) are single language and require reinstallation to get multilingual.\n\n1. you can choose the developer version, the initial version of the production;\n    The developer version, for example, the version number is:\n    Windows 11 series\n    Windows 11 23H2, Build 22631.1\n    Windows 11 22H2, Build 22621.1\n    Windows 11 21H2, Build 22000.1\n\n    Initial release, known initial version: \n    Windows 11 series\n    Windows 11 23H2, Build 22631.2428\n    Windows 11 22H2, Build 22621.382\n    Windows 11 21H2, Build 22000.194\n\n    Windows 10 series\n    Windows 10 21H2, 2109, Build 19045.2006\n    Windows 10 21H2, 2109, Build 19044.1288\n    Windows 10 21H1, 2104, Build 19043.928\n    Windows 10 20H2, 2009, Build 19042.264\n    Windows 10 20H1, 2004, Build 19041.264\n    Windows 10 19H1, 1909, Build 18363.418\n\n    Important:\n      a. When each version is updated, please re-create the image. For example, when crossing from 21H1 to 22H2, please do not update on the basis of the old image, and other compatibility problems should be avoided; remind you again, please use the initial version to create.\n      b. This regulation has clearly communicated the decree to packagers through various forms in some OEM manufacturers, and direct upgrades from iterative versions are not allowed.\n      Keywords: iteration, cross-version, cumulative update.\n\n2. After installing the language pack, the cumulative update must be added, because the components will not have any changes before the cumulative update is added, and new changes will not occur until the cumulative update is installed, such as component status: outdated, to be deleted;\n\n3. If you use the version with the cumulative update, you still have to add the cumulative update again at the end, and the operation has been repeated;\n\n4. Therefore, it is recommended that you use the version without the cumulative update when making it, and then add the cumulative update in the last step.\n\nAfter selecting the directory, search criteria: LanguageExperiencePack.*.Neutral.appx
	ImportCleanDuplicate            = Clean up the duplicate files
	ForceRemovaAllUWP               = Skip the addition of local language experience packs ( LXPs ) and execute other
	LEPSkipAddEnglish               = Skip the en-US addition during installation, it is recommended
	LEPSkipAddEnglishTips           = The English language pack is the default, and adding it would be superfluous.
	License                         = With certificate
	NoLicense                       = No certificate
	StepOne                         = First step: Mark, local language experience pack ( LXPs )
	StepTwo                         = Second step: \
	CurrentIsNVeriosn               = N version series
	CurrentNoIsNVersion             = Full-featured version
	LXPsWaitAddUpdate               = Pending upgrade
	LXPsWaitAdd                     = To be added
	LXPsWaitRemove                  = To be deleted
	LXPsAddDelTipsView              = There are new tips, check it out now
	LXPsAddDelTipsGlobal            = No more prompts, sync to the global
	LXPsAddDelTips                  = Do not remind again
'@