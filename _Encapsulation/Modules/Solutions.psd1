﻿@{
	RootModule        = 'Solutions.psm1'
	ModuleVersion     = '1.0.0.2'
	GUID              = '1e1ad755-d5e1-4769-af9b-7134001c8daf'
	Author            = 'Yi'
	Copyright         = 'FengYi, Inc. All rights reserved.'
	Description       = ''
	PowerShellVersion = '5.1'
	NestedModules     = @()
	FunctionsToExport = '*'
	CmdletsToExport   = '*'
	VariablesToExport = '*'
	AliasesToExport   = '*'

	PrivateData = @{
		PSData = @{
			Tags         = @("Yi's Solutions")
			LicenseUri   = 'https://opensource.org/license/artistic-2-0'
			ProjectUri   = 'https://github.com/ilikeyi/solutions'
			# IconUri      = ''
			# ReleaseNotes = ''
			MinimumVersion = '1.0.0.0'
			UpdateServer = @(
				"https://fengyi.tel/download/solutions/update/latest.json"
				"https://github.com/ilikeyi/solutions/raw/main/update/latest.json"
			)
		}
	}
	HelpInfoURI = 'https://fengyi.tel'
	# DefaultCommandPrefix = ''
}