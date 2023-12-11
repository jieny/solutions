<#
	.Create a directory
	.创建目录
#>
Function Autopilot_Set_Language_Preference
{
	param
	(
		$GUID
	)

	<#
		.从预规则里获取
	#>
	ForEach ($item in $Global:Pre_Config_Rules) {
		if ($GUID -eq $item.GUID) {
			return @{
				IsMatch = $True
				GUID = $item
			}
		}
	}

	<#
		.从用户自定义规则里获取
	#>
	if (Is_Find_Modules -Name "Solutions.Custom.Extension") {
		if ($Global:Custom_Rule.count -gt 0) {
			ForEach ($item in $Global:Custom_Rule) {
				if ($GUID -eq $item.GUID) {
					return @{
						IsMatch = $True
						GUID = $item
					}
				}
			}
		}
	}

	return $False
}