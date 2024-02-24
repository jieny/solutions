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