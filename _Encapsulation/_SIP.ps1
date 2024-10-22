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

	.EXAMPLE
	.示例
	 PS C:\> .\_Sip.ps1
	 PS C:\> .\_Sip.ps1 -Function "Function1 -Param", "Function2 -Param"

	.LINK
	 https://github.com/ilikeyi/Solutions

	.NOTES
	 Author:  Yi
	 Website: http://fengyi.tel
#>

[CmdletBinding()]
param
(
	[switch]$Force,
	[string[]]$Functions
)

<#
	.The log is saved to the directory name
	.日志保存到目录名称
#>
$Global:LogSaveTo = "Log-$(Get-Date -Format "yyyyMMddHHmmss")"

Remove-Module -Name Solutions -Force -ErrorAction Ignore | Out-Null
Import-Module -Name $PSScriptRoot\Modules\Solutions.psd1 -PassThru -Force | Out-Null

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
Prerequisite

<#
	.Enable log
	.启用日志
#>
Logging

# Go
if ($Functions) {
	foreach ($Function in $Functions) {
		Invoke-Expression -Command $Function
	}
	exit
}

Image_Select