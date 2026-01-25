<#
  .Searched directory structure
  .搜索的目录结构
#>
$SearchUnPack = @(
	"Desktop"
	"Server"
)

$UnPackigtype = @(
	"*.iso"
	"*.gho"
)

<#
  .Compressed package name
  .压缩包名称
#>
$UnPackName = "$($Global:Author)Solutions.$(Get-Date -Format "yyyyMMddHHmmss")"

<#
  .Save the compressed package to
  .压缩包保存到
#>
$UnPackSaveTo = "$(Convert-Path "$($PSScriptRoot)\..\..\..\..\..\.." -ErrorAction SilentlyContinue)\_Unpack"

<#
	.Archive temporary directory
	.压缩包临时目录
#>
$RandomFolderGuid = New-Guid
$TempFolderUnPack = "$(Convert-Path "$($PSScriptRoot)\..\..\..\..\..\.." -ErrorAction SilentlyContinue)\_Unpack\$($RandomFolderGuid)"

<#
	.Exclude files or directories from the compressed package
	.从压缩包中排除文件或目录
#>
$ArchiveExcludeUnPack = @(
	"-xr-!_Unpack"
	"-xr-!_Learn\Packaging.tutorial\OS.11\24H2\Expand\Install\Report"
	"-xr-!_Learn\Packaging.tutorial\OS.11\24H2\Expand\wimlib"
	"-xr-!_Learn\Packaging.tutorial\OS.10\22H2\Expand\wimlib"
	"-xr-!_Encapsulation\Logs"
	"-xr-!_Encapsulation\_Custom\Engine\LXPs\Logs"
	"-xr-!_Encapsulation\_Custom\Engine\LXPs\AIO\7zPacker"
	"-xr-!_Encapsulation\_Custom\Engine\LXPs\Download"
	"-xr-!_Encapsulation\_Custom\Engine\Multilingual\Logs"
	"-xr-!_Encapsulation\_Custom\Engine\Multilingual\AIO\7zPacker"
	"-xr-!_Encapsulation\_Custom\Engine\Yi.Suite\Logs"
	"-xr-!_Encapsulation\_Custom\Office\Setup.exe"
	"-xr-!_Encapsulation\_Custom\Office\2024\amd64\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\2024\x86\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\2021\amd64\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\2021\x86\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\365\amd64\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\365\x86\Office\Data"
	"-xr-!_Encapsulation\_Custom\Office\UWP"
)

<#
	.Generate compressed package format
	 To generate gz, xz, tar must be generated, otherwise it cannot be created.

	.生成压缩包格式
	 生成 gz, xz，需生成 tar，否则无法创建。
#>
$BuildTypeUnpack = @(
	[Archive]::zip
#	[Archive]::tar
#	[Archive]::xz
)

Enum Archive
{
	z7
	zip
	tar
	xz
	gz
}

<#
	.Create upgrade package user interface
	.创建升级包用户界面
