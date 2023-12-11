<#
	.Summary
	.摘要
	 Yi's Solutions

	.PowerShell must be run with elevated privileges, run
	.PowerShell 必须以提升的特权运行，运行
	 powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"

	.Or run in a PowerShell session, PS C:\>
	.或在 PowerShell 会话中运行, PS C:\>
	 Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

	.LINK
	 https://github.com/ilikeyi/Solutions
	 https://gitee.com/ilikeyi/Solutions
#>

<#
	.The log is saved to the directory name
	.日志保存到目录名称
#>
$Global:LogSaveTo = "Log-Autopilot-$(Get-Date -Format "yyyyMMddHHmmss")"

Remove-Module -Name Solutions -Force -ErrorAction Ignore | Out-Null
Import-Module -Name $PSScriptRoot\..\Modules\Solutions.psd1 -PassThru -Force | Out-Null

<#
	.Set language pack, usage:
	.设置语言，用法
	 Language                | Language selected by the user       | 选择语言，交互
	 Language -Auto          | Automatic matching                  | 自动选择，不提示
	 Language -Force "zh-CN" | Mandatory use of specified language | 强制选择语言
#>
Language -Auto

<#
	.Prerequisites
	.先决条件
#>
Requirements

<#
	.Enable log
	.启用日志
#>
Logging

####################################################################################

<#
	.先决条件，所依赖的包

	添加语言，指定：
		1、设置语言首选规则命名 GUID；
		1、语言包 ISO；
#>

<#
	.设置语言首选规则命名 GUID
#>
$Verify_Install_Path = Autopilot_Set_Language_Preference -GUID "ec9e0561-3496-4b1a-8b29-03e60e549adf"
if ($Verify_Install_Path.IsMatch) {
	Write-host "匹配成功了"
#	Write-host $Verify_Install_Path.GUID
} else {
	Write-host "失败"
}