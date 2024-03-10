<#
	.Available servers
	.可用的服务器

	Usage:
	用法：

       Only one URL address must be added in front of the, number, multiple addresses do not need to be added, example:
       只有一个 URL 地址必须在前面添加 , 号，多地址不用添加，示例：

	$Script:PreServerList = @(
        "https://fengyi.tel/download/solutions/update/Instl/en-US/latest.json",
		"https://github.com/ilikeyi/powershell.install.software/raw/main/Update/en-US/latest.json"
	)
#>
$Script:ServerList = @()
$Script:ServerListSelect = @()
$Script:PreServerList = @(
	"https://fengyi.tel/download/solutions/latest.tar.xz"
	"https://github.com/ilikeyi/Solutions/Update/latest.tar.xz"
)

<#
    .临时存放路径
#>
$RandomGuid = [guid]::NewGuid()
$Temp_Main_Path = "$($env:TEMP)\$($RandomGuid)"
New-Item -Path $Temp_Main_Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

write-host $Temp_Main_Path














<#
    .清理临时生成的文件
#>
remove-item -path $Temp_Main_Path -force -Recurse -ErrorAction silentlycontinue | Out-Null