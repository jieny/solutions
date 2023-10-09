# Inbox appx 来源
# Auto = 自动搜索本地所有磁盘，默认；
# 自定义路径，例如指定为 F 盘：$ISO = "F:\packages"
$ISO = "Auto"

# 挂载 Install 到
$Mount = "D:\OS_11_Custom\Install\Install\Mount"

try {
    Write-host "`n   Offline image version: " -NoNewline
    $Current_Edition_Version = (Get-WindowsEdition -Path $Mount).Edition
    Write-Host $Current_Edition_Version -ForegroundColor Green
} catch {
    Write-Host "Error" -ForegroundColor Red
    Write-Host "   $($_)" -ForegroundColor Yellow
    return
}

$Pre_Config_Rules = @(
    @{
        Name = @(
            "Core"
            "CoreN"
            "CoreSingleLanguage"
        )
        Apps = @(
            "Microsoft.UI.Xaml.2.3"
            "Microsoft.UI.Xaml.2.4"
            "Microsoft.UI.Xaml.2.7"
            "Microsoft.NET.Native.Framework.2.2"
            "Microsoft.NET.Native.Runtime.2.2"
            "Microsoft.VCLibs.140.00"
            "Microsoft.VCLibs.140.00.UWPDesktop"
            "Microsoft.HEIFImageExtension"
            "Microsoft.HEVCVideoExtension"
            "Microsoft.SecHealthUI"
            "Microsoft.VP9VideoExtensions"
            "Microsoft.WebpImageExtension"
            "Microsoft.WindowsStore"
            "Microsoft.GamingApp"
            "Microsoft.Sticky.Notes"
            "Microsoft.Paint"
            "Microsoft.PowerAutomateDesktop"
            "Microsoft.ScreenSketch"
            "Microsoft.WindowsNotepad"
            "Microsoft.WindowsTerminal"
            "Clipchamp.Clipchamp"
            "Microsoft.Solitaire.Collection"
            "Microsoft.WindowsAlarms"
            "Microsoft.WindowsFeedbackHub"
            "Microsoft.WindowsMaps"
            "Microsoft.ZuneMusic"
            "Microsoft.BingNews"
            "Microsoft.DesktopAppInstaller"
            "Microsoft.WindowsCamera"
            "Microsoft.Getstarted"
            "Microsoft.Cortana"
            "Microsoft.BingWeather"
            "Microsoft.GetHelp"
            "Microsoft.MicrosoftOfficeHub"
            "Microsoft.People"
            "Microsoft.StorePurchaseApp"
            "Microsoft.Todos"
            "Microsoft.WebMediaExtensions"
            "Microsoft.Windows.Photos"
            "Microsoft.WindowsCalculator"
            "Microsoft.Windows.CommunicationsApps"
            "Microsoft.WindowsSoundRecorder"
            "Microsoft.Xbox.TCUI"
            "Microsoft.XboxGameOverlay"
            "Microsoft.XboxGamingOverlay"
            "Microsoft.XboxIdentityProvider"
            "Microsoft.XboxSpeechToTextOverlay"
            "Microsoft.YourPhone"
            "Microsoft.ZuneVideo"
            "MicrosoftCorporationII.QuickAssist"
            "MicrosoftWindows.Client.WebExperience"
            "Microsoft.RawImageExtension"
            "MicrosoftCorporationII.MicrosoftFamily"
        )
    }
    @{
        Name = @(
            "Education"
            "Professional"
            "ProfessionalEducation"
            "ProfessionalWorkstation"
            "Enterprise"
            "IoTEnterprise"
            "ServerRdsh"
        )
        Apps = @(
            "Microsoft.UI.Xaml.2.3"
            "Microsoft.UI.Xaml.2.4"
            "Microsoft.UI.Xaml.2.7"
            "Microsoft.NET.Native.Framework.2.2"
            "Microsoft.NET.Native.Runtime.2.2"
            "Microsoft.VCLibs.140.00"
            "Microsoft.VCLibs.140.00.UWPDesktop"
            "Microsoft.HEIFImageExtension"
            "Microsoft.HEVCVideoExtension"
            "Microsoft.SecHealthUI"
            "Microsoft.VP9VideoExtensions"
            "Microsoft.WebpImageExtension"
            "Microsoft.WindowsStore"
            "Microsoft.GamingApp"
            "Microsoft.Sticky.Notes"
            "Microsoft.Paint"
            "Microsoft.PowerAutomateDesktop"
            "Microsoft.ScreenSketch"
            "Microsoft.WindowsNotepad"
            "Microsoft.WindowsTerminal"
            "Clipchamp.Clipchamp"
            "Microsoft.Solitaire.Collection"
            "Microsoft.WindowsAlarms"
            "Microsoft.WindowsFeedbackHub"
            "Microsoft.WindowsMaps"
            "Microsoft.ZuneMusic"
            "Microsoft.BingNews"
            "Microsoft.DesktopAppInstaller"
            "Microsoft.WindowsCamera"
            "Microsoft.Getstarted"
            "Microsoft.Cortana"
            "Microsoft.BingWeather"
            "Microsoft.GetHelp"
            "Microsoft.MicrosoftOfficeHub"
            "Microsoft.People"
            "Microsoft.StorePurchaseApp"
            "Microsoft.Todos"
            "Microsoft.WebMediaExtensions"
            "Microsoft.Windows.Photos"
            "Microsoft.WindowsCalculator"
            "Microsoft.Windows.CommunicationsApps"
            "Microsoft.WindowsSoundRecorder"
            "Microsoft.Xbox.TCUI"
            "Microsoft.XboxGameOverlay"
            "Microsoft.XboxGamingOverlay"
            "Microsoft.XboxIdentityProvider"
            "Microsoft.XboxSpeechToTextOverlay"
            "Microsoft.YourPhone"
            "Microsoft.ZuneVideo"
            "MicrosoftCorporationII.QuickAssist"
            "MicrosoftWindows.Client.WebExperience"
            "Microsoft.RawImageExtension"
        )
    }
    @{
        Name = @(
            "EnterpriseN"
            "EnterpriseGN"
            "EnterpriseSN"
            "ProfessionalN"
            "EducationN"
            "ProfessionalWorkstationN"
            "ProfessionalEducationN"
            "CloudN"
            "CloudEN"
            "CloudEditionN"
            "CloudEditionLN"
            "StarterN"
        )
        Apps = @(
            "Microsoft.UI.Xaml.2.3"
            "Microsoft.UI.Xaml.2.4"
            "Microsoft.UI.Xaml.2.7"
            "Microsoft.NET.Native.Framework.2.2"
            "Microsoft.NET.Native.Runtime.2.2"
            "Microsoft.VCLibs.140.00"
            "Microsoft.VCLibs.140.00.UWPDesktop"
            "Microsoft.SecHealthUI"
            "Microsoft.WindowsStore"
            "Microsoft.Sticky.Notes"
            "Microsoft.Paint"
            "Microsoft.PowerAutomateDesktop"
            "Microsoft.ScreenSketch"
            "Microsoft.WindowsNotepad"
            "Microsoft.WindowsTerminal"
            "Clipchamp.Clipchamp"
            "Microsoft.Solitaire.Collection"
            "Microsoft.WindowsAlarms"
            "Microsoft.WindowsFeedbackHub"
            "Microsoft.WindowsMaps"
            "Microsoft.BingNews"
            "Microsoft.DesktopAppInstaller"
            "Microsoft.WindowsCamera"
            "Microsoft.Getstarted"
            "Microsoft.Cortana"
            "Microsoft.BingWeather"
            "Microsoft.GetHelp"
            "Microsoft.MicrosoftOfficeHub"
            "Microsoft.People"
            "Microsoft.StorePurchaseApp"
            "Microsoft.Todos"
            "Microsoft.Windows.Photos"
            "Microsoft.WindowsCalculator"
            "Microsoft.Windows.CommunicationsApps"
            "Microsoft.XboxGameOverlay"
            "Microsoft.XboxIdentityProvider"
            "Microsoft.XboxSpeechToTextOverlay"
            "Microsoft.YourPhone"
            "MicrosoftCorporationII.QuickAssist"
            "MicrosoftWindows.Client.WebExperience"
        )
    }
)