#>
Function UnPack_Create_UI
{
	Logo -Title $lang.Backup

	Write-Host "  $($lang.Backup)" -ForegroundColor Yellow
	Write-Host "  $('-' * 80)"

	Image_Init_Disk_Sources

	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	[System.Windows.Forms.Application]::EnableVisualStyles()

	$UI_Main           = New-Object system.Windows.Forms.Form -Property @{
		autoScaleMode  = 2
		Height         = 720
		Width          = 1072
		Text           = $lang.Backup
		Font           = New-Object System.Drawing.Font($lang.FontsUI, 9, [System.Drawing.FontStyle]::Regular)
		StartPosition  = "CenterScreen"
		MaximizeBox    = $False
		MinimizeBox    = $true
		ControlBox     = $true
		BackColor      = "#ffffff"
		FormBorderStyle = "Fixed3D"
		AllowDrop      = $True
		Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("$($PSScriptRoot)\..\..\..\..\Assets\icon\Yi.ico")
	}
	$GUIUnPackSources  = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 360
		Text           = $lang.UpSources -f $UnPackigtype
		Location       = '15,15'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($GUIUnPackSources.Checked) {
				$GUIUnPackShow.Enabled = $False
			} else {
				$GUIUnPackShow.Enabled = $True
			}
		}
	}
	$GUIUnPackShow     = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 120
		Width          = 475
		autoSizeMode   = 1
		Padding        = "28,0,8,0"
		Location       = "0,45"
		autoScroll     = $True
		Enabled        = $False
	}

		<#
			.Add right-click menu: select all, clear button
			.添加右键菜单：全选、清除按钮
		#>
		$GUIUnPackAddMenu = New-Object System.Windows.Forms.ContextMenuStrip
		$GUIUnPackAddMenu.Items.Add($lang.AllSel).add_Click({
			$GUIUnPackShow.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						$_.Checked = $true
					}
				}
			}
		})
		$GUIUnPackAddMenu.Items.Add($lang.AllClear).add_Click({
			$GUIUnPackShow.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						$_.Checked = $false
					}
				}
			}
		})
		$GUIUnPackShow.ContextMenuStrip = $GUIUnPackAddMenu

	<#
		.创建升级包后需要做些什么
	#>
	$GUIUnPackRearTips = New-Object system.Windows.Forms.Label -Property @{
		Location       = "575,15"
		Height         = 30
		Width          = 510
		Text           = $lang.UpCreateRear
	}
	$GUIUnPackGroupGPG = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 330
		Width          = 520
		autoSizeMode   = 1
		Padding        = "8,8,8,8"
		Location       = '575,40'
	}
	$UI_Main_Create_ASC = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 470
		Text           = "$($lang.UpSources -f "PGP")"
		Location       = '26,0'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($UI_Main_Create_ASC.Checked) {
				$UI_Main_Create_ASC_Panel.Enabled = $True
				Save_Dynamic -regkey "Solutions\Unpack" -name "IsPGP_Unpack" -value "True"
			} else {
				$UI_Main_Create_ASC_Panel.Enabled = $False
				Save_Dynamic -regkey "Solutions\Unpack" -name "IsPGP_Unpack" -value "False"
			}
		}
	}
	$UI_Main_Create_ASC_Panel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 340
		Width          = 480
		autoSizeMode   = 1
		Padding        = "38,0,0,0"
		Location       = "0,35"
	}
	$GUIUnPackCreateASCClean = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.UpCleanOld
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$UI_Main_Create_ASCSignName = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.CreateASCAuthor
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
			$UI_Main_Create_ASCSign.Items.Clear()

			$Newgpglistkey = Get_gpg_list_secret_keys
			if ($Newgpglistkey.Count -gt 0) {
				$UI_Main_Create_ASC.Enabled = $True

				<#
					.初始化：PGP KEY-ID
				#>
				ForEach ($item in $Newgpglistkey) {
					$UI_Main_Create_ASCSign.Items.Add($item) | Out-Null
				}

				if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "PGP" -ErrorAction SilentlyContinue) {
					$UI_Main_Create_ASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "PGP" -ErrorAction SilentlyContinue
				} else {
					if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue) {
						$UI_Main_Create_ASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue
					}
				}

				$UI_Main_Error.Text = "$($lang.Refresh), $($lang.Done)"
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
			} else {
				$UI_Main_Error.Text = "$($lang.Refresh), $($lang.Done) > $($lang.NoPGPKey)"
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Info.ico")
			}
		}
	}
	$UI_Main_Create_ASCSign = New-Object system.Windows.Forms.ComboBox -Property @{
		Height         = 30
		Width          = 400
		Text           = ""
		DropDownStyle  = "DropDownList"
	}
	$UI_Main_Create_ASCSign_Warp = New-Object system.Windows.Forms.Label -Property @{
		Height         = 20
		Width          = 410
	}
	$GUIUnPackCreateASCPWDName = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 390
		Text           = $lang.CreateASCPwd
	}
	$GUIUnPackCreateASCPWD = New-Object System.Windows.Forms.MaskedTextBox -Property @{
		Height         = 30
		Width          = 400
		PasswordChar = "*"
		Text           = $Global:secure_password
		BackColor      = "#FFFFFF"
	}

	<#
		.证书密码：显示明文
	#>
	$UI_Main_Pass_Show = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 40
		Width          = 455
		Text           = $lang.ShowPassword
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($UI_Main_Pass_Show.Checked) {
				$GUIUnPackCreateASCPWD.PasswordChar = (New-Object Char) # `0 and [char]0
			} else {
				$GUIUnPackCreateASCPWD.PasswordChar = "*"
			}
		}
	}

	<#
		.证书密码：永久保存
	#>
	$UI_Main_Pass_Permanent = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 40
		Width          = 455
		Location       = '0,300'
		Text           = $lang.PwdPermanent
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($UI_Main_Pass_Permanent.Checked) {
				Save_Dynamic -regkey "Solutions\GPG" -name "PwdPermanent" -value "True"
			} else {
				Save_Dynamic -regkey "Solutions\GPG" -name "PwdPermanent" -value "False"
			}
		}
	}

	$GUIUnPackCreateSHA256 = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 470
		Location       = '580,380'
		Text           = "$($lang.UpSources -f "SHA256")"
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($GUIUnPackCreateSHA256.Checked) {
				$GUIUnPackCreateSHA256Clean.Enabled = $True
			} else {
				$GUIUnPackCreateSHA256Clean.Enabled = $False
			}
		}
	}
	$GUIUnPackCreateSHA256Clean = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 453
		Location       = '598,410'
		Text           = $lang.UpCleanOld
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUnPackBackupExclude = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 453
		Text           = $lang.UpBackupExclude
		Location       = '580,470'
		Checked        = $True
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null
		}
	}
	$GUIUnPackBackupExcludeView = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 265
		Text           = $lang.Exclude_View
		Location       = "596,500"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			$UI_Main_View_Detailed.Visible = $True
			$UI_Main_View_Detailed_Show.Text = ""

			$UI_Main_View_Detailed_Show.Text += "   $($lang.ExcludeItem)`n"
			ForEach ($item in $ArchiveExcludeUnPack) {
				$UI_Main_View_Detailed_Show.Text += "       $($item)`n"
			}
		}
	}

	<#
		.备份规则
	#>
	Function Unpack_API_Add_New_Rule_Name
	{
		param
		(
			[switch]$IsForce
		)

		$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
		$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"

		if (Unpack_API_Verify_New_RuleName) {
			if ($IsForce) {
				If (Test-Path -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GUIImageSourceGroupAPI_Rule_Path.Text)") {
				} else {
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.NoInstallImage), $($lang.PleaseChoose): $($lang.AddTo)"
					$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
					return
				}
			} else {
				<#
					.添加前，验证是否有旧的规则名存在
				#>
				If (Test-Path -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GUIImageSourceGroupAPI_Rule_Path.Text)") {
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Existed): $($GUIImageSourceGroupAPI_Rule_Path.Text)"
					$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
					return
				}
			}

			if ($GUIImageSourceGroupAPI_New_Path_IsCheck.Checked) {
				If ([String]::IsNullOrEmpty($GUIImageSourceGroupAPI_New_Path.Text)) {
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.NoChoose): $($lang.SelFile)"
					$GUIImageSourceGroupAPI_New_Path.BackColor = "LightPink"
					return
				} else {
					if (Test-Path -Path $GUIImageSourceGroupAPI_New_Path.Text -PathType leaf) {
						if ($Global:Support_PS_Filename -Contains $([System.IO.Path]::GetExtension($GUIImageSourceGroupAPI_New_Path.Text))) {
							
						} else {
							$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.RuleNameFormat): $($Global:Support_PS_Filename)"
							$GUIImageSourceGroupAPI_New_Path.BackColor = "LightPink"
							return
						}
					} else {
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
						$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.NoInstallImage)"
						$GUIImageSourceGroupAPI_New_Path.BackColor = "LightPink"
						return
					}
				}
			}

			New-Item "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GUIImageSourceGroupAPI_Rule_Path.Text)" -force -ErrorAction SilentlyContinue | Out-Null
			New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GUIImageSourceGroupAPI_Rule_Path.Text)" -Name "Path" -Value $GUIImageSourceGroupAPI_New_Path.Text -PropertyType String -force -ErrorAction SilentlyContinue | Out-Null

			Unpack_Refresh_Api

			if ($IsForce) {
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Change): $($GUIImageSourceGroupAPI_Rule_Path.Text), $($lang.Done)"
			} else {
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.AddTo): $($GUIImageSourceGroupAPI_Rule_Path.Text), $($lang.Done)"
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Change): $($GUIImageSourceGroupAPI_Rule_Path.Text), $($lang.Done)"
			}

			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
			$GUIImageSourceGroupAPI_Rule_Path.Text = ""
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPI_New_Path.Text = ""
			$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
		}
	}

	<#
		.API: Validation rule name
		.API：验证规则名
	#>
	Function Unpack_API_Verify_New_RuleName
	{
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
		$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"

		<#
			.Judgment: 1. Null value
			.判断：1. 空值
		#>
		if ([string]::IsNullOrEmpty($GUIImageSourceGroupAPI_Rule_Path.Text)) {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.RuleNameNotInput)"
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
			return $False
		}

		<#
			.Judgment: 2. The prefix cannot contain spaces
			.判断：2. 前缀不能带空格
		#>
		if ($GUIImageSourceGroupAPI_Rule_Path.Text -match '^\s') {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.ISO9660TipsErrorSpace)"
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
			return $False
		}

		<#
			.Judgment: 3. No spaces at the end
			.判断：3. 后缀不能带空格
		#>
		if ($GUIImageSourceGroupAPI_Rule_Path.Text -match '\s$') {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.ISO9660TipsErrorSpace)"
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
			return $False
		}

		<#
			.Judgment: 4. There can be no two spaces in between
			.判断：4. 中间不能含有二个空格
		#>
		if ($GUIImageSourceGroupAPI_Rule_Path.Text -match '\s{2,}') {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.ISO9660TipsErrorSpace)"
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
			return $False
		}

		<#
			.Judgment: 5. Cannot contain: \\ /: *? "" <> |
			.判断：5, 不能包含：\\ / : * ? "" < > |
		#>
		if ($GUIImageSourceGroupAPI_Rule_Path.Text -match '[~#$@!%&*{}<>?/|+"]') {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.ISO9660TipsErrorOther)"
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "LightPink"
			return $False
		}

		<#
			.Judgment: 6. No more than 260 characters
			.判断：6. 不能大于 260 字符
		#>
		if ($UIUnzip_Search_Sift_Custon.Text.length -gt 6) {
			$UI_Main_Error.Text = "$($lang.SelectFromError): $($lang.ISOLengthError -f "6")"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$UIUnzip_Search_Sift_Custon.BackColor = "LightPink"
			return
		}

		return $True
	}

	Function Unpack_Refresh_Api
	{
		$UI_Unpack_Api.controls.Clear()
		$GUIImageSourceGroupAPI_Shortcut_Panel.controls.Clear()
		$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
		$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

		$GetALlName = @()
		Get-ChildItem -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom" -ErrorAction SilentlyContinue | ForEach-Object {
			$GetALlName += $([System.IO.Path]::GetFileNameWithoutExtension($_.Name))
		}

		if ($GetALlName.Count -gt 0) {
			ForEach ($item in $GetALlName) {
				<#
					.捕捉路径
				#>
				if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($item)" -Name "Path" -ErrorAction SilentlyContinue) {
					$GetImportFileName = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($item)" -Name "Path" -ErrorAction SilentlyContinue
				} else {
					$GetImportFileName = ""
				}

				$ShortcutsShortName = $([System.IO.Path]::GetFileNameWithoutExtension($item))

				<#
					.添加复选框到主界面选择执行
				#>
				$CheckboxSel   = New-Object System.Windows.Forms.CheckBox -Property @{
					Height     = 35
					Width      = 425
					Text       = "$($lang.RuleName): $($item)"
					Name       = $ShortcutsShortName
					Tag        = $GetImportFileName
					add_Click      = {
						$UI_Main_Error.Text = ""
						$UI_Main_Error_Icon.Image = $null
					}
				}
				$UI_Unpack_Api.controls.AddRange($CheckboxSel)

				$Checkbox      = New-Object System.Windows.Forms.CheckBox -Property @{
					Height     = 35
					Width      = 425
					Text       = "$($lang.RuleName): $($item)"
					Name       = $ShortcutsShortName
					Tag        = $GetImportFileName
					add_Click      = {
						$GUIImageSourceGroupAPIErrorMsg.Text = ""
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
					}
				}
				$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange($Checkbox)

				$CheckboxCreate    = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 35
					Width          = 425
					Padding        = "16,0,0,0"
					Text           = $lang.RuleNewTempate
					Name           = $ShortcutsShortName
					Tag            = $GetImportFileName
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						if ([string]::IsNullOrEmpty($This.Tag)) {
							$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.RuleNewTempate): $($This.Name), $($lang.Failed)"
						} else {
							Api_Create_Template -NewFile $This.Tag -Type "Update"
							Unpack_Refresh_Api
							if (Test-Path -Path $This.Tag -PathType leaf) {
								$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.RuleNewTempate): $($This.Name), $($lang.Done)"
								$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
							}  else {
								$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.RuleNewTempate): $($This.Name), $($lang.Failed)"
								$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							}
						}

						$GUIImageSourceGroupAPI_Rule_Path.Text = ""
						$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
						$GUIImageSourceGroupAPI_New_Path.Text = ""
						$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
					}
				}

				if ([string]::IsNullOrEmpty($GetImportFileName)) {
					$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange($CheckboxCreate)
				} else {
					if (Test-Path -Path $GetImportFileName -PathType leaf) {
					} else {
						$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange($CheckboxCreate)
					}
				}

				$CheckboxPath  = New-Object system.Windows.Forms.Label -Property @{
					autoSize   = 1
					Text       = ""
					Padding    = "16,5,0,15"
				}

				$Checkbox_Path_OpenFile = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 35
					Width          = 425
					Padding        = "16,0,0,0"
					Text           = $lang.OpenFile
					Tag            = $GetImportFileName
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						$GUIImageSourceGroupAPIErrorMsg.Text = ""
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
					
						if ([string]::IsNullOrEmpty($This.Tag)) {
							$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile), $($lang.Inoperable)"
						} else {
							if (Test-Path -Path $This.Tag -PathType Leaf) {
								Start-Process -FilePath $This.Tag
							
								$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
								$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile): $($UI_Main_Save_To.Text), $($lang.Done)"
							} else {
								$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
								$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile): $($UI_Main_Save_To.Text), $($lang.Inoperable)"
							}
						}
					}
				}

				$CheckboxPathCopy  = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 35
					Width          = 425
					Padding        = "16,0,0,0"
					Text           = $lang.Paste
					Tag            = $GetImportFileName
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						$GUIImageSourceGroupAPIErrorMsg.Text = ""
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

						if ([string]::IsNullOrEmpty($This.Tag)) {
							$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
							$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Paste), $($lang.Inoperable)"
						} else {
							Set-Clipboard -Value $This.Tag

							$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
							$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Paste), $($lang.Done)"
						}
					}
				}

				$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange((
					$CheckboxPath,
					$Checkbox_Path_OpenFile,
					$CheckboxPathCopy
				))

				$CheckboxChange    = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 35
					Width          = 425
					Padding        = "16,0,0,0"
					Text           = $lang.Change
					Name           = $ShortcutsShortName
					Tag            = $GetImportFileName
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
						$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
						$GUIImageSourceGroupAPIErrorMsg.Text = ""
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
						$GUIImageSourceGroupAPI_Rule_Path.Text = $this.Name
						$GUIImageSourceGroupAPI_New_Path.Text = $this.Tag
					}
				}

				$CheckboxDel       = New-Object system.Windows.Forms.LinkLabel -Property @{
					Height         = 35
					Width          = 425
					Padding        = "16,0,0,0"
					Text           = $lang.Del
					Name           = $ShortcutsShortName
					LinkColor      = "GREEN"
					ActiveLinkColor = "RED"
					LinkBehavior   = "NeverUnderline"
					add_Click      = {
						Remove-Item "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($This.Name)" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
						Unpack_Refresh_Api

						$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Del): $($This.Name), $($lang.Done)"
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")

						$GUIImageSourceGroupAPI_Rule_Path.Text = ""
						$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
						$GUIImageSourceGroupAPI_New_Path.Text = ""
						$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
					}
				}

				$Checkbox_Wrap     = New-Object system.Windows.Forms.Label -Property @{
					Height         = 20
					Width          = 410
				}

				If ([String]::IsNullOrEmpty($GetImportFileName)) {
					$CheckboxPath.Text = "$($lang.Select_Path): $($lang.Failed)"
				} else {
					$CheckboxPath.Text = "$($lang.Select_Path): $($GetImportFileName)"
				}

				$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange((
					$CheckboxChange,
					$CheckboxDel,
					$Checkbox_Wrap
				))
			}
		} else {
			<#
				.添加复选框到主界面选择执行
			#>
			$UI_Main_API_Sel_NoWork = New-Object system.Windows.Forms.Label -Property @{
				Height         = 30
				Width          = 425
				Text           = $lang.NoWork
			}
			$UI_Unpack_Api.controls.AddRange($UI_Main_API_Sel_NoWork)

			$UI_Main_Pre_Rule_NoWork = New-Object system.Windows.Forms.Label -Property @{
				Height         = 30
				Width          = 425
				Text           = $lang.NoWork
			}
			$GUIImageSourceGroupAPI_Shortcut_Panel.controls.AddRange($UI_Main_Pre_Rule_NoWork)
		}
	}

	Function Unpack_API_Backup
	{
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

		$GetALlName = @()
		Get-ChildItem -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom" -ErrorAction SilentlyContinue | ForEach-Object {
			$GetNewPath = $([System.IO.Path]::GetFileNameWithoutExtension($_.Name))

			if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GetNewPath)" -Name "Path" -ErrorAction SilentlyContinue) {
				$GetImportFileName = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($GetNewPath)" -Name "Path" -ErrorAction SilentlyContinue
			} else {
				$GetImportFileName = ""
			}

			$GetALlName += @{
				Name = $GetNewPath
				Path = $GetImportFileName
			}
		}

		if ($GetALlName.Count -gt 0) {
			$NewTempFileNameGUID = "Unpack.API.Backup.$(Get-Date -Format "yyyyMMddHHmmss").json"

			$FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{
				FileName         = $NewTempFileNameGUID
				Filter           = "Unpack API Backup Files (*.json;)|*.json;"
				InitialDirectory = $InitialPath
			}

			if ($FileBrowser.ShowDialog() -eq "OK") {
				$GroupBackupNew = [PSCustomObject]@{
					Name = "$($Global:Author)'s Soultions"
					Url = "$((Get-Module -Name Solutions).HelpInfoURI)"
					Description = "API Backup"
					version = $((Get-Module -Name Solutions).PrivateData.PSData.API.MinimumVersion)
					API = $GetALlName
				}
				$GroupBackupNew | ConvertTo-Json | Out-File -FilePath $FileBrowser.FileName -Encoding utf8 -ErrorAction SilentlyContinue

				if (Test-Path -Path $FileBrowser.FileName -PathType leaf) {
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Backup): $($FileBrowser.FileName), $($lang.Done)"
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
				} else {
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Backup): $($FileBrowser.FileName), $($lang.Failed)"
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				}
			} else {
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$GUIImageSourceGroupAPIErrorMsg.Text = $lang.UserCanel
			}
		} else {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = $lang.NoWork
		}
	}

	Function Unpack_API_Restore
	{
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

		$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
			Filter = "json Files (*.json)|*.json"
		}

		if ($FileBrowser.ShowDialog() -eq "OK") {
			try {
				$ReadBackupJson = Get-Content -Raw -Path $FileBrowser.FileName | ConvertFrom-Json

				if ($ReadBackupJson.Version.Replace('.', '') -ge $((Get-Module -Name Solutions).PrivateData.PSData.API.MinimumVersion).Replace('.', '')) {
					if ($ReadBackupJson.API.Count -gt 0) {
						foreach ($item in $ReadBackupJson.API) {
							New-Item "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($item.Name)" -force -ErrorAction SilentlyContinue | Out-Null
							New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($item.Name)" -Name "Path" -Value $item.Path -PropertyType String -force -ErrorAction SilentlyContinue | Out-Null
						}

						Unpack_Refresh_Api
						$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Restore), $($lang.Done)"
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
					} else {
						$GUIImageSourceGroupAPIErrorMsg.Text = $lang.NoWork
						$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\info.ico")
					}
				} else {
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Autopilot_Config_File_Low): $($FileBrowser.FileName)"
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				}
			} catch {
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFileFormatError): $($FileBrowser.FileName)"
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			}
		} else {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
			$GUIImageSourceGroupAPIErrorMsg.Text = $lang.UserCanel
		}
	}

	<#
		.组：设置 API
	#>
	$GUIImageSourceGroupAPI = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 1072
		autoSizeMode   = 1
		Padding        = "8,8,8,8"
		Location       = '0,0'
		Visible        = $False
	}

	$GUIImageSourceGroupAPI_Shortcut_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 428
		Text           = $lang.Short_Cmd
		Location       = '15,15'
	}
	$GUIImageSourceGroupAPI_Shortcut_Panel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 515
		Width          = 475
		Location       = '15,45'
		Padding        = "15,0,0,0"
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
	}

	$UI_Main_List_Select = New-Object System.Windows.Forms.ContextMenuStrip
	$UI_Main_List_Select.Items.Add($lang.AllSel).add_Click({
		$GUIImageSourceGroupAPI_Shortcut_Panel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $true
				}
			}
		}
	})
	$UI_Main_List_Select.Items.Add($lang.AllClear).add_Click({
		$GUIImageSourceGroupAPI_Shortcut_Panel.Controls | ForEach-Object {
			if ($_ -is [System.Windows.Forms.CheckBox]) {
				if ($_.Enabled) {
					$_.Checked = $false
				}
			}
		}
	})
	$GUIImageSourceGroupAPI_Shortcut_Panel.ContextMenuStrip = $UI_Main_List_Select

	<#
		备份 API
	#>
	$GUIImageSourceGroupAPI_Shortcut_Panel_Backup = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 160
		Location       = '20,590'
		Text           = $lang.Backup
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Unpack_API_Backup }
	}

	<#
		还原 API
	#>
	$GUIImageSourceGroupAPI_Shortcut_Panel_Restore = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 160
		Location       = '20,630'
		Text           = $lang.Restore
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = { Unpack_API_Restore }
	}

	<#
		从注册表读取保存的命名规则：刷新
	#>
	$GUIImageSourceGroupAPI_Shortcut_Panel_Refresh = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 160
		Location       = '190,590'
		Text           = $lang.Refresh
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			Unpack_Refresh_Api

			$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Refresh), $($lang.Done)"
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
		}
	}

	<#
		.API：删除已选
	#>
	$GUIImageSourceGroupAPI_Shortcut_Clear_Select = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 160
		Location       = '190,630'
		Text           = "$($lang.Del), $($lang.Choose)"
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$Temp_Save_Select_Path = @()

			$GUIImageSourceGroupAPI_Shortcut_Panel.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Checked) {
						$Temp_Save_Select_Path += $_.Name
					}
				}
			}

			if ($Temp_Save_Select_Path.Count -gt 0) {
				Foreach ($item in $Temp_Save_Select_Path) {
					Remove-Item "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($item)" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
				}

				Unpack_Refresh_Api
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Del), $($lang.Choose), $($lang.Done)"
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
			} else {
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Del), $($lang.Failed), $($lang.NoWork)"
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Info.ico")
			}
		}
	}

	$GUIImageSourceGroupAPISettingPanel = New-Object system.Windows.Forms.FlowLayoutPanel -Property @{
		Height         = 540
		Width          = 475
		BorderStyle    = 0
		autoSizeMode   = 0
		autoScroll     = $True
		Location       = '575,20'
	}

	$GUIImageSourceGroupAPI_Adv = New-Object System.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 428
		Text           = $lang.AdvOption
	}
	$GUIImageSourceGroupAPI_New_Path_IsCheck = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 438
		Padding        = "25,0,0,0"
		Text           = $lang.RuleNewPathISCheck
		Checked        = $True
		add_Click      = {
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
		}
	}

	$GUIImageSourceGroupAPI_Adv_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height       = 30
		Width        = 428
	}

	<#
		.名称
	#>
	$GUIImageSourceGroupAPI_New_Rule_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 428
		Text           = $lang.RuleName
	}
	$GUIImageSourceGroupAPI_Rule_Path = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 420
		margin         = "25,0,0,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		add_Click      = {
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
		}
	}

	$GUIImageSourceGroupAPI_Rule_Path_Tips = New-Object system.Windows.Forms.Label -Property @{
		autoSize       = 1
		Padding        = "22,0,0,0"
		Text           = $lang.RuleNewNameTips -f "6"
	}

	$GUIImageSourceGroupAPI_New_Rule_Name_Wrap = New-Object system.Windows.Forms.Label -Property @{
		Height       = 40
		Width        = 428
	}

	<#
		.路径
	#>
	$GUIImageSourceGroupAPI_New_Path_Name = New-Object system.Windows.Forms.Label -Property @{
		Height         = 30
		Width          = 428
		Text           = $lang.Select_Path
	}
	$GUIImageSourceGroupAPI_New_Path = New-Object System.Windows.Forms.TextBox -Property @{
		Height         = 30
		Width          = 420
		margin         = "25,0,0,20"
		Text           = ""
		BackColor      = "#FFFFFF"
		add_Click      = {
			$GUIImageSourceGroupAPI_Rule_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
		}
	}
	$GUIImageSourceGroupAPI_New_Path_Tips = New-Object system.Windows.Forms.Label -Property @{
		autoSize       = 1
		Padding        = "22,0,0,20"
		Text           = "$($lang.RuleNameFormat): $($Global:Support_PS_Filename)"
	}

	$GUIImageSourceGroupAPI_New_Path_Select = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 35
		Width          = 428
		Padding        = "22,0,0,0"
		Text           = $lang.SelFile
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$GUIImageSourceGroupAPI_New_Path.BackColor = "#FFFFFF"
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

			$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
				Filter = "PowerShell Files (*.ps1;*.psd1;*.psm1;)|*.ps1;*.psd1;*.psm1;"
			}

			if ($FileBrowser.ShowDialog() -eq "OK") {
				$GUIImageSourceGroupAPI_New_Path.Text = $FileBrowser.FileName

				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelFile), $($lang.Done)"
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
			} else {
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$GUIImageSourceGroupAPIErrorMsg.Text = $lang.UserCancel
			}
		}
	}

	$GUIImageSourceGroupAPI_New_Path_Select_Tips = New-Object system.Windows.Forms.Label -Property @{
		autoSize       = 1
		Padding        = "41,0,0,20"
		Text           = $lang.DropFile
	}

	$GUIImageSourceGroupAPI_New_Path_OpenFile = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 45
		Width          = 428
		margin         = "22,5,0,0"
		Text           = $lang.OpenFile
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

			if ([string]::IsNullOrEmpty($GUIImageSourceGroupAPI_New_Path.Text)) {
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile), $($lang.Inoperable)"
			} else {
				if (Test-Path -Path $GUIImageSourceGroupAPI_New_Path.Text -PathType Leaf) {
					Start-Process -FilePath $GUIImageSourceGroupAPI_New_Path.Text

					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile): $($UI_Main_Save_To.Text), $($lang.Done)"
				} else {
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.OpenFile): $($UI_Main_Save_To.Text), $($lang.Inoperable)"
				}
			}
		}
	}

	$GUIImageSourceGroupAPI_New_Path_Paste = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 45
		Width          = 428
		Padding        = "20,0,0,0"
		Text           = $lang.Paste
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$GUIImageSourceGroupAPIErrorMsg.Text = ""
			$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

			if ([string]::IsNullOrEmpty($GUIImageSourceGroupAPI_New_Path.Text)) {
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Paste), $($lang.Inoperable)"
				$GUIImageSourceGroupAPI_New_Path.BackColor = "LightPink"
			} else {
				Set-Clipboard -Value $GUIImageSourceGroupAPI_New_Path.Text

				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
				$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Paste), $($lang.Done)"
			}
		}
	}

	$GUIImageSourceGroupAPIErrorMsg_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "575,583"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$GUIImageSourceGroupAPIErrorMsg = New-Object System.Windows.Forms.Label -Property @{
		Location       = "600,585"
		Height         = 40
		Width          = 443
		Text           = ""
	}

	<#
		.API: 修改
	#>
	$GUIImageSourceGroupAPI_Change = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "575,635"
		Height         = 36
		Width          = 153
		Text           = $lang.Change
		add_Click      = { Unpack_API_Add_New_Rule_Name -IsForce }
	}

	<#
		.API: 添加
	#>
	$GUIImageSourceGroupAPI_Add = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "733,635"
		Height         = 36
		Width          = 153
		Text           = $lang.AddTo
		add_Click      = { Unpack_API_Add_New_Rule_Name }
	}

	$GUIImageSourceGroupAPICanel = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "890,635"
		Height         = 36
		Width          = 153
		Text           = $lang.Hide
		add_Click      = {
			if ($Page) {
				$UI_Main.Close()
			} else {
				$UI_Main.Text = $lang.Setting
				$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null
				$GUIImageSourceGroupAPIErrorMsg.Text = ""

				$GUIImageSourceGroupAPI.visible = $False         # 蒙板：API设置
				$UI_Main.remove_DragOver($UI_Main_API_DragOver)
				$UI_Main.remove_DragDrop($UI_Main_DragDrop)
			}
		}
	}

	$UI_Unpack_Api_Refresh = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 390
		Location       = '15,200'
		Text           = "$($lang.Backup) > $($lang.Functions_Rear): "
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			Unpack_Refresh_Api

			$UI_Main_Error.Text = "$($lang.Refresh), $($lang.Done)"
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
		}
	}

	$UI_Main_API_DragOver = [System.Windows.Forms.DragEventHandler]{
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

		if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
			$_.Effect = 'Copy'
		} else {
			$_.Effect = 'None'
		}
	}
	$UI_Main_API_DragDrop = {
		$GUIImageSourceGroupAPIErrorMsg.Text = ""
		$GUIImageSourceGroupAPIErrorMsg_Icon.Image = $null

		if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
			foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
				$types = [IO.Path]::GetExtension($filename)
				if ($Global:Support_PS_Filename -contains $types) {
					$GUIImageSourceGroupAPI_New_Path.Text = $filename

					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.Choose): $($filename), $($lang.Done)"
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Success.ico")
				} else {
					$GUIImageSourceGroupAPIErrorMsg.Text = "$($lang.SelectFromError): $($lang.PleaseChoose) ( $($Global:Support_PS_Filename) )"
					$GUIImageSourceGroupAPIErrorMsg_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				}
			}
		}
	}

	$UI_Unpack_Api     = New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		BorderStyle    = 0
		Height         = 300
		Width          = 475
		autoSizeMode   = 1
		Padding        = "28,0,8,0"
		Location       = "0,235"
		autoScroll     = $True
	}

		<#
			.Add right-click menu: select all, clear button
			.添加右键菜单：全选、清除按钮
		#>
		$UI_Unpack_Api_AddMenu = New-Object System.Windows.Forms.ContextMenuStrip
		$UI_Unpack_Api_AddMenu.Items.Add($lang.AllSel).add_Click({
			$UI_Unpack_Api.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						$_.Checked = $true
					}
				}
			}
		})
		$UI_Unpack_Api_AddMenu.Items.Add($lang.AllClear).add_Click({
			$UI_Unpack_Api.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Enabled) {
						$_.Checked = $false
					}
				}
			}
		})
		$UI_Unpack_Api.ContextMenuStrip = $UI_Unpack_Api_AddMenu

	$UI_Unpack_Api_Setting = New-Object system.Windows.Forms.LinkLabel -Property @{
		Height         = 30
		Width          = 390
		Location       = '15,565'
		Text           = $lang.Setting
		LinkColor      = "GREEN"
		ActiveLinkColor = "RED"
		LinkBehavior   = "NeverUnderline"
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			$UI_Main.Add_DragOver($UI_Main_API_DragOver)
			$UI_Main.Add_DragDrop($UI_Main_API_DragDrop)
			$GUIImageSourceGroupAPI.visible = $True         # 蒙板：API设置
		}
	}

	$UI_Create_Latest_Zip = New-Object System.Windows.Forms.CheckBox -Property @{
		Height         = 30
		Width          = 360
		Text           = $lang.LevelLatest
		Location       = '15,600'
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			if ($UI_Create_Latest_Zip.Checked) {
				Save_Dynamic -regkey "Solutions\Unpack" -name "IsLatest" -value "True"
			} else {
				Save_Dynamic -regkey "Solutions\Unpack" -name "IsLatest" -value "False"
			}
		}
	}
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "IsLatest" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "IsLatest" -ErrorAction SilentlyContinue) {
			"True" {
				$UI_Create_Latest_Zip.Checked = $True
			}
			"False" {
				$UI_Create_Latest_Zip.Checked = $False
			}
		}
	} else {
		$UI_Create_Latest_Zip.Checked = $False
	}

	$GUIUnPackBackup   = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Location       = "8,635"
		Height         = 36
		Width          = 460
		Text           = $lang.Backup
		add_Click      = {
			$BackupDone = @()
			$UI_Unpack_Api.Controls | ForEach-Object {
				if ($_ -is [System.Windows.Forms.CheckBox]) {
					if ($_.Checked) {
						$BackupDone += $_.Name
					}
				}
			}

			if ($UI_Main_Pass_Permanent.Checked) {
				if ([string]::IsNullOrEmpty($GUIUnPackCreateASCPWD.Text)) {
					Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -Force -ErrorAction SilentlyContinue | out-null
					Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -Force -ErrorAction SilentlyContinue | out-null
				} else {
					$key = (1..32 | ForEach-Object { [byte](Get-Random -Minimum 0 -Maximum 255) })
					Save_Dynamic -regkey "Solutions\GPG" -Name "PwdPermanentKey" -value $key -Type "Binary"

					$secureString = $GUIUnPackCreateASCPWD.Text | ConvertTo-SecureString -AsPlainText -Force
					$encrypted = ConvertFrom-SecureString -SecureString $secureString -Key $key
					Save_Dynamic -regkey "Solutions\GPG" -Name "PGPPwd" -value $encrypted

					if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue) {
					} else {
						Save_Dynamic -regkey "Solutions\GPG" -name "PGP" -value $UI_Main_Create_ASCSign.Text
					}
				}
			} else {
				Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -Force -ErrorAction SilentlyContinue | out-null
				Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -Force -ErrorAction SilentlyContinue | out-null
			}

			<#
				.备份时，排除不包含项
			#>
			if ($GUIUnPackBackupExclude.Checked) {
				$Script:BackupSoluionsExclude = $True
			} else {
				$Script:BackupSoluionsExclude = $False
			}

			<#
				.搜索到后生成 PGP
			#>
			$Script:UnPackCreateASC = $False
			$Script:UnPackCreateASCClean = $False
			if ($UI_Main_Create_ASC.Enabled) {
				if ($UI_Main_Create_ASC.Checked) {
					if ([string]::IsNullOrEmpty($UI_Main_Create_ASCSign.Text)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.SelectFromError): $($lang.CreateASCAuthorTips)"
						return
					} else {
						Save_Dynamic -regkey "Solutions\Unpack" -name "PGP" -value $UI_Main_Create_ASCSign.Text
						$Script:UnPackCreateASC = $True
						$Global:secure_password = $GUIUnPackCreateASCPWD.Text
					}
				}

				if ($GUIUnPackCreateASCClean.Enabled) {
					if ($GUIUnPackCreateASCClean.Checked) {
						$Script:UnPackCreateASCClean = $True
					}
				}
			}

			<#
				.搜索到后生成 SHA256
			#>
			$Script:UnPackCreateSHA256 = $False
			$Script:UnPackCreateSHA256Clean = $False
			if ($GUIUnPackCreateSHA256.Enabled) {
				if ($GUIUnPackCreateSHA256.Checked) {
					$Script:UnPackCreateSHA256 = $True
				}

				if ($GUIUnPackCreateSHA256Clean.Enabled) {
					if ($GUIUnPackCreateSHA256Clean.Checked) {
						$Script:UnPackCreateSHA256Clean = $True
					}
				}
			}

			$RandomTempFileGuid = New-Guid
			Check_Folder -chkpath $TempFolderUnPack
			$test_temp_folder_guid = "$($TempFolderUnPack)\writetest-$($RandomTempFileGuid)"

			Out-File -FilePath $test_temp_folder_guid -Encoding utf8 -ErrorAction SilentlyContinue

			if (Test-Path -Path $test_temp_folder_guid -PathType Leaf) {
				$UI_Main.Hide()
				Remove-Item $test_temp_folder_guid -Recurse -Force -ErrorAction SilentlyContinue | Out-Null

				UnPack_Compression_Process -Path (Convert-Path "$($PSScriptRoot)\..\..\..\..\..\..")
				UnPack_Create_SHA256_GPG -Path $TempFolderUnPack
				UnPack_Move_To -OldPath $TempFolderUnPack -NewPath $UnPackSaveTo
				Update_Create_Version -SaveTo $UnPackSaveTo -buildstring $((Get-Module -Name Solutions).PrivateData.PSData.Buildstring) -CurrentVersion (Get-Module -Name Solutions).Version.ToString() -LowVer $((Get-Module -Name Solutions).PrivateData.PSData.MinimumVersion)

				Write-Host "`n  $($lang.Backup) > $($lang.Functions_Rear)"
				Write-Host "  $('-' * 80)"
				if ($BackupDone.Count -gt 0) {
					ForEach ($item in $BackupDone) {
						Unpack_API_Process_Rule_Name -RuleName $item
					}
				} else {
					Write-Host "  $($lang.NoWork)" -ForegroundColor Red
				}

				$UI_Main.Close()
			} else {
				$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
				$UI_Main_Error.Text = "$($lang.Inoperable): $($TempFolderUnPack)"
			}
		}
	}

	<#
		.Mask: Displays the rule details
		.蒙板：显示规则详细信息
	#>
	$UI_Main_View_Detailed = New-Object system.Windows.Forms.Panel -Property @{
		BorderStyle    = 0
		Height         = 678
		Width          = 1072
		autoSizeMode   = 1
		Padding        = "8,8,8,8"
		Location       = '0,0'
		Visible        = $False
	}
	$UI_Main_View_Detailed_Show = New-Object System.Windows.Forms.RichTextBox -Property @{
		BorderStyle    = 0
		Height         = 595
		Width          = 880
		Location       = "15,15"
		Text           = ""
		BackColor      = "#FFFFFF"
		ReadOnly       = $True
	}
	$UI_Main_View_Detailed_Hide = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 470
		Location       = "575,635"
		Text           = $lang.Hide
		add_Click      = {
			$UI_Main_View_Detailed.Visible = $False
		}
	}

	$UI_Main_Error_Icon = New-Object system.Windows.Forms.PictureBox -Property @{
		Location       = "575,598"
		Height         = 20
		Width          = 20
		SizeMode       = "StretchImage"
	}
	$UI_Main_Error     = New-Object system.Windows.Forms.Label -Property @{
		Location       = "600,600"
		Height         = 30
		Width          = 460
		Text           = ""
	}
	$UI_Main_OK        = New-Object system.Windows.Forms.Button -Property @{
		UseVisualStyleBackColor = $True
		Height         = 36
		Width          = 470
		Location       = "575,635"
		Text           = $lang.OK
		add_Click      = {
			$UI_Main_Error.Text = ""
			$UI_Main_Error_Icon.Image = $null

			$Script:SelectFolderList = @()

			<#
				.搜索到后生成 PGP
			#>
			$Script:UnPackCreateASC = $False
			$Script:UnPackCreateASCClean = $False
			if ($UI_Main_Create_ASC.Enabled) {
				if ($UI_Main_Create_ASC.Checked) {
					if ([string]::IsNullOrEmpty($UI_Main_Create_ASCSign.Text)) {
						$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
						$UI_Main_Error.Text = "$($lang.SelectFromError): $($lang.CreateASCAuthorTips)"
						return
					} else {
						Save_Dynamic -regkey "Solutions\Unpack" -name "PGP" -value $UI_Main_Create_ASCSign.Text
						$Script:UnPackCreateASC = $True
						$Global:secure_password = $GUIUnPackCreateASCPWD.Text
					}
				}

				if ($GUIUnPackCreateASCClean.Enabled) {
					if ($GUIUnPackCreateASCClean.Checked) {
						$Script:UnPackCreateASCClean = $True
					}
				}
			}

			<#
				.搜索到后生成 SHA256
			#>
			$Script:UnPackCreateSHA256 = $False
			$Script:UnPackCreateSHA256Clean = $False
			if ($GUIUnPackCreateSHA256.Enabled) {
				if ($GUIUnPackCreateSHA256.Checked) {
					$Script:UnPackCreateSHA256 = $True
				}

				if ($GUIUnPackCreateSHA256Clean.Enabled) {
					if ($GUIUnPackCreateSHA256Clean.Checked) {
						$Script:UnPackCreateSHA256Clean = $True
					}
				}
			}

			if ($GUIUnPackSources.Checked) {
				$UI_Main.Hide()
				ForEach ($item in $SearchUnPack) {
					$Script:SelectFolderList += Join-Path -Path $Global:MainMasterFolder -ChildPath $item
				}

				ForEach ($item in $Script:SelectFolderList) {
					Write-Host "  $($item)"
					UnPack_Create_SHA256_GPG -Path $item
				}
				$UI_Main.Close()
			} else {
				$GUIUnPackShow.Controls | ForEach-Object {
					if ($_ -is [System.Windows.Forms.CheckBox]) {
						if ($_.Enabled) {
							if ($_.Checked) {
								$Script:SelectFolderList += $_.Text
							}
						}
					}
				}

				if ($Script:SelectFolderList.Count -gt 0) {
					$UI_Main.Hide()

					if ($UI_Main_Pass_Permanent.Checked) {
						if ([string]::IsNullOrEmpty($GUIUnPackCreateASCPWD.Text)) {
							Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -Force -ErrorAction SilentlyContinue | out-null
							Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -Force -ErrorAction SilentlyContinue | out-null
						} else {
							$key = (1..32 | ForEach-Object { [byte](Get-Random -Minimum 0 -Maximum 255) })
							Save_Dynamic -regkey "Solutions\GPG" -Name "PwdPermanentKey" -value $key -Type "Binary"
						
							$secureString = $GUIUnPackCreateASCPWD.Text | ConvertTo-SecureString -AsPlainText -Force
							$encrypted = ConvertFrom-SecureString -SecureString $secureString -Key $key
							Save_Dynamic -regkey "Solutions\GPG" -Name "PGPPwd" -value $encrypted

							if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue) {
							} else {
								Save_Dynamic -regkey "Solutions\GPG" -name "PGP" -value $UI_Main_Create_ASCSign.Text
							}
						}
					} else {
						Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -Force -ErrorAction SilentlyContinue | out-null
						Remove-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -Force -ErrorAction SilentlyContinue | out-null
					}

					ForEach ($item in $Script:SelectFolderList) {
						Write-Host "  $($item)"
						UnPack_Create_SHA256_GPG -Path $item
					}
					$UI_Main.Close()
				} else {
					$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
					$UI_Main_Error.Text = $lang.UpdateServerNoSelect
				}
			}
		}
	}
	$UI_Main.controls.AddRange((
		$GUIImageSourceGroupAPI,
		$UI_Main_View_Detailed,
		$GUIUnPackSources,
		$GUIUnPackShow,
		$UI_Unpack_Api_Refresh,
		$UI_Unpack_Api,
		$UI_Unpack_Api_Setting,
		$UI_Create_Latest_Zip,
		$GUIUnPackBackup,
		$GUIUnPackBackupTips,
		$GUIUnPackBackupExclude,
		$GUIUnPackBackupExcludeView,
		$GUIUnPackRearTips,
		$GUIUnPackGroupGPG,
		$GUIUnPackCreateSHA256,
		$GUIUnPackCreateSHA256Clean,
		$UI_Main_Error_Icon,
		$UI_Main_Error,
		$UI_Main_OK
	))

	$UI_Main_View_Detailed.controls.AddRange((
		$UI_Main_View_Detailed_Show,
		$UI_Main_View_Detailed_Hide
	))

	$GUIUnPackGroupGPG.controls.AddRange((
		$UI_Main_Create_ASC,
		$UI_Main_Create_ASC_Panel
	))

	$UI_Main_Create_ASC_Panel.controls.AddRange((
		$GUIUnPackCreateASCClean,
		$UI_Main_Create_ASCSignName,
		$UI_Main_Create_ASCSign,
		$UI_Main_Create_ASCSign_Warp,
		$GUIUnPackCreateASCPWDName,
		$GUIUnPackCreateASCPWD,
		$UI_Main_Pass_Show,
		$UI_Main_Pass_Permanent
	))

	ForEach ($item in $SearchUnPack) {
		$CheckBox         = New-Object System.Windows.Forms.CheckBox -Property @{
			Height        = 40
			Width         = 425
			Text          = Join-Path -Path $Global:MainMasterFolder -ChildPath $item
			Checked       = $True
			add_Click      = {
				$UI_Main_Error.Text = ""
				$UI_Main_Error_Icon.Image = $null
			}
		}
		$GUIUnPackShow.controls.AddRange($CheckBox)
	}

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$GUIUnPackBackup.Enabled = $True
		$UI_Main_OK.Enabled = $True
	} else {
		$GUIUnPackSources.Enabled = $False
		$GUIUnPackCreateSHA256Clean.Enabled = $False

		$GUIUnPackBackup.Enabled = $False
		$UI_Main_OK.Enabled = $False

		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += "$($lang.SoftIsInstl -f "7-Zip")"
	}

	$GUIImageSourceGroupAPI.controls.AddRange((
		$GUIImageSourceGroupAPI_Shortcut_Name,
		$GUIImageSourceGroupAPI_Shortcut_Panel,
		$GUIImageSourceGroupAPI_Shortcut_Panel_Backup,
		$GUIImageSourceGroupAPI_Shortcut_Panel_Restore,
		$GUIImageSourceGroupAPI_Shortcut_Panel_Refresh,
		$GUIImageSourceGroupAPI_Shortcut_Clear_Select,
		$GUIImageSourceGroupAPISettingPanel,
		$GUIImageSourceGroupAPIErrorMsg_Icon,
		$GUIImageSourceGroupAPIErrorMsg,
		$GUIImageSourceGroupAPI_Change,
		$GUIImageSourceGroupAPI_Add,
		$GUIImageSourceGroupAPICanel
	))
	$GUIImageSourceGroupAPISettingPanel.controls.AddRange((
		$GUIImageSourceGroupAPI_Adv,
		$GUIImageSourceGroupAPI_New_Path_IsCheck,
		$GUIImageSourceGroupAPI_Adv_Wrap,
		$GUIImageSourceGroupAPI_New_Rule_Name,
		$GUIImageSourceGroupAPI_Rule_Path,
		$GUIImageSourceGroupAPI_Rule_Path_Tips,
		$GUIImageSourceGroupAPI_New_Rule_Name_Wrap,
		$GUIImageSourceGroupAPI_New_Path_Name,
		$GUIImageSourceGroupAPI_New_Path,
		$GUIImageSourceGroupAPI_New_Path_Tips,
		$GUIImageSourceGroupAPI_New_Path_Select,
		$GUIImageSourceGroupAPI_New_Path_Select_Tips,
		$GUIImageSourceGroupAPI_New_Path_OpenFile,
		$GUIImageSourceGroupAPI_New_Path_Paste
	))

	Unpack_Refresh_Api

	<#
		.初始化复选框：生成 PGP
	#>
	$Verify_Install_Path = Get_ASC -Run "gpg.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		$GUIUnPackGroupGPG.Enabled = $True

		if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "IsPGP_Unpack" -ErrorAction SilentlyContinue) {
			switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "IsPGP_Unpack" -ErrorAction SilentlyContinue) {
				"True" {
					$UI_Main_Create_ASC.Checked = $True
				}
				"False" {
					$UI_Main_Create_ASC.Checked = $False
				}
			}
		} else {
			$UI_Main_Create_ASC.Checked = $False
		}

		$Newgpglistkey = Get_gpg_list_secret_keys
		if ($Newgpglistkey.Count -gt 0) {
			$UI_Main_Create_ASC.Enabled = $True

			<#
				.初始化：PGP KEY-ID
			#>
			ForEach ($item in $Newgpglistkey) {
				$UI_Main_Create_ASCSign.Items.Add($item) | Out-Null
			}

			if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "PGP" -ErrorAction SilentlyContinue) {
				$UI_Main_Create_ASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack" -Name "PGP" -ErrorAction SilentlyContinue
			} else {
				if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue) {
					$UI_Main_Create_ASCSign.Text = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGP" -ErrorAction SilentlyContinue
				}
			}

			<#
				.证书密码：永久保存
			#>
			if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -name "PwdPermanent" -ErrorAction SilentlyContinue) {
				switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -name "PwdPermanent" -ErrorAction SilentlyContinue) {
					"True" {
						$UI_Main_Pass_Permanent.Checked = $True

						if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -ErrorAction SilentlyContinue) {
							$oldPwdPermanentKey = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PwdPermanentKey" -ErrorAction SilentlyContinue

							if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -ErrorAction SilentlyContinue) {
								$OldSavePwd = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\GPG" -Name "PGPPwd" -ErrorAction SilentlyContinue

								try {
									[byte[]]$recoveredKey = $oldPwdPermanentKey
									$recoveredEncryptedPass = $OldSavePwd
									$decryptedSS = $recoveredEncryptedPass | ConvertTo-SecureString -Key $recoveredKey
									$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($decryptedSS)
									$finalPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

									$GUIUnPackCreateASCPWD.Text = $finalPass
								} catch {
									$UI_Main_Error.Text = $lang.PwdDecfailed
									$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
								}
							}
						}
					}
					"False" {
						$UI_Main_Pass_Permanent.Checked = $False
					}
				}
			} else {
				Save_Dynamic -regkey "Solutions\GPG" -name "PwdPermanent" -value "True"
				$UI_Main_Pass_Permanent.Checked = $True
			}

			if ($UI_Main_Create_ASC.Checked) {
				$UI_Main_Create_ASC_Panel.Enabled = $True
			} else {
				$UI_Main_Create_ASC_Panel.Enabled = $False
			}
		} else {
			$UI_Main_Create_ASC.Enabled = $True
			$UI_Main_Create_ASC.Checked = $False
			$UI_Main_Create_ASC_Panel.Enabled = $False

			$UI_Main_Error.Text = $lang.NoPGPKey
			$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
		}

		if ($UI_Main_Create_ASC.Enabled) {
			if ($UI_Main_Create_ASC.Checked) {
				$UI_Main_Create_ASC_Panel.Enabled = $True
			} else {
				$UI_Main_Create_ASC_Panel.Enabled = $False
			}
		} else {
			$UI_Main_Create_ASC_Panel.Enabled = $False
		}

		if ([string]::IsNullOrEmpty($GUIUnPackCreateASCPWD.Text)) {
			$UI_Main_Pass_Show.Checked = $True
		} else {
			$UI_Main_Pass_Show.Checked = $False
		}

		if ($UI_Main_Pass_Show.Checked) {
			$GUIUnPackCreateASCPWD.PasswordChar = (New-Object Char) # `0 and [char]0
		} else {
			$GUIUnPackCreateASCPWD.PasswordChar = "*"
		}
	} else {
		$GUIUnPackGroupGPG.Enabled = $False
		$UI_Main_Error_Icon.Image = [System.Drawing.Image]::Fromfile("$($PSScriptRoot)\..\..\..\..\Assets\icon\Error.ico")
		$UI_Main_Error.Text += "$($lang.SoftIsInstl -f "gpg4win")"
	}

	<#
		.Allow open windows to be on top
		.允许打开的窗口后置顶
	#>
	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions" -Name "TopMost" -ErrorAction SilentlyContinue) {
		switch (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions" -Name "TopMost" -ErrorAction SilentlyContinue) {
			"True" { $UI_Main.TopMost = $True }
		}
	}

	$UI_Main.ShowDialog() | Out-Null
}


