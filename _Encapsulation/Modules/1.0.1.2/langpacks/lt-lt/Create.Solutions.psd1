﻿ConvertFrom-StringData -StringData @'
	# lt-LT
	# Lithuanian (Lithuania)

	IsCreate                        = Sukurti
	Solution                        = Sprendimas
	EnabledSoftwarePacker           = Kolekcija
	EnabledUnattend                 = Reikėtų atsakyti iš anksto
	EnabledEnglish                  = Diegimo variklis
	UnattendSelectVer               = Pasirinkite sprendimo kalbą "Atsakymas į".
	UnattendLangPack                = Pasirinkite kalbos paketą "Sprendimas".
	UnattendSelectSingleInstl       = Daugiakalbis, pasirenkamas diegiant
	UnattendSelectMulti             = Daugiakalbis
	UnattendSelectDisk              = Pasirinkite Autounattend.xml sprendimą
	UnattendSelectSemi              = Pusiau automatinis galioja visiems montavimo būdams
	UnattendSelectUefi              = UEFI įdiegiamas automatiškai ir jį reikia nurodyti
	UnattendSelectLegacy            = Legacy įdiegiamas automatiškai ir turi būti nurodytas
	NeedSpecified                   = Pasirinkite, ką reikia nurodyti:
	OOBESetupOS                     = Diegimo sąsaja
	OOBEProductKey                  = Produkto raktas
	OOBEOSImage                     = Pasirinkite operacinę sistemą, kurią norite įdiegti
	OOBEEula                        = Sutikite su licencijos sąlygomis
	OOBEDoNotServerManager          = Serverio tvarkyklė automatiškai nepasileidžia prisijungus
	OOBEIE                          = "Internet Explorer" patobulintos saugos konfigūracija
	OOBEIEAdmin                     = Uždaryti "Administratorius"
	OObeIEUser                      = Uždaryti "Vartotojai"

	OOBE_Init_User                  = Pradinis vartotojas išpakavimo metu
	OOBE_init_Create                = Sukurkite pasirinktinius vartotojus
	OOBE_init_Specified             = Nurodykite vartotoją
	OOBE_Init_Autologin             = Automatinis prisijungimas

	InstlMode                       = Montavimo būdas
	Business                        = Verslo versija
	BusinessTips                    = Priklausomai nuo EI.cfg, automatiniam diegimui reikia nurodyti indekso numerį.
	Consumer                        = Vartotojų versija
	ConsumerTips                    = Jis nepriklauso nuo EI.cfg Automatiniam diegimui pristabdant reikia nurodyti indekso numerį.
	CreateUnattendISO               = [ISO]:\\Autounattend.xml
	CreateUnattendISOSources        = [ISO]:\\sources\\Unattend.xml
	CreateUnattendISOSourcesOEM     = [ISO]:\\sources\\$OEM$\\$$\\Panther\\unattend.xml
	CreateUnattendPanther           = [pritvirtinti prie]:\\Windows\\Panther\\unattend.xml

	VerifyName                      = Pridėti prie sistemos disko pagrindinio katalogo pavadinimą
	VerifyNameUse                   = Patikrinkite, ar katalogo pavadinime negali būti
	VerifyNameTips                  = Leidžiamas tik angliškų raidžių ir skaičių derinys, kuriame negali būti: tarpų, ilgis negali būti didesnis nei 260 simbolių, \\ / : * ? & @ ! "" < > |
	VerifyNumberFailed              = Patvirtinti nepavyko, įveskite teisingą numerį.
	VerifyNameSync                  = Nustatyti katalogo pavadinimą kaip pagrindinį vartotojo vardą
	VerifyNameSyncTips              = Administratorius nebenaudojamas.
	ManualKey                       = Pasirinkite arba įveskite produkto kodą rankiniu būdu
	ManualKeyTips                   = Įveskite galiojantį produkto kodą. Jei pasirinktas regionas nepasiekiamas, apsilankykite oficialioje "Microsoft" svetainėje ir patikrinkite.
	ManualKeyError                  = Įvestas produkto kodas neteisingas.
	KMSLink1                        = KMS kliento nustatymų raktas
	KMSUnlock                       = Rodyti visus žinomus KMS serijos numerius
	KMSSelect                       = Pasirinkite VOL serijos numerį
	KMSKey                          = Serijos numeris
	KMSKeySelect                    = Pakeiskite gaminio serijos numerį
	ClearOld                        = Išvalykite senus failus
	SolutionsSkip                   = Praleiskite sprendimo kūrimą
	SolutionsTo                     = Pridėti "sprendimą" prie:
	SolutionsToMount                = Sumontuotas arba įtrauktas į eilę
	SolutionsToError                = Kai kurios funkcijos buvo išjungtos. Jei reikia priversti jas naudoti, spustelėkite mygtuką "Atrakinti".\n\n
	UnlockBoot                      = Atrakinti
	SolutionsToSources              = Namų katalogas, [ISO]:\\Sources\\$OEM$
	SolutionsScript                 = Pasirinkite "Deployment Engine" versiją
	SolutionsEngineRegionaUTF8      = Beta: pasaulinis kalbų palaikymas naudojant Unicode UTF-8
	SolutionsEngineRegionaUTF8Tips  = Atrodo, kad atidarius gali kilti naujų problemų. Nerekomenduojama.
	SolutionsEngineRegionaling      = Keisti į naują lokalę:
	SolutionsEngineRegionalingTips  = Pakeiskite sistemos lokalę, kuri turi įtakos visoms vartotojo abonementams kompiuteryje.
	SolutionsEngineRegional         = Keisti sistemos lokalę
	SolutionsEngineRegionalTips     = Visuotinis numatytasis: {0}, pakeistas į: {1}
	SolutionsEngineCopyPublic       = Nukopijuokite viešą {0} į diegimą
	SolutionsEngineCopyOpen         = Naršyti viešosios saugyklos {0} vietą
	EnglineDoneReboot               = Iš naujo paleiskite kompiuterį
	SolutionsTipsArm64              = Pageidautina, kad paketas arm64, ir jūs pasirenkate eilės tvarka: x64, x86.
	SolutionsTipsAMD64              = Pirmenybė teikiama x64 paketams, tvarka: x86.
	SolutionsTipsX86                = Pridedami tik x86 paketai.
	SolutionsReport                 = Sukurkite išankstinio diegimo ataskaitą
	SolutionsDeployOfficeInstall    = Įdiekite "Microsoft Office" diegimo paketą
	SolutionsDeployOfficeChange     = Keisti diegimo konfigūraciją
	SolutionsDeployOfficePre        = Iš anksto įdiegta paketo versija
	SolutionsDeployOfficeNoSelect   = Nepasirinktas joks "Office" išankstinio diegimo paketas
	SolutionsDeployOfficeVersion    = {0} versija
	SolutionsDeployOfficeOnly       = Išsaugokite nurodytus kalbų paketus
	SolutionsDeployOfficeSync       = Išsaugokite kalbos sinchronizavimą su diegimo konfigūracija
	SolutionsDeployOfficeSyncTips   = Po sinchronizavimo diegimo scenarijus negali nustatyti pageidaujamos kalbos.
	DeploySyncMainLanguage          = Sinchronizuoti su pagrindine kalba
	SolutionsDeployOfficeTo         = Diegimo paketą įdiekite į
	SolutionsDeployOfficeToPublic   = Viešasis darbalaukis
	DeployPackage                   = Įdiekite pasirinktinį surinkimo paketą
	DeployPackageSelect             = Pasirinkite išankstinio surinkimo paketą
	DeployPackageTo                 = Įdiekite išankstinio surinkimo paketą į
	DeployPackageToRoot             = Sistemos diskas:\\Package
	DeployPackageToSolutions        = Sprendimo namų kataloge
	DeployTimeZone                  = Laiko juosta
	DeployTimeZoneChange            = Keisti laiko juostą
	DeployTimeZoneChangeTips        = Pagal kalbos sritį nustatykite numatytąją laiko sritį, kurioje turėtų būti atsakyta į išankstinius atsakymus.

	Deploy_Tags                     = Diegimo žyma
	FirstExpProcess                 = Patirtis pirmą kartą, diegimo metu būtinos sąlygos:
	FirstExpProcessTips             = Atlikę būtinas sąlygas, iš naujo paleiskite kompiuterį, kad išspręstumėte problemą, susijusią su reikalavimu paleisti iš naujo, kad įsigaliotų.
	FirstExpFinish                  = Patirtis pirmą kartą, atlikus būtinas sąlygas
	FirstExpSyncMark                = Leisti visuotinę paiešką ir diegimo žymų sinchronizavimą
	FirstExpUpdate                  = Leisti automatinius atnaujinimus
	FirstExpDefender                = Pridėti namų katalogą prie Apginti neįtrauktus katalogus
	FirstExpSyncLabel               = Sistemos disko tomo etiketė: namų katalogo pavadinimas yra toks pat
	MultipleLanguages               = Kai susiduriate su keliomis kalbomis:
	NetworkLocationWizard           = Tinklo vietos vedlys
	PreAppxCleanup                  = Blokuoti Appx valymo priežiūros užduotis
	LanguageComponents              = Neleiskite išvalyti nenaudojamų funkcijų kalbų paketų pagal poreikį
	PreventCleaningUnusedLP         = Neleiskite išvalyti nenaudojamų kalbų paketų
	FirstExpContextCustomize        = Pridėkite asmeninį kontekstinį meniu
	FirstExpContextCustomizeShift   = Laikykite nuspaudę klavišą Shift ir spustelėkite dešinįjį pelės klavišą

	FirstExpFinishTips              = Pasibaigus diegimui, nėra jokių svarbių įvykių. Rekomenduojama atšaukti.
	FirstExpFinishPopup             = Atidarykite pagrindinę diegimo variklio sąsają
	FirstExpFinishOnDemand          = Leisti pirmą peržiūrą, kaip planuota
	SolutionsEngineRestricted       = Atkurti "Powershell" vykdymo politiką: apribota
	EnglineDoneClearFull            = Ištrinkite visą sprendimą
	EnglineDoneClear                = Ištrinkite diegimo variklį ir pasilikite kitus

	Unattend_Auto_Fix_Next          = Kai kitą kartą susidursite su ja, automatiškai pasirinkite reikiamus elementus, kad automatiškai tai ištaisytumėte.
	Unattend_Auto_Fix               = Automatiškai taisyti, kai nepasirinktos būtinos sąlygos
	Unattend_Auto_Fix_Tips          = Pridedant diegimo variklį ir nepasirenkant pirmosios paleidimo komandos, ji automatiškai pataisoma ir pasirenkama: Powershell vykdymo politika: paleiskite diegimo variklį be jokių apribojimų.
	Unattend_Version_Tips           = Pasirinktinai įtraukti tik, naudokite numatytuosius nustatymus, kad palaikytumėte ARM64, x64, x86.
	First_Run_Commmand              = Komandos paleisti pirmą kartą diegiant
	First_Run_Commmand_Setting      = Pasirinkite komandą, kurią norite paleisti
	Command_Not_Class               = Filtruojant nebebus automatiškai skirstoma į kategorijas
	Command_WinSetup                = Windows diegimas
	Command_WinPE                   = Windows PE
	Command_Tips                    = Priskirkite "First Run App": "Windows Installation", "Windows PE".\n\nAtminkite, kad kai pridedamas diegimo variklis, pirmą kartą paleisdami turite patikrinti šiuos dalykus: "Powershell" vykdymo politika: apribota, leisti paleisti diegimo variklio scenarijus.
	Waring_Not_Select_Command       = Pridedant diegimo variklį, nebuvo pasirinkta "Powershell" vykdymo politika: Nenustatykite jokių apribojimų ir leiskite paleisti diegimo variklio scenarijų. Pasirinkite jį ir bandykite dar kartą arba spustelėkite "Spartusis taisymas nepasirinktas".
	Quic_Fix_Not_Select_Command     = Greitas taisymas nėra parinktis

	PowerShell_Unrestricted         = Powershell vykdymo politika: jokių apribojimų
	Allow_Running_Deploy_Engine     = Leisti paleisti diegimo variklio scenarijus
	Bypass_TPM                      = TPM patikrinimų aplenkimas diegimo metu
'@