$Allow_Install_App = @()
ForEach ($item in $Pre_Config_Rules) {
    if ($item.Name -contains $Current_Edition_Version) {
        Write-host "`n   Match to: "-NoNewline; Write-host $Current_Edition_Version -ForegroundColor Green

        $Allow_Install_App = $item.Apps
        break
    }
}

Write-host "`n   The app to install ( $($Allow_Install_App.Count) item )" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
ForEach ($item in $Allow_Install_App) {
    Write-host "   $($item)" -ForegroundColor Green
}

$InBoxApps = @(
    @{ Name = "Microsoft.UI.Xaml.2.3"; File = "Microsoft.UI.Xaml.x64.2.3.appx"; License = ""; }
    @{ Name = "Microsoft.UI.Xaml.2.4"; File = "Microsoft.UI.Xaml.x64.2.4.appx"; License = ""; }
    @{ Name = "Microsoft.UI.Xaml.2.7"; File = "Microsoft.UI.Xaml.x64.2.7.appx"; License = ""; }
    @{ Name = "Microsoft.NET.Native.Framework.2.2"; File = "Microsoft.NET.Native.Framework.x64.2.2.appx"; License = ""; }
    @{ Name = "Microsoft.NET.Native.Runtime.2.2"; File = "Microsoft.NET.Native.Runtime.x64.2.2.appx"; License = ""; }
    @{ Name = "Microsoft.VCLibs.140.00"; File = "Microsoft.VCLibs.x64.14.00.appx"; License = ""; }
    @{ Name = "Microsoft.VCLibs.140.00.UWPDesktop"; File = "Microsoft.VCLibs.x64.14.00.UWPDesktop.appx"; License = ""; }
    @{ Name = "Microsoft.WindowsStore"; File = "Microsoft.WindowsStore_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsStore_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.HEIFImageExtension"; File = "Microsoft.HEIFImageExtension_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.HEIFImageExtension_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.HEVCVideoExtension"; File = "Microsoft.HEVCVideoExtension_8wekyb3d8bbwe.x64.appx"; License = "Microsoft.HEVCVideoExtension_8wekyb3d8bbwe.x64.xml"; }
    @{ Name = "Microsoft.SecHealthUI"; File = "Microsoft.SecHealthUI_8wekyb3d8bbwe.x64.appx"; License = "Microsoft.SecHealthUI_8wekyb3d8bbwe.x64.xml"; }
    @{ Name = "Microsoft.VP9VideoExtensions"; File = "Microsoft.VP9VideoExtensions_8wekyb3d8bbwe.x64.appx"; License = "Microsoft.VP9VideoExtensions_8wekyb3d8bbwe.x64.xml"; }
    @{ Name = "Microsoft.WebpImageExtension"; File = "Microsoft.WebpImageExtension_8wekyb3d8bbwe.x64.appx"; License = "Microsoft.WebpImageExtension_8wekyb3d8bbwe.x64.xml"; }
    @{ Name = "Microsoft.GamingApp"; File = "Microsoft.GamingApp_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.GamingApp_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Sticky.Notes"; File = "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Paint"; File = "Microsoft.Paint_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.Paint_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.PowerAutomateDesktop"; File = "Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.ScreenSketch"; File = "Microsoft.ScreenSketch_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.ScreenSketch_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsNotepad"; File = "Microsoft.WindowsNotepad_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsNotepad_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsTerminal"; File = "Microsoft.WindowsTerminal_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsTerminal_8wekyb3d8bbwe.xml"; }
    @{ Name = "Clipchamp.Clipchamp"; File = "Clipchamp.Clipchamp_yxz26nhyzhsrt.msixbundle"; License = "Clipchamp.Clipchamp_yxz26nhyzhsrt.xml"; }
    @{ Name = "Microsoft.Solitaire.Collection"; File = "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsAlarms"; File = "Microsoft.WindowsAlarms_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsAlarms_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsFeedbackHub"; File = "Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsMaps"; File = "Microsoft.WindowsMaps_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsMaps_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.ZuneMusic"; File = "Microsoft.ZuneMusic_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.ZuneMusic_8wekyb3d8bbwe.xml"; }
    @{ Name = "MicrosoftCorporationII.MicrosoftFamily"; File = "MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe.msixbundle"; License = "MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.BingNews"; File = "Microsoft.BingNews_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.BingNews_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.DesktopAppInstaller"; File = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsCamera"; File = "Microsoft.WindowsCamera_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.WindowsCamera_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Getstarted"; File = "Microsoft.Getstarted_8wekyb3d8bbwe.msixbundle"; License = "Microsoft.Getstarted_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Cortana"; File = "Microsoft.CortanaApp_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.CortanaApp_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.BingWeather"; File = "Microsoft.BingWeather_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.BingWeather_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.GetHelp"; File = "Microsoft.GetHelp_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.GetHelp_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.MicrosoftOfficeHub"; File = "Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.People"; File = "Microsoft.People_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.People_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.StorePurchaseApp"; File = "Microsoft.StorePurchaseApp_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Todos"; File = "Microsoft.Todos_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.Todos_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WebMediaExtensions"; File = "Microsoft.WebMediaExtensions_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.WebMediaExtensions_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Windows.Photos"; File = "Microsoft.Windows.Photos_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.Windows.Photos_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsCalculator"; File = "Microsoft.WindowsCalculator_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.WindowsCalculator_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Windows.CommunicationsApps"; File = "Microsoft.WindowsCommunicationsApps_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.WindowsCommunicationsApps_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.WindowsSoundRecorder"; File = "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.Xbox.TCUI"; File = "Microsoft.Xbox.TCUI_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.Xbox.TCUI_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.XboxGameOverlay"; File = "Microsoft.XboxGameOverlay_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.XboxGameOverlay_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.XboxGamingOverlay"; File = "Microsoft.XboxGamingOverlay_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.XboxGamingOverlay_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.XboxIdentityProvider"; File = "Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.XboxSpeechToTextOverlay"; File = "Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.YourPhone"; File = "Microsoft.YourPhone_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.YourPhone_8wekyb3d8bbwe.xml"; }
    @{ Name = "Microsoft.ZuneVideo"; File = "Microsoft.ZuneVideo_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.ZuneVideo_8wekyb3d8bbwe.xml"; }
    @{ Name = "MicrosoftCorporationII.QuickAssist"; File = "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe.appxbundle"; License = "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe.xml"; }
    @{ Name = "MicrosoftWindows.Client.WebExperience"; File = "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy.appxbundle"; License = "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy.xml"; }
    @{ Name = "Microsoft.RawImageExtension"; File = "Microsoft.RawImageExtension_8wekyb3d8bbwe.appxbundle"; License = "Microsoft.RawImageExtension_8wekyb3d8bbwe.xml"; }
)

Function Install_Appx
{
    param
    (
        $File,
        $License
    )

    Write-host "   $('-' * 80)"
    Write-host "   Installing: " -NoNewline; Write-host $File -ForegroundColor Yellow

    if (Test-Path -Path $File -PathType Leaf) {
        if (Test-Path -Path $License -PathType Leaf) {
            Write-host "   License: " -NoNewline
            Write-host $License -ForegroundColor Yellow

            Write-host "   With License".PadRight(22) -NoNewline -ForegroundColor Green
            Write-host "   Installing".PadRight(22) -NoNewline

            try {
               Add-AppxProvisionedPackage -Path $Mount -PackagePath $File -LicensePath $License -ErrorAction SilentlyContinue | Out-Null
               Write-Host "Done" -ForegroundColor Green
            } catch {
                Write-Host "Failed" -ForegroundColor Red
                Write-Host "   $($_)" -ForegroundColor Red
            }
        } else {
            Write-host "   No License".PadRight(22) -NoNewline -ForegroundColor Red
            Write-host "   Installing".PadRight(22) -NoNewline

            try {
                Add-AppxProvisionedPackage -Path $Mount -PackagePath $File -SkipLicense -ErrorAction SilentlyContinue | Out-Null
                Write-Host "Done" -ForegroundColor Green
            } catch {
                Write-Host "Failed" -ForegroundColor Red
                Write-Host "   $($_)" -ForegroundColor Red
            }
        }
    } else {
        Write-host "   The installation package does not exist" -ForegroundColor Red
    }
}

ForEach ($Rule in $InBoxApps) {
    Write-host "`n   Name: " -NoNewline; Write-host $Rule.Name -ForegroundColor Yellow
    Write-host "   $('-' * 80)"

    if($Allow_Install_App -contains $Rule.Name) {
        Write-host "   Search for apps: " -NoNewline; Write-host $Rule.File -ForegroundColor Yellow
        Write-host "   Search for License: " -NoNewline; Write-host $Rule.File -ForegroundColor Yellow

        if ($ISO -eq "Auto") {
            Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | ForEach-Object {
                $AppPath = Join-Path -Path $_.Root -ChildPath "packages\$($Rule.File)" -ErrorAction SilentlyContinue
                $LicensePath = Join-Path -Path $_.Root -ChildPath "packages\$($Rule.License)" -ErrorAction SilentlyContinue

                if (Test-Path $AppPath -PathType Leaf) {
                    Write-host "   $('-' * 80)"
                    Write-host "   Discover apps: " -NoNewLine; Write-host $AppPath -ForegroundColor Green

                    if (Test-Path $LicensePath -PathType Leaf) {
                        Write-host "   Discover License: " -NoNewLine; Write-host $LicensePath -ForegroundColor Green
                    } else {
                        Write-host "   License: " -NoNewLine; Write-host "Not found" -ForegroundColor Red
                    }

                    Install_Appx -File $AppPath -License $LicensePath
                    return
                }
            }
        } else {
            Install_Appx -File "$($ISO)\$($Rule.File)" -License "$($ISO)\$($Rule.License)"
        }
    } else {
        Write-host "   Skip the installation" -ForegroundColor Red
    }
}