Function UnPack_Compression_Process
{
	param
	(
		$Path
	)

	ForEach ($item in $BuildTypeUnpack) {
		UnPack_Compression_Create_Format -Path $Path -Type $item
	}
}

Function UnPack_Compression_Create_Format
{
	Param
	(
		$Path,
		$Type
	)

	$Verify_Install_Path = Get_Zip -Run "7z.exe"
	if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
		Check_Folder -chkpath $TempFolderUnPack
		Push-Location $Path

		switch ($Type) {
			"zip" {
				Write-Host "  * $($UnPackName).zip"
				Write-Host "    " -NoNewline
				Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black
				if ($Script:BackupSoluionsExclude) {
					$arguments = @(
						"a",
						"-tzip",
						"""$($TempFolderUnPack)\$($UnPackName).zip""",
						"$($ArchiveExcludeUnPack)",
						"*.*",
						"-mcu=on",
						"-r",
						"-mx9";
					)
				} else {
					$arguments = @(
						"a",
						"-tzip",
						"""$($TempFolderUnPack)\$($UnPackName).zip""",
						"*.*",
						"-mcu=on",
						"-r",
						"-mx9";
					)
				}
				Start-Process -FilePath $Verify_Install_Path -argument $arguments -Wait -WindowStyle Minimized
				Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White

				Write-Host "`n  * latest.zip"
				if ($UI_Create_Latest_Zip.Checked) {
					remove-item -path "$($UnPackSaveTo)\latest.zip.asc" -force -ErrorAction SilentlyContinue
					remove-item -path "$($UnPackSaveTo)\latest.zip.sha256" -force -ErrorAction SilentlyContinue
					remove-item -path "$($UnPackSaveTo)\latest.zip" -force -ErrorAction SilentlyContinue

					Write-Host "    " -NoNewline
					Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black
					Copy-Item "$($TempFolderUnPack)\$($UnPackName).zip" -Destination "$($TempFolderUnPack)\latest.zip" -ErrorAction SilentlyContinue
					Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
				} else {
					Write-Host "    $($lang.SkipCreate): latest.zip"
				}

				Write-Host
			}
			"tar" {
				Write-Host "  * $($UnPackName).tar"
				Write-Host "    " -NoNewline
				Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black
				if ($Script:BackupSoluionsExclude) {
					$arguments = @(
						"a",
						"""$($TempFolderUnPack)\$($UnPackName).tar""",
						"$($ArchiveExcludeUnPack)",
						"*.*",
						"-r";
					)
				} else {
					$arguments = @(
						"a",
						"""$($TempFolderUnPack)\$($UnPackName).tar""",
						"$($ArchiveExcludeUnPack)",
						"*.*",
						"-r";
					)
				}
				Start-Process -FilePath $Verify_Install_Path -argument $arguments -Wait -WindowStyle Minimized
				Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White

				Write-Host
			}
			"xz" {
				Write-Host "  * $($UnPackName).tar.xz"
				Write-Host "    " -NoNewline
				Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black
				if (Test-Path -Path "$($TempFolderUnPack)\$($UnPackName).tar") {
					$arguments = @(
						"a",
						"""$($TempFolderUnPack)\$($UnPackName).tar.xz""",
						"""$($TempFolderUnPack)\$($UnPackName).tar""",
						"-mf=bcj",
						"-mx9";
					)

					Start-Process -FilePath $Verify_Install_Path -argument $arguments -Wait -WindowStyle Minimized
					Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
				} else {
					Write-Host "$($lang.SkipCreate): $UnPackName.tar"
				}

				Write-Host
			}
			"gz" {
				Write-Host "  * $($UnPackName).tar.gz"
				Write-Host "    " -NoNewline
				Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black
				if (Test-Path -Path "$($TempFolderUnPack)\$($UnPackName).tar") {
					$arguments = @(
						"a",
						"-tgzip",
						"""$($TempFolderUnPack)\$($UnPackName).tar.gz""",
						"""$($TempFolderUnPack)\$($UnPackName).tar""",
						"-mx9";
					)

					Start-Process -FilePath $Verify_Install_Path -argument $arguments -Wait -WindowStyle Minimized
					Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
				} else {
					Write-Host "$($lang.SkipCreate): $UnPackName.tar"
				}

				Write-Host
			}
		}
	} else {
		Write-Host "  $($lang.SoftIsInstl -f "7-Zip")`n" -ForegroundColor Green
	}
}

