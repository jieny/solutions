$ISO = "Auto"

Function Extract_Language
{
    param
    (
        $Package,
        $SaveTo,
        $NewPath
    )

    New-Item -Path $SaveTo -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

    if ($NewPath -eq "Auto") {
        Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | ForEach-Object {
            ForEach ($item in $Language) {
                $TempFilePath = Join-Path -Path $_.Root -ChildPath $item -ErrorAction SilentlyContinue

                if (Test-Path $TempFilePath -PathType Leaf) {
                    Write-host "`n   Find: " -NoNewLine; Write-host $TempFilePath -ForegroundColor Green
                    Write-host "   Copy to: " -NoNewLine; Write-host $SaveTo
                    Copy-Item -Path $TempFilePath -Destination $SaveTo -Force
                }
            }
        }
    } else {
        ForEach ($item in $Language) {
            $TempFilePath = Join-Path -Path $NewPath -ChildPath $item -ErrorAction SilentlyContinue

            Write-host "`n   Find: " -NoNewline; Write-host $TempFilePath -ForegroundColor Green
            if (Test-Path $TempFilePath -PathType Leaf) {
                Write-host "   Copy to: " -NoNewLine; Write-host $SaveTo
                Copy-Item -Path $TempFilePath -Destination $SaveTo -Force
            } else {
                Write-host "   Not found"
            }
        }
    }

    Write-host "`n   Verify the language pack file"
    ForEach ($item in $Package) {
        $Path = "$($SaveTo)\$([IO.Path]::GetFileName($item))"

        if (Test-Path $Path -PathType Leaf) {
            Write-host "   Discover: " -NoNewLine
            Write-host $Path -ForegroundColor Green
        } else {
            Write-host "   Not found: " -NoNewLine
            Write-host $Path -ForegroundColor Red
        }
    }
}

$Language = @(
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-Fonts-Hans-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-Client-Language-Pack_x64_zh-CN.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-Basic-zh-CN-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-Handwriting-zh-CN-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-OCR-zh-CN-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-Speech-zh-CN-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-LanguageFeatures-TextToSpeech-zh-CN-Package~31bf3856ad364e35~AMD64~~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~wow64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-MediaPlayer-Package-AMD64-zh-CN.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-MediaPlayer-Package-wow64-zh-CN.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-Printing-PMCPPC-FoD-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~wow64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~AMD64~zh-CN~.cab"
    "LanguagesAndOptionalFeatures\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~zh-CN~.cab"
)
Extract_Language -Package $Language -SaveTo "D:\OS11_Custom\Install\Install\Language\zh-CN" -NewPath $ISO

$Language = @(
    "Windows Preinstallation Environment\x64\WinPE_OCs\WinPE-FontSupport-zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\lp.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-securestartup_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-atbroker_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-audiocore_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-audiodrivers_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-enhancedstorage_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-narrator_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-scripting_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-speech-tts_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-srh_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-srt_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-wds-tools_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-wmi_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-appxdeployment_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-appxpackaging_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-storagewmi_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-wifi_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-windowsupdate_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-rejuv_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-opcservices_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-hta_zh-CN.cab"
)
Extract_Language -Package $Language -SaveTo "D:\OS11_Custom\Install\WinRE\Language\zh-CN" -NewPath $ISO

$Language = @(
    "Windows Preinstallation Environment\x64\WinPE_OCs\WinPE-FontSupport-zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\lp.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\WinPE-Setup_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\WINPE-SETUP-CLIENT_zh-CN.CAB"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-securestartup_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-atbroker_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-audiocore_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-audiodrivers_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-enhancedstorage_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-narrator_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-scripting_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-speech-tts_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-srh_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-srt_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-wds-tools_zh-CN.cab"
    "Windows Preinstallation Environment\x64\WinPE_OCs\zh-CN\winpe-wmi_zh-CN.cab"
)
Extract_Language -Package $Language -SaveTo "D:\OS11_Custom\Boot\Boot\Language\zh-CN" -NewPath $ISO