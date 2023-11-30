# Inbox appx 来源
# Auto = 自动搜索本地所有磁盘，默认；
# 自定义路径，例如指定为 F 盘：$ISO = "F:\packages"
$ISO = "Auto"

# 挂载 Install 到
$Mount = "D:\OS_11_Custom\Install\Install\Mount"

# 架构
$Arch = "x64"

try {
    Write-host "`n   Offline image version: " -NoNewline
    $Current_Edition_Version = (Get-WindowsEdition -Path $Mount).Edition
    Write-Host $Current_Edition_Version -ForegroundColor Green
} catch {
    Write-Host "Error" -ForegroundColor Red
    Write-Host "   $($_)" -ForegroundColor Yellow
    return
}

$Pre_Config_Rules = @{
    Edition = @(
        #region CloudEdition
        @{
            Name = @( "CloudEdition"; )
            Apps = @(
                "Microsoft.UI.Xaml.2.3"
                "Microsoft.UI.Xaml.2.4"
                "Microsoft.UI.Xaml.2.7"
                "Microsoft.UI.Xaml.2.8"
                "Microsoft.NET.Native.Framework.2.2"
                "Microsoft.NET.Native.Runtime.2.2"
                "Microsoft.VCLibs.140.00"
                "Microsoft.VCLibs.140.00.UWPDesktop"
                "Microsoft.Services.Store.Engagement"
                "Microsoft.VP9VideoExtensions"
                "Clipchamp.Clipchamp"
                "Microsoft.BingNews"
                "Microsoft.BingWeather"
                "Microsoft.DesktopAppInstaller"
                "Microsoft.GetHelp"
                "Microsoft.Getstarted"
                "Microsoft.HEIFImageExtension"
                "Microsoft.HEVCVideoExtension"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.MicrosoftStickyNotes"
                "Microsoft.MinecraftEducationEdition"
                "Microsoft.Paint"
                "Microsoft.RawImageExtension"
                "Microsoft.ScreenSketch"
                "Microsoft.SecHealthUI"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Todos"
                "Microsoft.WebMediaExtensions"
                "Microsoft.WebpImageExtension"
                "Microsoft.Whiteboard"
                "Microsoft.Windows.Photos"
                "Microsoft.WindowsAlarms"
                "Microsoft.WindowsCalculator"
                "Microsoft.WindowsCamera"
                "Microsoft.WindowsFeedbackHub"
                "Microsoft.WindowsMaps"
                "Microsoft.WindowsNotepad"
                "Microsoft.WindowsSoundRecorder"
                "Microsoft.Xbox.TCUI"
                "Microsoft.XboxIdentityProvider"
                "Microsoft.XboxSpeechToTextOverlay"
                "Microsoft.ZuneMusic"
                "Microsoft.ZuneVideo"
                "MicrosoftCorporationII.QuickAssist"
            )
        }
        #endregion

        #region CloudEditionN
        @{
            Name = @( "CloudEditionN"; )
            Apps = @(
                "Microsoft.UI.Xaml.2.3"
                "Microsoft.UI.Xaml.2.4"
                "Microsoft.UI.Xaml.2.7"
                "Microsoft.UI.Xaml.2.8"
                "Microsoft.NET.Native.Framework.2.2"
                "Microsoft.NET.Native.Runtime.2.2"
                "Microsoft.VCLibs.140.00"
                "Microsoft.VCLibs.140.00.UWPDesktop"
                "Microsoft.Services.Store.Engagement"
                "Microsoft.XboxSpeechToTextOverlay"
                "Clipchamp.Clipchamp"
                "Microsoft.BingNews"
                "Microsoft.BingWeather"
                "Microsoft.DesktopAppInstaller"
                "Microsoft.GetHelp"
                "Microsoft.Getstarted"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.MicrosoftStickyNotes"
                "Microsoft.MinecraftEducationEdition"
                "Microsoft.Paint"
                "Microsoft.ScreenSketch"
                "Microsoft.SecHealthUI"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Whiteboard"
                "Microsoft.Windows.Photos"
                "Microsoft.WindowsAlarms"
                "Microsoft.WindowsCalculator"
                "Microsoft.WindowsCamera"
                "Microsoft.WindowsFeedbackHub"
                "Microsoft.WindowsMaps"
                "Microsoft.WindowsNotepad"
                "Microsoft.XboxIdentityProvider"
                "MicrosoftCorporationII.QuickAssist"
            )
        }
        #endregion

        #region Group 3
        @{
            Name = @( "Core"; "CoreN"; "CoreSingleLanguage"; )
            Apps = @(
                "Microsoft.UI.Xaml.2.3"
                "Microsoft.UI.Xaml.2.4"
                "Microsoft.UI.Xaml.2.7"
                "Microsoft.UI.Xaml.2.8"
                "Microsoft.NET.Native.Framework.2.2"
                "Microsoft.NET.Native.Runtime.2.2"
                "Microsoft.VCLibs.140.00"
                "Microsoft.VCLibs.140.00.UWPDesktop"
                "Microsoft.Services.Store.Engagement"
                "Microsoft.HEIFImageExtension"
                "Microsoft.HEVCVideoExtension"
                "Microsoft.SecHealthUI"
                "Microsoft.VP9VideoExtensions"
                "Microsoft.WebpImageExtension"
                "Microsoft.WindowsStore"
                "Microsoft.GamingApp"
                "Microsoft.MicrosoftStickyNotes"
                "Microsoft.Paint"
                "Microsoft.PowerAutomateDesktop"
                "Microsoft.ScreenSketch"
                "Microsoft.WindowsNotepad"
                "Microsoft.WindowsTerminal"
                "Clipchamp.Clipchamp"
                "Microsoft.MicrosoftSolitaireCollection"
                "Microsoft.WindowsAlarms"
                "Microsoft.WindowsFeedbackHub"
                "Microsoft.WindowsMaps"
                "Microsoft.ZuneMusic"
                "Microsoft.BingNews"
                "Microsoft.BingWeather"
                "Microsoft.DesktopAppInstaller"
                "Microsoft.WindowsCamera"
                "Microsoft.Getstarted"
                "Microsoft.Cortana"
                "Microsoft.GetHelp"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.People"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Todos"
                "Microsoft.WebMediaExtensions"
                "Microsoft.Windows.Photos"
                "Microsoft.WindowsCalculator"
                "Microsoft.windowscommunicationsapps"
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
        #endregion

        #region Group 4
        @{
            Name = @( "Education"; "Professional"; "ProfessionalEducation"; "ProfessionalWorkstation"; "Enterprise"; "IoTEnterprise"; "ServerRdsh"; )
            Apps = @(
                "Microsoft.UI.Xaml.2.3"
                "Microsoft.UI.Xaml.2.4"
                "Microsoft.UI.Xaml.2.7"
                "Microsoft.UI.Xaml.2.8"
                "Microsoft.NET.Native.Framework.2.2"
                "Microsoft.NET.Native.Runtime.2.2"
                "Microsoft.VCLibs.140.00"
                "Microsoft.VCLibs.140.00.UWPDesktop"
                "Microsoft.Services.Store.Engagement"
                "Microsoft.HEIFImageExtension"
                "Microsoft.HEVCVideoExtension"
                "Microsoft.SecHealthUI"
                "Microsoft.VP9VideoExtensions"
                "Microsoft.WebpImageExtension"
                "Microsoft.WindowsStore"
                "Microsoft.GamingApp"
                "Microsoft.MicrosoftStickyNotes"
                "Microsoft.Paint"
                "Microsoft.PowerAutomateDesktop"
                "Microsoft.ScreenSketch"
                "Microsoft.WindowsNotepad"
                "Microsoft.WindowsTerminal"
                "Clipchamp.Clipchamp"
                "Microsoft.MicrosoftSolitaireCollection"
                "Microsoft.WindowsAlarms"
                "Microsoft.WindowsFeedbackHub"
                "Microsoft.WindowsMaps"
                "Microsoft.ZuneMusic"
                "Microsoft.BingNews"
                "Microsoft.BingWeather"
                "Microsoft.DesktopAppInstaller"
                "Microsoft.WindowsCamera"
                "Microsoft.Getstarted"
                "Microsoft.Cortana"
                "Microsoft.GetHelp"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.People"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Todos"
                "Microsoft.WebMediaExtensions"
                "Microsoft.Windows.Photos"
                "Microsoft.WindowsCalculator"
                "Microsoft.windowscommunicationsapps"
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
        #endregion

        #region Group 5
        @{
            Name = @( "EnterpriseN"; "EnterpriseGN"; "EnterpriseSN"; "ProfessionalN"; "EducationN"; "ProfessionalWorkstationN"; "ProfessionalEducationN"; "CloudN"; "CloudEN"; "CloudEditionLN"; "StarterN" )
            Apps = @(
                "Microsoft.UI.Xaml.2.3"
                "Microsoft.UI.Xaml.2.4"
                "Microsoft.UI.Xaml.2.7"
                "Microsoft.UI.Xaml.2.8"
                "Microsoft.NET.Native.Framework.2.2"
                "Microsoft.NET.Native.Runtime.2.2"
                "Microsoft.VCLibs.140.00"
                "Microsoft.VCLibs.140.00.UWPDesktop"
                "Microsoft.Services.Store.Engagement"
                "Microsoft.SecHealthUI"
                "Microsoft.WindowsStore"
                "Microsoft.MicrosoftStickyNotes"
                "Microsoft.Paint"
                "Microsoft.PowerAutomateDesktop"
                "Microsoft.ScreenSketch"
                "Microsoft.WindowsNotepad"
                "Microsoft.WindowsTerminal"
                "Clipchamp.Clipchamp"
                "Microsoft.MicrosoftSolitaireCollection"
                "Microsoft.WindowsAlarms"
                "Microsoft.WindowsFeedbackHub"
                "Microsoft.WindowsMaps"
                "Microsoft.BingNews"
                "Microsoft.BingWeather"
                "Microsoft.DesktopAppInstaller"
                "Microsoft.WindowsCamera"
                "Microsoft.Getstarted"
                "Microsoft.Cortana"
                "Microsoft.GetHelp"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.People"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Todos"
                "Microsoft.Windows.Photos"
                "Microsoft.WindowsCalculator"
                "Microsoft.windowscommunicationsapps"
                "Microsoft.XboxGameOverlay"
                "Microsoft.XboxIdentityProvider"
                "Microsoft.XboxSpeechToTextOverlay"
                "Microsoft.YourPhone"
                "MicrosoftCorporationII.QuickAssist"
                "MicrosoftWindows.Client.WebExperience"
            )
        }
        #endregion
    )
    Rule = @(
        @{ Name = "Microsoft.UI.Xaml.2.3";                  Match = "UI.Xaml*{ARCHC}*2.3";               License = "UI.Xaml*{ARCHC}*2.3";               Dependencies = @(); }
        @{ Name = "Microsoft.UI.Xaml.2.4";                  Match = "UI.Xaml*{ARCHTag}*2.4";             License = "UI.Xaml*{ARCHTag}*2.4";             Dependencies = @(); }
        @{ Name = "Microsoft.UI.Xaml.2.7";                  Match = "UI.Xaml*{ARCHTag}*2.7";             License = "UI.Xaml*{ARCHTag}*2.7";             Dependencies = @(); }
        @{ Name = "Microsoft.UI.Xaml.2.8";                  Match = "UI.Xaml*{ARCHTag}*2.8";             License = "UI.Xaml*{ARCHTag}*2.8";             Dependencies = @(); }
        @{ Name = "Microsoft.NET.Native.Framework.2.2";     Match = "Native.Framework*{ARCHTag}*2.2";    License = "Native.Framework*{ARCHTag}*2.2";    Dependencies = @(); }
        @{ Name = "Microsoft.NET.Native.Runtime.2.2";       Match = "Native.Runtime*{ARCHTag}*2.2";      License = "Native.Runtime*{ARCHTag}*2.2";      Dependencies = @(); }
        @{ Name = "Microsoft.VCLibs.140.00";                Match = "VCLibs*{ARCHTag}";                  License = "VCLibs*{ARCHTag}";                  Dependencies = @(); }
        @{ Name = "Microsoft.VCLibs.140.00.UWPDesktop";     Match = "VCLibs*{ARCHTag}*Desktop";          License = "VCLibs*{ARCHTag}*Desktop";          Dependencies = @(); }
        @{ Name = "Microsoft.Services.Store.Engagement";    Match = "Services.Store.Engagement*{ARCHC}"; License = "Services.Store.Engagement*{ARCHC}"; Dependencies = @(); }
        @{ Name = "Microsoft.HEIFImageExtension";           Match = "HEIFImageExtension";                License = "HEIFImageExtension*";               Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.HEVCVideoExtension";           Match = "HEVCVideoExtension*{ARCHC}";        License = "HEVCVideoExtension*{ARCHC}*xml";    Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.SecHealthUI";                  Match = "SecHealthUI*{ARCHC}";               License = "SecHealthUI*{ARCHC}";               Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.VP9VideoExtensions";           Match = "VP9VideoExtensions*{ARCHC}";        License = "VP9VideoExtensions*{ARCHC}";        Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WebpImageExtension";           Match = "WebpImageExtension*{ARCHC}";        License = "WebpImageExtension*{ARCHC}";        Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsStore";                 Match = "WindowsStore";                      License = "WindowsStore";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.GamingApp";                    Match = "GamingApp";                         License = "GamingApp";                         Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.MicrosoftStickyNotes";         Match = "MicrosoftStickyNotes";              License = "MicrosoftStickyNotes";              Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Paint";                        Match = "Paint";                             License = "Paint";                             Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
        @{ Name = "Microsoft.PowerAutomateDesktop";         Match = "PowerAutomateDesktop";              License = "PowerAutomateDesktop";              Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.ScreenSketch";                 Match = "ScreenSketch";                      License = "ScreenSketch";                      Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsNotepad";               Match = "WindowsNotepad";                    License = "WindowsNotepad";                    Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.UI.Xaml.2.7"); }
        @{ Name = "Microsoft.WindowsTerminal";              Match = "WindowsTerminal";                   License = "WindowsTerminal";                   Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Clipchamp.Clipchamp";                    Match = "Clipchamp.Clipchamp";               License = "Clipchamp.Clipchamp";               Dependencies = @(); }
        @{ Name = "Microsoft.MicrosoftSolitaireCollection"; Match = "MicrosoftSolitaireCollection";      License = "MicrosoftSolitaireCollection";      Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsAlarms";                Match = "WindowsAlarms";                     License = "WindowsAlarms";                     Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.WindowsFeedbackHub";           Match = "WindowsFeedbackHub";                License = "WindowsFeedbackHub";                Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsMaps";                  Match = "WindowsMaps";                       License = "WindowsMaps";                       Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.ZuneMusic";                    Match = "ZuneMusic";                         License = "ZuneMusic";                         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "MicrosoftCorporationII.MicrosoftFamily"; Match = "MicrosoftFamily";                   License = "MicrosoftFamily";                   Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.BingNews";                     Match = "BingNews";                          License = "BingNews";                          Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.BingWeather";                  Match = "BingWeather";                       License = "BingWeather";                       Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.DesktopAppInstaller";          Match = "DesktopAppInstaller";               License = "DesktopAppInstaller";               Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.WindowsCamera";                Match = "WindowsCamera";                     License = "WindowsCamera";                     Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Getstarted";                   Match = "Getstarted";                        License = "Getstarted";                        Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Cortana";                      Match = "Cortana";                           License = "Cortana";                           Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.GetHelp";                      Match = "GetHelp";                           License = "GetHelp";                           Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.MicrosoftOfficeHub";           Match = "MicrosoftOfficeHub";                License = "MicrosoftOfficeHub";                Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.People";                       Match = "People";                            License = "People";                            Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.StorePurchaseApp";             Match = "StorePurchaseApp";                  License = "StorePurchaseApp";                  Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Todos";                        Match = "Todos";                             License = "Todos";                             Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.Services.Store.Engagement"); }
        @{ Name = "Microsoft.WebMediaExtensions";           Match = "WebMediaExtensions";                License = "WebMediaExtensions";                Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Windows.Photos";               Match = "Windows.Photos";                    License = "Windows.Photos";                    Dependencies = @("Microsoft.UI.Xaml.2.4", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsCalculator";            Match = "WindowsCalculator";                 License = "WindowsCalculator";                 Dependencies = @("Microsoft.UI.Xaml.2.8", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.windowscommunicationsapps";    Match = "WindowsCommunicationsApps";         License = "WindowsCommunicationsApps";         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.WindowsSoundRecorder";         Match = "WindowsSoundRecorder";              License = "WindowsSoundRecorder";              Dependencies = @("Microsoft.UI.Xaml.2.3", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.Xbox.TCUI";                    Match = "Xbox.TCUI";                         License = "Xbox.TCUI";                         Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.XboxGameOverlay";              Match = "XboxGameOverlay";                   License = "XboxGameOverlay";                   Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.XboxGamingOverlay";            Match = "XboxGamingOverlay";                 License = "XboxGamingOverlay";                 Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.XboxIdentityProvider";         Match = "XboxIdentityProvider";              License = "XboxIdentityProvider";              Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.XboxSpeechToTextOverlay";      Match = "XboxSpeechToTextOverlay";           License = "XboxSpeechToTextOverlay";           Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.YourPhone";                    Match = "YourPhone";                         License = "YourPhone";                         Dependencies = @("Microsoft.VCLibs.140.00", "Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.ZuneVideo";                    Match = "ZuneVideo";                         License = "ZuneVideo";                         Dependencies = @("Microsoft.UI.Xaml.2.7", "Microsoft.VCLibs.140.00"); }
        @{ Name = "MicrosoftCorporationII.QuickAssist";     Match = "QuickAssist";                       License = "QuickAssist";                       Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "MicrosoftWindows.Client.WebExperience";  Match = "WebExperience";                     License = "WebExperience";                     Dependencies = @("Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.MinecraftEducationEdition";    Match = "MinecraftEducationEdition";         License = "MinecraftEducationEdition";         Dependencies = @("Microsoft.VCLibs.140.00.UWPDesktop"); }
        @{ Name = "Microsoft.Whiteboard";                   Match = "Whiteboard";                        License = "Whiteboard";                        Dependencies = @("Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.VCLibs.140.00"); }
        @{ Name = "Microsoft.RawImageExtension";            Match = "RawImageExtension";                 License = "RawImageExtension";                 Dependencies = @(); }
    )
}

$Allow_Install_App = @()
ForEach ($item in $Pre_Config_Rules.Edition) {
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

Function Match_InBox_Apps_Install_Pack
{
    param ( $NewPath )

    <#
        .转换变量
    #>
    $NewArch  = $Arch
    $NewArchC = $Arch.Replace("AMD64", "x64")

    $NewArchCTag = $Arch.Replace("AMD64", "x64")
    if ($Arch -eq "arm64") { $NewArchCTag = "arm" }

    if ($Pre_Config_Rules.Rule.Count -gt 0) {
        ForEach ($itemInBoxApps in $Pre_Config_Rules.Rule){
            $InstallPacker = ""
            $InstallPackerCert = ""

            <#
                .替换变量
            #>
            $SearchNewStructure = $itemInBoxApps.Match.Replace("{ARCH}", $NewArch).Replace("{ARCHC}", $NewArchC).Replace("{ARCHTag}", $NewArchCTag)
            $SearchNewLicense = $itemInBoxApps.License.Replace("{ARCH}", $NewArch).Replace("{ARCHC}", $NewArchC).Replace("{ARCHTag}", $NewArchCTag)

            Get-ChildItem -Path $NewPath -Filter "*$($SearchNewStructure)*" -Include "*.appx", "*.appxbundle", "*.msixbundle" -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                if (Test-Path -Path $_.FullName -PathType Leaf) {

                    $InstallPacker = $_.FullName

                    Get-ChildItem -Path $NewPath -Filter "*$($SearchNewLicense)*" -Include *.xml -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                        $InstallPackerCert = $_.FullName
                    }

                    $Script:InBoxAppx += @{
                        Name            = $itemInBoxApps.Name;
                        Depend          = $itemInBoxApps.Dependencies;
                        Search          = $SearchNewStructure;
                        InstallPacker   = $InstallPacker;
                        Certificate     = $InstallPackerCert
                        CertificateRule = $SearchNewLicense
                    }

                    return
                }
            }
        }
    }
}

Write-host "`n   InBox Apps: Installation packages, automatic search for full disk or specified paths" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
$Script:InBoxAppx = @()
if ($ISO -eq "Auto") {
    Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue | ForEach-Object {
        $AppPath = Join-Path -Path $_.Root -ChildPath "packages" -ErrorAction SilentlyContinue
        Match_InBox_Apps_Install_Pack -NewPath $AppPath
    }
} else {
    Match_InBox_Apps_Install_Pack -NewPath $ISO
}
Write-host "   Search Complete" -ForegroundColor Green

Write-host "`n   InBox Apps: Installer Match Results" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
if ($Script:InBoxAppx.Count -gt 0) {
    Write-host "   Match successful" -ForegroundColor Green
} else {
    Write-host "   Failed match" -ForegroundColor Red
    return
}

Write-host "`n   InBox Apps: Details of the application to be installed ( $($Script:InBoxAppx.Count) item )" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
ForEach ($Rule in $Script:InBoxAppx) {
    Write-host "   Apps name: " -NoNewline; Write-host $Rule.Name -ForegroundColor Yellow
    Write-host "   Apps installer: " -NoNewline; Write-host $Rule.InstallPacker -ForegroundColor Yellow
    Write-host "   License: " -NoNewline; Write-host $Rule.Certificate -ForegroundColor Yellow
    Write-host ""
}

Write-host "`n   InBox Apps: Installation" -ForegroundColor Yellow
Write-host "   $('-' * 80)"
ForEach ($Rule in $Script:InBoxAppx) {
    Write-host "   Name: " -NoNewline; Write-host $Rule.Name -ForegroundColor Yellow
    Write-host "   $('-' * 80)"

    if($Allow_Install_App -contains $Rule.Name) {
        Write-host "   Search for apps: " -NoNewline; Write-host $Rule.InstallPacker -ForegroundColor Yellow
        Write-host "   Search for License: " -NoNewline; Write-host $Rule.Certificate -ForegroundColor Yellow

        if (Test-Path -Path $Rule.InstallPacker -PathType Leaf) {
            if (Test-Path -Path $Rule.Certificate -PathType Leaf) {
                Write-host "   License: " -NoNewline
                Write-host $Rule.Certificate -ForegroundColor Yellow
    
                Write-host "   With License".PadRight(22) -NoNewline -ForegroundColor Green
                Write-host "   Installing".PadRight(22) -NoNewline
    
                try {
                   Add-AppxProvisionedPackage -Path $Mount -PackagePath $Rule.InstallPacker -LicensePath $Rule.Certificate -ErrorAction SilentlyContinue | Out-Null
                   Write-Host "Done`n" -ForegroundColor Green
                } catch {
                    Write-Host "Failed" -ForegroundColor Red
                    Write-Host "   $($_)`n" -ForegroundColor Red
                }
            } else {
                Write-host "   No License".PadRight(22) -NoNewline -ForegroundColor Red
                Write-host "   Installing".PadRight(22) -NoNewline
    
                try {
                    Add-AppxProvisionedPackage -Path $Mount -PackagePath $Rule.InstallPacker -SkipLicense -ErrorAction SilentlyContinue | Out-Null
                    Write-Host "Done`n" -ForegroundColor Green
                } catch {
                    Write-Host "Failed" -ForegroundColor Red
                    Write-Host "   $($_)`n" -ForegroundColor Red
                }
            }
        } else {
            Write-host "   The installation package does not exist" -ForegroundColor Red
        }
    } else {
        Write-host "   Skip the installation`n" -ForegroundColor Red
    }
}