Function Unpack_API_Process_Rule_Name
{
	param (
		$RuleName
	)
	
	Write-Host "  $($lang.RuleName): " -NoNewline -ForegroundColor Yellow
	Write-Host $RuleName -ForegroundColor Green

	if (Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($RuleName)" -Name "Path" -ErrorAction SilentlyContinue) {
		$GetImportFileName = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions\Unpack\API\Custom\$($RuleName)" -Name "Path" -ErrorAction SilentlyContinue

		Write-Host "  $($lang.Filename): " -NoNewline -ForegroundColor Yellow
		
		If ([String]::IsNullOrEmpty($GetImportFileName)) {
			Write-Host "$($lang.Select_Path), $($lang.UpdateUnavailable)" -BackgroundColor DarkRed -ForegroundColor White
		} else {
			Write-Host $GetImportFileName -ForegroundColor Green

			write-host
			write-host "  " -NoNewline
			Write-Host " $($lang.Import) " -NoNewline -BackgroundColor White -ForegroundColor Black
			if (Test-Path -Path $GetImportFileName -PathType leaf) {
				Write-Host " $($lang.UpdateAvailable) " -BackgroundColor DarkGreen -ForegroundColor White
				Write-Host "  $('-' * 80)"

				$arguments = @(
					"-ExecutionPolicy",
					"ByPass",
					"-File",
					"""$($GetImportFileName)"""
				)

				if ((Get-ItemProperty -Path "HKCU:\SOFTWARE\$($Global:Author)\Solutions" -ErrorAction SilentlyContinue).'ShowCommand' -eq "True") {
					Write-Host "  $($lang.Command)" -ForegroundColor Yellow
					Write-Host "  $('-' * 80)"
					Write-Host "  Start-Process -FilePath 'powershell' -ArgumentList '$($Arguments)'" -ForegroundColor Green
					Write-Host "  $('-' * 80)"
				}

				Start-Process "powershell" -ArgumentList $arguments -Verb RunAs -Wait -WindowStyle Minimized

				Write-Host
				Write-Host "  $('-' * 80)"
				Write-Host "  $($lang.Filename): " -NoNewline -ForegroundColor Yellow
				Write-Host $GetImportFileName -ForegroundColor Green

				Write-Host "  " -NoNewline
				Write-Host " $($lang.Running) " -NoNewline -BackgroundColor White -ForegroundColor Black
				Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
			} else {
				Write-Host " $($lang.NoInstallImage) " -BackgroundColor DarkRed -ForegroundColor White
			}
		}
	} else {
		Write-Host "  $($lang.NoWork)" -ForegroundColor Red
	}
}

