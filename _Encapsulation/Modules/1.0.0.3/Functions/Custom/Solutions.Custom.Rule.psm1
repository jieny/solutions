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
		 https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/features-on-demand-language-fod?view=windows-11#other-region-specific-Prerequisite
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
		"*ServerCoreFonts-NonCritical-Fonts-BitmapFonts-FOD-Package*"
		"*ServerCoreFonts-NonCritical-Fonts-MinConsoleFonts-FOD-Package*"
		"*ServerCoreFonts-NonCritical-Fonts-Support-FOD-Package*"
		"*ServerCoreFonts-NonCritical-Fonts-TrueType-FOD-Package*"
		"*ServerCoreFonts-NonCritical-Fonts-UAPFonts-FOD-Package*"
		"*SimpleTCP-FOD-Package*"
		"*VirtualMachinePlatform-Client-Disabled-FOD-Package*"
		"*DirectoryServices-ADAM-Client-FOD-Package*"
		"*EnterpriseClientSync-Host-FOD-Package*"
		"*SenseClient-FoD-Package*"
		"*SmbDirect-FOD-Package*"
		"*TerminalServices-AppServer-Client-FOD-Package*"

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
	.Signed GPG KEY-ID
	.签名 GPG KEY-ID
#>
$Global:GpgKI = @(
	"0FEBF674EAD23E05"
	"2499B7924675A12B"
)

<#
	.Update, search for file types
	.更新，搜索文件类型
#>
$Global:Search_KB_File_Type = @(
	"*.esd"
	"*.cab"
	"*.msu"
	"*.mum"
)

<#
	.Exclude items that are not cleaned up
	.排除不清理的项目
#>
$Global:ExcludeClearSuperseded = @(
	"*Microsoft-Windows-UserExperience-Desktop-Package*"
)