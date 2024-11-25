<#
	.Help
	.帮助
#>
Function Solutions_Help
{
	Clear-Host
	Logo -Title $lang.MoreFeature


	Clear-Host
	Logo -Title $lang.Help

	Write-Host "   $($lang.Short_Cmd)" -ForegroundColor Yellow
	Write-host "   $('-' * 80)"
	Write-host "   $($lang.Event_Primary_Key)"
	Write-host "      b".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "Boot.wim"

	Write-host "      i".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "Install.wim"

	Write-host "      w".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "WinRE.wim"

	Write-host "      CPK".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Event_Primary_Key_CPK

	Write-host "`n   $($lang.SelectSettingImage)"
	write-host "      Mount".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Mount

	write-host "      Remount".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.Mount), $($lang.PleaseChoose)"

	Write-Host "      IA".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.AddTo

	Write-Host "      ID".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Del

	Write-Host "      Export".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Export_Image

	Write-Host "      Rebuild".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Rebuild

	Write-Host "      Apply".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Apply

	Write-Host "      Euwl".PadRight(18) -NoNewline -ForegroundColor Yellow

	Write-host $lang.Wim_Rule_Update
	Write-host "`n   $($lang.Unzip_Language), $($lang.Unzip_Fod)"
	Write-Host "      EL".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.LanguageExtract

	Write-host "`n   $($lang.Mounted)"
	Write-Host "      Save".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Save

	Write-Host "      Unmount".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host $lang.Unmount

	Write-Host "      ESA".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.Image_Unmount_After): " -NoNewline
	Write-Host $lang.Save -ForegroundColor Green

	Write-Host "      EDNS".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.Image_Unmount_After): " -NoNewline
	Write-Host $lang.DoNotSave -ForegroundColor Green

	Write-host "`n   $($lang.RuleOther)"
	Write-Host "      Fix".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.Repair): "
	Write-host "                  * $($lang.HistoryClearDismSave)" -ForegroundColor Green
	Write-host "                  * $($lang.Clear_Bad_Mount)" -ForegroundColor Green

	Write-host "`n   $($lang.RuleOther)"
	Write-Host "      SC".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.Solution): $($lang.IsCreate)"

	Write-Host "      Reset".PadRight(18) -NoNewline -ForegroundColor Yellow
	Write-host "$($lang.EventManagerClear)"
}