Function UnPack_Create_SHA256_GPG
{
	param
	(
		$Path
	)

	remove-item -path "$($path)\*.tar" -force -ErrorAction SilentlyContinue

	$NewBuildTypeUnpack = @()
	ForEach ($item in $BuildTypeUnpack) {
		$NewBuildTypeUnpack += "*.$($item)"
	}

	Get-ChildItem $Path -Recurse -Include ($UnPackigtype + $NewBuildTypeUnpack) -ErrorAction SilentlyContinue | ForEach-Object {
		if (Test-Path -Path $_.FullName -PathType leaf) {
			Write-Host "  $($lang.Filename): " -NoNewline -ForegroundColor Yellow
			Write-Host $_.FullName -ForegroundColor Green
		}
	}
	Write-Host

	Get-ChildItem $Path -Recurse -Include ($UnPackigtype + $NewBuildTypeUnpack) -ErrorAction SilentlyContinue | ForEach-Object {
		$fullnewpath = $_.FullName
		$fullnewpathasc = "$($_.FullName).asc"
		$fullnewpathsha256 = "$($_.FullName).sha256"
		$shortnamesha256 = [IO.Path]::GetFileName($_.FullName)

		Write-Host "  * $($fullnewpath)"

		if ($Script:UnPackCreateASC) {
			$Verify_Install_Path = Get_ASC -Run "gpg.exe"
			if (Test-Path -Path $Verify_Install_Path -PathType leaf) {
				Write-Host "    $($fullnewpathasc)"

				Write-Host "    " -NoNewline
				Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black

				if ($Script:UnPackCreateASCClean) {
					Remove-Item -path $fullnewpathasc -Force -ErrorAction SilentlyContinue
				}

				if (Test-Path -Path $fullnewpathasc -PathType leaf) {
					Write-Host $lang.Existed -ForegroundColor Green
				} else {
					Remove-Item -path $fullnewpathasc -Force -ErrorAction SilentlyContinue

					if ([string]::IsNullOrEmpty($Global:secure_password)) {
						Start-Process -FilePath $Verify_Install_Path -argument "--local-user ""$($UI_Main_Create_ASCSign.Text)"" --output ""$($fullnewpathasc)"" --detach-sign ""$($fullnewpath)""" -Wait -WindowStyle Minimized
					} else {
						Start-Process -FilePath $Verify_Install_Path -argument "--pinentry-mode loopback --passphrase ""$($Global:secure_password)"" --local-user ""$($UI_Main_Create_ASCSign.Text)"" --output ""$($fullnewpathasc)"" --detach-sign ""$($fullnewpath)""" -Wait -WindowStyle Minimized
					}

					if (Test-Path -Path $fullnewpathasc -PathType Leaf) {
						Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
					} else {
						Write-Host " $($lang.Failed) " -BackgroundColor DarkRed -ForegroundColor White
					}
				}

				Write-Host
			} else {
				Write-Host "    $($lang.SoftIsInstl -f "gpg4win")`n" -ForegroundColor Red
			}
		}

		if ($Script:UnPackCreateSHA256) {
			Write-Host "    $($fullnewpath).sha256"
			Write-Host "    " -NoNewline
			Write-Host " $($lang.Uping) " -NoNewline -BackgroundColor White -ForegroundColor Black

			if ($Script:UnPackCreateSHA256Clean) {
				Remove-Item -Force -ErrorAction SilentlyContinue $fullnewpathsha256
			}

			if (Test-Path -Path $fullnewpathsha256 -PathType leaf) {
				Write-Host " $($lang.Existed) " -BackgroundColor DarkRed -ForegroundColor White
			} else {
				Remove-Item -Force -ErrorAction SilentlyContinue $fullnewpathsha256

				$calchash = (Get-FileHash -Path $fullnewpath -Algorithm SHA256)
				"$($calchash.Hash)  $($shortnamesha256)" | Out-File -FilePath $fullnewpathsha256 -Encoding ASCII -ErrorAction SilentlyContinue
				Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
			}

			Write-Host
		}
	}
}

Function Update_Create_Version
{
	param
	(
		[string]$SaveTo,
		[string]$Buildstring,
		[string]$CurrentVersion,
		[string]$LowVer
	)

	$New_latest_Json_File = Join-Path -Path $SaveTo -ChildPath "latest.json"

@"
{
	"author": {
		"name": "$($Global:Author)",
		"url":  "$((Get-Module -Name Solutions).HelpInfoURI)"
	},
	"version": {
		"buildstring": "$($Buildstring)",
		"version":     "$($CurrentVersion)",
		"minau":       "$($LowVer)"
	},
	"changelog": {
		"title": "$($Global:Author)'s Solutions - Change log",
		"log":   "  - Allows automatic background update checks, new feature. *New\n  - Mounting of Install.esd is now supported; DISM version must be greater than 26100.2454; *New\n  - Allows adding 'search sources, directories, and RAMDISK' to Windows Defender exclusions; *New\n  - Added Windows 11 25H2 video tutorials, autonomous driving solutions, and packaging scripts. * New\n  - Deleted the outdated 23H2 packaging tutorials. * Del\n  - Routing function: self-healing sequence after adding * New\n  - API: Application Programming Interface, Shortcut: (API *) * New\n  - New shortcut commands and dynamic UI * New"
	},
	"url": "$((Get-Module -Name Solutions).HelpInfoURI)/download/solutions/latest.zip"
}
"@ | Out-File -FilePath $New_latest_Json_File -Encoding Ascii

	Write-Host "`n  $($lang.Wim_Rule_Check)" -ForegroundColor Yellow
	Write-Host "  $('-' * 80)"
	Write-Host "  $($lang.Filename): " -NoNewline -ForegroundColor Yellow
	Write-Host $New_latest_Json_File -ForegroundColor Green

	Write-Host "  " -NoNewline
	Write-Host " $($lang.Wim_Rule_Verify) " -NoNewline -BackgroundColor White -ForegroundColor Black
	try {
		$Autopilot = Get-Content -Raw -Path $New_latest_Json_File | ConvertFrom-Json
		Write-Host " $($lang.Done) " -BackgroundColor DarkGreen -ForegroundColor White
	} catch {
		Write-Host " $($lang.Failed) " -BackgroundColor DarkRed -ForegroundColor White
	}
}

Function UnPack_Move_To
{
	param
	(
		$OldPath,
		$NewPath
	)
	Check_Folder -chkpath $NewPath

	Get-ChildItem $OldPath -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
		Move-Item -Path $_.FullName -Destination $NewPath -ErrorAction SilentlyContinue -force | Out-Null
	}
	remove-item -path $OldPath -Recurse -force -ErrorAction SilentlyContinue
}