[CmdletBinding()]
param
(
	$Lang,
	[switch]$Help,
	[switch]$Update,
	[switch]$CU,
	[switch]$Add,
	[switch]$Remove,
	[switch]$Reset,
	[switch]$Fix,
	[switch]$History,
	[switch]$SIP,
	[switch]$Unpack,
	[switch]$CEUP,
	[switch]$zip
)

<#
	.Language
	.语言
#>
$AvailableLanguages = @(
	@{
		Tag      = "ar-SA"
		Language = @{
			Usage      = "الاستخدام:"
			Choose     = "اختر من فضلك"
			Reset      = "إعادة ضبط"
			History    = "مسح سجلات سطر الأوامر"
			Add        = "إضافة وظيفة التوجيه ، متغير النظام"
			AddOK      = "أضيف"
			AddDone    = "أضف لإكمال"
			Remove     = "حذف وظيفة التوجيه ، متغير النظام"
			RemoveDone = "تم الحذف بنجاح"
			SIP        = "البرنامج النصي لتغليف النظام"
			Unpack     = "بالة"
			ChkUpdate  = "تحقق من وجود تحديثات"
			CreateUP   = "قم بإنشاء حزمة ترقية"
			CEUP       = "إنشاء حزمة ترقية محرك النشر"
			zip        = "يتم تعبئة جميع البرامج بتنسيق ضغط الرمز البريدي"
		}
	}
	@{
		Tag      = "bg-BG"
		Language = @{
			Usage      = "Използване:"
			Choose     = "Моля избери"
			Reset      = "нулиране"
			History    = "Изчистване на записите на командния ред"
			Add        = "Добавяне на функция за маршрутизиране, променлива на системата"
			AddOK      = "Добавено"
			AddDone    = "Добавете към Complete"
			Remove     = "Изтриване на функцията за маршрутизиране, променлива на системата"
			RemoveDone = "Успешно изтрити"
			SIP        = "Скрипт на системната опаковка"
			Unpack     = "Бейл"
			ChkUpdate  = "Провери за актуализации"
			CreateUP   = "Създайте пакет за надграждане"
			CEUP       = "Създайте пакет за надграждане на машина за внедряване"
			zip        = "Целият софтуер e опакован във формат на компресия c цип"
		}
	}
	@{
		Tag      = "hr-HR"
		Language = @{
			Usage      = "Upotreba:"
			Choose     = "molim odaberite"
			Reset      = "Resetirati"
			History    = "Obrišite zapise naredbenog retka"
			Add        = "Dodaj funkciju usmjeravanja, varijablu sustava"
			AddOK      = "Dodano"
			AddDone    = "Dodaj u komplet"
			Remove     = "Izbriši funkciju usmjeravanja, varijablu sustava"
			RemoveDone = "Uspješno izbrisano"
			SIP        = "Skripta za pakiranje sustava"
			Unpack     = "Bale"
			ChkUpdate  = "Provjerite ima li ažuriranja"
			CreateUP   = "Napravite paket nadogradnje"
			CEUP       = "Stvorite paket za nadogradnju mehanizma za implementaciju"
			zip        = "Sav je softver pakiran u formatu kompresije ZIP -a"
		}
	}
	@{
		Tag      = "cs-CZ"
		Language = @{
			Usage      = "Používání:"
			Choose     = "Prosím vyber si"
			Reset      = "Resetovat"
			History    = "Vymažte záznamy příkazového řádku"
			Add        = "Přidejte funkci směrování, systémová proměnná"
			AddOK      = "Přidal"
			AddDone    = "Přidat k dokončení"
			Remove     = "Smazat směrovací funkci, systémová proměnná"
			RemoveDone = "úspěšně smazáno"
			SIP        = "Skript balení systému"
			Unpack     = "Žok"
			ChkUpdate  = "Kontrola aktualizací"
			CreateUP   = "Vytvořte balíček upgradu"
			CEUP       = "Vytvořte balíček upgradu modulu nasazení"
			zip        = "Veškerý software je zabalen do formátu kompresního zipu"
		}
	}
	@{
		Tag      = "da-DK"
		Language = @{
			Usage      = "Brug:"
			Choose     = "Vælg venligst"
			Reset      = "Nulstil"
			History    = "Ryd kommandolinjeposter"
			Add        = "Tilføj routingfunktion, systemvariabel"
			AddOK      = "Tilføjet"
			AddDone    = "Tilføj til komplet"
			Remove     = "Slet routingfunktionen, systemvariabel"
			RemoveDone = "med succes slettet"
			SIP        = "Systememballage -script"
			Unpack     = "Bale"
			ChkUpdate  = "Søg efter opdateringer"
			CreateUP   = "Opret en opgraderingspakke"
			CEUP       = "Opret en opgraderingspakke til implementeringsmotor"
			zip        = "Al software er pakket i zip -komprimeringsformat"
		}
	}
	@{
		Tag      = "nl-NL"
		Language = @{
			Usage      = "gebruik:"
			Choose     = "Gelieve te kiezen"
			Reset      = "resetten"
			History    = "Wis opdrachtregelrecords"
			Add        = "Routingfunctie toevoegen, systeemvariabele"
			AddOK      = "toegevoegd"
			AddDone    = "Toevoegen aan compleet"
			Remove     = "Verwijder de routeringsfunctie, systeemvariabele"
			RemoveDone = "met succes verwijderd"
			SIP        = "Systeemverpakkingsscript"
			Unpack     = "Baal"
			ChkUpdate  = "Controleer op updates"
			CreateUP   = "Upgradepakket maken"
			CEUP       = "Maak een upgradepakket voor de implementatie-engine"
			zip        = "Alle software is verpakt in zip -compressieformaat"
		}
	}
	@{
		Tag      = "et-EE"
		Language = @{
			Usage      = "Kasutamine:"
			Choose     = "palun vali"
			Reset      = "lähtestada"
			History    = "Tühjendage käsurea kirjed"
			Add        = "Lisage marsruutimisfunktsioon, süsteemimuutuja"
			AddOK      = "Lisatud"
			AddDone    = "Lisage lõpule"
			Remove     = "Kustuta marsruutimisfunktsioon, süsteemimuutuja"
			RemoveDone = "Edukalt kustutatud"
			SIP        = "Süsteemi pakendi skript"
			Unpack     = "Bale"
			ChkUpdate  = "Kontrolli kas uuendused on saadaval"
			CreateUP   = "Looge täienduspakett"
			CEUP       = "Looge juurutusmootori täienduspakett"
			zip        = "Kogu tarkvara on pakendatud ZIP -i tihendusvormingusse"
		}
	}
	@{
		Tag      = "fi-FI"
		Language = @{
			Usage      = "käyttö:"
			Choose     = "Valitse"
			Reset      = "nollaa"
			History    = "Tyhjennä komentorivin tietueet"
			Add        = "Lisää reititystoiminto, järjestelmämuuttuja"
			AddOK      = "Lisätty"
			AddDone    = "Lisää loppuun"
			Remove     = "Poista reititystoiminto, järjestelmämuuttuja"
			RemoveDone = "Poistettu onnistuneesti"
			SIP        = "Järjestelmäpakkauskomentosarja"
			Unpack     = "Paali"
			ChkUpdate  = "Tarkista päivitykset"
			CreateUP   = "Luo päivityspaketti"
			CEUP       = "Luo käyttöönottomoottorin päivityspaketti"
			zip        = "Kaikki ohjelmistot on pakattu postinumeroon"
		}
	}
	@{
		Tag      = "fr-CA"
		Language = @{
			Usage      = "usage:"
			Choose     = "Choisissez s'il vous plaît"
			Reset      = "réinitialiser"
			History    = "Effacer les enregistrements de ligne de commande"
			Add        = "Ajouter la fonction de routage, variable système"
			AddOK      = "ajoutée"
			AddDone    = "Ajouter à complet"
			Remove     = "Supprimer la fonction de routage, variable système"
			RemoveDone = "Supprimé avec succès"
			SIP        = "Script d'emballage système"
			Unpack     = "Balle"
			ChkUpdate  = "Vérifier les mises à jour"
			CreateUP   = "Créer un package de mise à niveau"
			CEUP       = "Créer un package de mise à niveau du moteur de déploiement"
			zip        = "Tous les logiciels sont emballés au format de compression zip"
		}
	}
	@{
		Tag      = "el-GR"
		Language = @{
			Usage      = "χρήση:"
			Choose     = "Παρακαλώ επιλέξτε"
			Reset      = "επαναφορά"
			History    = "Εκκαθάριση εγγραφών γραμμής εντολών"
			Add        = "Προσθήκη λειτουργίας δρομολόγησης, μεταβλητή συστήματος"
			AddOK      = "Προστέθηκε"
			AddDone    = "Προσθήκη στο πλήρες"
			Remove     = "Διαγράψτε τη λειτουργία δρομολόγησης, μεταβλητή συστήματος"
			RemoveDone = "Διαγράφηκε με επιτυχία"
			SIP        = "Σενάριο συσκευασίας συστήματος"
			Unpack     = "Μπάλλα"
			ChkUpdate  = "Ελεγχος για ενημερώσεις"
			CreateUP   = "Δημιουργήστε ένα πακέτο αναβάθμισης"
			CEUP       = "Δημιουργήστε ένα πακέτο αναβάθμισης κινητήρα ανάπτυξης"
			zip        = "Όλο το λογισμικό είναι συσκευασμένο σε μορφή συμπίεσης με φερμουάρ"
		}
	}
	@{
		Tag      = "he-IL"
		Language = @{
			Usage      = "נוֹהָג:"
			Choose     = "בבקשה תבחר"
			Reset      = "אִתחוּל"
			History    = "נקה רשומות שורת הפקודה"
			Add        = "הוסף פונקציית ניתוב, משתנה מערכת"
			AddOK      = "נוסף"
			AddDone    = "הוסף להשלמה"
			Remove     = "מחק את פונקציית הניתוב, משתנה המערכת"
			RemoveDone = "נמחק בהצלחה"
			SIP        = "סקריפט אריזות מערכת"
			Unpack     = "חֲבִילָה"
			ChkUpdate  = "בדוק עדכונים"
			CreateUP   = "צור חבילת שדרוג"
			CEUP       = "צור חבילת שדרוג מנוע פריסה"
			zip        = "כל התוכנה ארוזת בפורמט דחיסת מיקוד"
		}
	}
	@{
		Tag      = "hu-HU"
		Language = @{
			Usage      = "használat:"
			Choose     = "kérlek válassz"
			Reset      = "Visszaállítás"
			History    = "Parancssori rekordok törlése"
			Add        = "Az útválasztási funkció hozzáadása, a rendszerváltozó"
			AddOK      = "Hozzáadva"
			AddDone    = "Hozzáadás a teljeshez"
			Remove     = "Törölje az útválasztási funkciót, a rendszerváltozót"
			RemoveDone = "Sikeresen törölte"
			SIP        = "A rendszercsomagolási szkript"
			Unpack     = "Bála"
			ChkUpdate  = "Frissítések keresése"
			CreateUP   = "Frissítési csomag létrehozása"
			CEUP       = "Hozzon létre egy telepítési motor-frissítési csomagot"
			zip        = "Az összes szoftver zip tömörítési formátumban van csomagolva"
		}
	}
	@{
		Tag      = "it-IT"
		Language = @{
			Usage      = "Utilizzo:"
			Choose     = "si prega di scegliere"
			Reset      = "Ripristina"
			History    = "Cancella i record della riga di comando"
			Add        = "Aggiungi funzione di routing, variabile di sistema"
			AddOK      = "Aggiunto"
			AddDone    = "Aggiungi a completare"
			Remove     = "Elimina la funzione di routing, variabile di sistema"
			RemoveDone = "Eliminato con successo"
			SIP        = "Script di packaging di sistema"
			Unpack     = "Balla"
			ChkUpdate  = "Controlla gli aggiornamenti"
			CreateUP   = "Crea pacchetto di aggiornamento"
			CEUP       = "Creare un pacchetto di aggiornamento del motore di distribuzione"
			zip        = "Tutto il software è confezionato in formato di compressione Zip"
		}
	}
	@{
		Tag      = "lv-LV"
		Language = @{
			Usage      = "Lietojums:"
			Choose     = "Lūdzu izvēlies"
			Reset      = "atiestatīt"
			History    = "Notīrīt komandrindas ierakstus"
			Add        = "Pievienojiet maršrutēšanas funkciju, sistēmas mainīgo"
			AddOK      = "Pievienots"
			AddDone    = "Pievienot, lai pabeigtu"
			Remove     = "Izdzēsiet maršrutēšanas funkciju, sistēmas mainīgo"
			RemoveDone = "Veiksmīgi izdzēsti"
			SIP        = "Sistēmas iepakojuma skripts"
			Unpack     = "Bāle"
			ChkUpdate  = "Meklēt atjauninājumus"
			CreateUP   = "Izveidojiet jaunināšanas pakotni"
			CEUP       = "Izveidojiet izvietošanas programmas jaunināšanas pakotni"
			zip        = "Visa programmatūra ir iesaiņota pasta kompresijas formātā"
		}
	}
	@{
		Tag      = "lt-LT"
		Language = @{
			Usage      = "Naudojimas:"
			Choose     = "Prašome pasirinkti"
			Reset      = "atstatyti"
			History    = "Išvalyti komandinės eilutės įrašus"
			Add        = "Pridėti maršruto parinkimo funkciją, sistemos kintamąjį"
			AddOK      = "Pridėta"
			AddDone    = "Pridėti prie pilno"
			Remove     = "Ištrinkite maršruto parinkimo funkciją, sistemos kintamąjį"
			RemoveDone = "Sėkmingai ištrintas"
			SIP        = "Sistemos pakavimo scenarijus"
			Unpack     = "Bale"
			ChkUpdate  = "Tikrinti, ar yra atnaujinimų"
			CreateUP   = "Sukurkite atnaujinimo paketą"
			CEUP       = "Sukurkite diegimo variklio naujinimo paketą"
			zip        = "Visa programinė įranga yra supakuota į ZIP suspaudimo formatą"
		}
	}
	@{
		Tag      = "nb-NO"
		Language = @{
			Usage      = "Bruk:"
			Choose     = "Vennligst velg"
			Reset      = "nullstille"
			History    = "Slett kommandolinjeposter"
			Add        = "Legg til rutingsfunksjon, systemvariabel"
			AddOK      = "la til"
			AddDone    = "Legg til i fullført"
			Remove     = "Slett rutingsfunksjonen, systemvariabel"
			RemoveDone = "vellykket slettet"
			SIP        = "Systememballasjeskript"
			Unpack     = "Bale"
			ChkUpdate  = "Se etter oppdateringer"
			CreateUP   = "Lag oppgraderingspakke"
			CEUP       = "Opprett en oppgraderingspakke for distribusjonsmotoren"
			zip        = "All programvare er pakket i zip -komprimeringsformat"
		}
	}
	@{
		Tag      = "pl-PL"
		Language = @{
			Usage      = "stosowanie:"
			Choose     = "proszę wybrać"
			Reset      = "Resetowanie"
			History    = "Wyczyść rekordy wiersza poleceń"
			Add        = "Dodaj funkcję routingu, zmienna systemowa"
			AddOK      = "dodany"
			AddDone    = "Dodaj do kompletnego"
			Remove     = "Usuń funkcję routingu, zmienną systemową"
			RemoveDone = "Z powodzeniem usunięto"
			SIP        = "Skrypt pakowania systemu"
			Unpack     = "Bela"
			ChkUpdate  = "Sprawdź aktualizacje"
			CreateUP   = "Utwórz pakiet aktualizacji"
			CEUP       = "Utwórz pakiet aktualizacji mechanizmu wdrażania"
			zip        = "Wszystkie oprogramowanie jest pakowane w formacie kompresji zip"
		}
	}
	@{
		Tag      = "pt-BR"
		Language = @{
			Usage      = "uso:"
			Choose     = "por favor escolha"
			Reset      = "reiniciar"
			History    = "Limpar registros de linha de comando"
			Add        = "Adicionar função de roteamento, variável do sistema"
			AddOK      = "Adicionado"
			AddDone    = "Adicionar para completar"
			Remove     = "Exclua a função de roteamento, variável do sistema"
			RemoveDone = "Excluído com sucesso"
			SIP        = "Script de embalagem do sistema"
			Unpack     = "Fardo"
			ChkUpdate  = "Verifique se há atualizações"
			CreateUP   = "Criar pacote de atualização"
			CEUP       = "Criar um pacote de atualização do mecanismo de implantação"
			zip        = "Todo o software está embalado em formato de compressão ZIP"
		}
	}
	@{
		Tag      = "ro-RO"
		Language = @{
			Usage      = "Utilizare:"
			Choose     = "vă rugăm să alegeți"
			Reset      = "resetare"
			History    = "Ștergeți înregistrările din linia de comandă"
			Add        = "Adăugați funcția de rutare, variabilă de sistem"
			AddOK      = "adăugat"
			AddDone    = "Adăugați la finalizare"
			Remove     = "Ștergeți funcția de rutare, variabila de sistem"
			RemoveDone = "Șters cu succes"
			SIP        = "Script de ambalare a sistemului"
			Unpack     = "Balot"
			ChkUpdate  = "Verifică pentru actualizări"
			CreateUP   = "Creați un pachet de upgrade"
			CEUP       = "Creați un pachet de actualizare a motorului de implementare"
			zip        = "Toate software -ul este ambalat în format de compresie zip"
		}
	}
	@{
		Tag      = "sk-SK"
		Language = @{
			Usage      = "Použitie:"
			Choose     = "prosím vyber si"
			Reset      = "resetovať"
			History    = "Vymazať záznamy príkazového riadku"
			Add        = "Pridajte funkciu smerovania, systémovú premennú"
			AddOK      = "Pridané"
			AddDone    = "Pridať do dokončenia"
			Remove     = "Odstráňte funkciu smerovania, systémovú premennú"
			RemoveDone = "Úspešne vymazané"
			SIP        = "Systémový obalový skript"
			Unpack     = "Bale"
			ChkUpdate  = "Skontroluj aktualizácie"
			CreateUP   = "Vytvorte inovačný balík"
			CEUP       = "Vytvorte balík inovácie nástroja nasadenia"
			zip        = "Celý softvér je zabalený vo formáte kompresie zipsov"
		}
	}
	@{
		Tag      = "sl-SI"
		Language = @{
			Usage      = "Uporaba:"
			Choose     = "prosim izberite"
			Reset      = "ponastaviti"
			History    = "Počisti zapise ukazne vrstice"
			Add        = "Dodajte funkcijo usmerjanja, sistemska spremenljivka"
			AddOK      = "Dodano"
			AddDone    = "Dodaj za dokončanje"
			Remove     = "Izbriši funkcijo usmerjanja, sistemska spremenljivka"
			RemoveDone = "Uspešno izbrisano"
			SIP        = "Script Scrip Packaging Script"
			Unpack     = "Bale"
			ChkUpdate  = "Preveri za posodobitve"
			CreateUP   = "Ustvari paket nadgradnje"
			CEUP       = "Ustvarite paket nadgradnje motorja za uvajanje"
			zip        = "Vsa programska oprema je pakirana v obliki stiskanja zip"
		}
	}
	@{
		Tag      = "es-MX"
		Language = @{
			Usage      = "Uso:"
			Choose     = "por favor elige"
			Reset      = "reiniciar"
			History    = "Borrar registros de línea de comando"
			Add        = "Agregar función de enrutamiento, variable del sistema"
			AddOK      = "adicional"
			AddDone    = "Añadir a Complete"
			Remove     = "Eliminar la función de enrutamiento, variable del sistema"
			RemoveDone = "Eliminado con éxito"
			SIP        = "Script de empaque del sistema"
			Unpack     = "Bala"
			ChkUpdate  = "Buscar actualizaciones"
			CreateUP   = "Crear un paquete de actualización"
			CEUP       = "Crear un paquete de actualización del motor de implementación"
			zip        = "Todo el software está empaquetado en formato de compresión zip"
		}
	}
	@{
		Tag      = "th-TH"
		Language = @{
			Usage      = "การใช้งาน:"
			Choose     = "โปรดเลือก"
			Reset      = "รีเซ็ต"
			History    = "ล้างบันทึกบรรทัดคำสั่ง"
			Add        = "เพิ่มฟังก์ชั่นการกำหนดเส้นทางตัวแปรระบบ"
			AddOK      = "เพิ่ม"
			AddDone    = "เพิ่มให้เสร็จสมบูรณ์"
			Remove     = "ลบฟังก์ชั่นการกำหนดเส้นทางตัวแปรระบบ"
			RemoveDone = "ลบสำเร็จ"
			SIP        = "สคริปต์บรรจุภัณฑ์ของระบบ"
			Unpack     = "เบล"
			ChkUpdate  = "ตรวจสอบสำหรับการอัพเดต"
			CreateUP   = "สร้างแพ็คเกจอัพเกรด"
			CEUP       = "สร้างแพ็คเกจการปรับรุ่นกลไกการปรับใช้"
			zip        = "ซอฟต์แวร์ทั้งหมดบรรจุในรูปแบบการบีบอัด zip"
		}
	}
	@{
		Tag      = "tr-TR"
		Language = @{
			Usage      = "Kullanım:"
			Choose     = "lütfen seç"
			Reset      = "Sıfırla"
			History    = "Komut satırı kayıtlarını temizle"
			Add        = "Yönlendirme işlevi, sistem değişkeni ekle"
			AddOK      = "katma"
			AddDone    = "Tamamlamak için ekle"
			Remove     = "Yönlendirme işlevini sil, sistem değişkeni"
			RemoveDone = "Başarılı bir şekilde silindi"
			SIP        = "Sistem Ambalaj Komut Dosyası"
			Unpack     = "Balya"
			ChkUpdate  = "Güncellemeleri kontrol et"
			CreateUP   = "Bir yükseltme paketi oluşturun"
			CEUP       = "Bir dağıtım altyapısı yükseltme paketi oluşturun"
			zip        = "Tüm yazılımlar zip sıkıştırma formatında paketlenmiştir"
		}
	}
	@{
		Tag      = "uk-UA"
		Language = @{
			Usage      = "Використання:"
			Choose     = "будь-ласка оберіть"
			Reset      = "скинути"
			History    = "Очистити записи командного рядка"
			Add        = "Додайте функцію маршрутизації, системну змінну"
			AddOK      = "Додав"
			AddDone    = "Додати для завершення"
			Remove     = "Видаліть функцію маршрутизації, системна змінна"
			RemoveDone = "успішно видалено"
			SIP        = "Сценарій упаковки системи"
			Unpack     = "Бейл"
			ChkUpdate  = "Перевірити наявність оновлень"
			CreateUP   = "Створіть пакет оновлення"
			CEUP       = "Створіть пакет оновлення механізму розгортання"
			zip        = "Bce програмне забезпечення упаковано y форматі стиснення zip"
		}
	}
	@{
		Tag      = "ca-es"
		Language = @{
			Usage      = "ús:"
			Choose     = "Per favor, tria"
			Reset      = "restablir"
			History    = "Esborra els registres de la línia d'ordres"
			Add        = "Afegiu la funció d'encaminament, la variable del sistema"
			AddOK      = "Afegit"
			AddDone    = "Afegeix a complet"
			Remove     = "Suprimeix la funció d'encaminament, la variable del sistema"
			RemoveDone = "S'ha suprimit amb èxit"
			SIP        = "Script d'embalatge del sistema"
			Unpack     = "Bale"
			ChkUpdate  = "Buscar actualitzacions"
			CreateUP   = "Crea un paquet d'actualització"
			CEUP       = "Creeu un paquet d'actualització del motor de desplegament"
			zip        = "Tot el programari està envasat en format de compressió zip"
		}
	}
	@{
		Tag      = "eu-es"
		Language = @{
			Usage      = "Erabilera:"
			Choose     = "mesedez aukeratu"
			Reset      = "berrezarri"
			History    = "Garbitu komando-lerroko erregistroak"
			Add        = "Gehitu bideratze funtzioa, sistemaren aldagaia"
			AddOK      = "Gehitu"
			AddDone    = "Gehitu osatzeko"
			Remove     = "Ezabatu bideratze funtzioa, sistemaren aldagaia"
			RemoveDone = "ondo ezabatu"
			SIP        = "Sistema ontziratzeko gidoia"
			Unpack     = "Bale"
			ChkUpdate  = "Egiaztatu eguneratzeak"
			CreateUP   = "Sortu bertsio berritzeko paketea"
			CEUP       = "Sortu hedapen-motorra eguneratzeko pakete bat"
			zip        = "Software guztia zip konpresio formatuan paketatuta dago"
		}
	}
	@{
		Tag      = "gl-es"
		Language = @{
			Usage      = "Uso:"
			Choose     = "por favor escolle"
			Reset      = "restablecer"
			History    = "Borrar rexistros da liña de comandos"
			Add        = "Engade a función de enrutamento, variable do sistema"
			AddOK      = "engadido"
			AddDone    = "Engadir a completar"
			Remove     = "Eliminar a función de enrutamento, variable do sistema"
			RemoveDone = "Eliminado con éxito"
			SIP        = "Script de envasado do sistema"
			Unpack     = "Bale"
			ChkUpdate  = "Comproba se hai actualizacións"
			CreateUP   = "Crear paquete de actualización"
			CEUP       = "Crea un paquete de actualización do motor de implementación"
			zip        = "Todo o software está envasado en formato de compresión con cremalleira"
		}
	}
	@{
		Tag      = "id-id"
		Language = @{
			Usage      = "penggunaan:"
			Choose     = "tolong pilih"
			Reset      = "mengatur ulang"
			History    = "Hapus catatan baris perintah"
			Add        = "Tambahkan fungsi routing, variabel sistem"
			AddOK      = "Ditambahkan"
			AddDone    = "Tambahkan ke Lengkapi"
			Remove     = "Hapus fungsi routing, variabel sistem"
			RemoveDone = "berhasil dihapus"
			SIP        = "Skrip Kemasan Sistem"
			Unpack     = "Bal"
			ChkUpdate  = "Periksa pembaruan"
			CreateUP   = "Buat paket peningkatan"
			CEUP       = "Buat paket pemutakhiran mesin penerapan"
			zip        = "Semua perangkat lunak dikemas dalam format kompresi zip"
		}
	}
	@{
		Tag      = "vi-vn"
		Language = @{
			Usage      = "cách sử dụng:"
			Choose     = "xin vui lòng chọn"
			Reset      = "cài lại"
			History    = "Xóa bản ghi dòng lệnh"
			Add        = "Thêm chức năng định tuyến, biến hệ thống"
			AddOK      = "thêm"
			AddDone    = "Thêm vào hoàn thành"
			Remove     = "Xóa chức năng định tuyến, biến hệ thống"
			RemoveDone = "Xóa thành công"
			SIP        = "Kịch bản bao bì hệ thống"
			Unpack     = "Bale"
			ChkUpdate  = "Kiểm tra cập nhật"
			CreateUP   = "Tạo gói nâng cấp"
			CEUP       = "Tạo gói nâng cấp công cụ triển khai"
			zip        = "Tất cả các phần mềm được đóng gói ở định dạng nén zip"
		}
	}
	@{
		Tag      = "sr-latn-rs"
		Language = @{
			Usage      = "употреба:"
			Choose     = "молимо изаберите"
			Reset      = "ресетовати"
			History    = "Обришите записе командне линије"
			Add        = "Додајте функцију усмеравања, системска променљива"
			AddOK      = "додато"
			AddDone    = "Додај за комплетну"
			Remove     = "Избришите функцију усмеравања, системска променљива"
			RemoveDone = "Успешно избрисано"
			SIP        = "Скрипта за паковање система"
			Unpack     = "Бале"
			ChkUpdate  = "Провери ажурирања"
			CreateUP   = "Креирајте пакет за надоградњу"
			CEUP       = "Креирајте пакет за надоградњу машине за примену"
			zip        = "Сав софтвер је упакован у зип компресијски формат"
		}
	}
	@{
		Tag      = "de-DE"
		Language = @{
			Usage      = "Verwendungszweck:"
			Choose     = "bitte auswählen"
			Reset      = "zurücksetzen"
			History    = "Befehlszeilendatensätze löschen"
			Add        = "Routing -Funktion hinzufügen, Systemvariable"
			AddOK      = "hinzugefügt"
			AddDone    = "Hinzufügen zum Vervollständigen"
			Remove     = "Löschen Sie die Routing -Funktion, Systemvariable"
			RemoveDone = "erfolgreich gelöscht"
			SIP        = "Systemverpackungsskript"
			Unpack     = "Ballen"
			ChkUpdate  = "Auf Updates prüfen"
			CreateUP   = "Upgrade-Paket erstellen"
			CEUP       = "Erstellen Sie ein Upgradepaket für die Bereitstellungs-Engine"
			zip        = "Alle Software ist im ZIP -Komprimierungsformat verpackt"
		}
	}
	@{
		Tag      = "en-US"
		Language = @{
			Usage      = "Usage: "
			Choose     = "Please choose"
			Reset      = "Reset"
			History    = "Clean up command-line records"
			Add        = "Add routing functionality, system variables"
			AddOK      = "Added"
			AddDone    = "Add complete"
			Remove     = "Remove the routing function, system variables"
			RemoveDone = "Delete successful"
			SIP        = "System encapsulation"
			Unpack     = "pack"
			ChkUpdate  = "Check for updates"
			CreateUP   = "Create an upgrade package"
			CEUP       = "Create a deployment engine upgrade package"
			zip        = "All software is packaged in zip compression format"
		}
	}
	@{
		Tag      = "ru-RU"
		Language = @{
			Usage      = "Применение:"
			Choose     = "пожалуйста, выберите"
			Reset      = "перезагрузить"
			History    = "Очистить записи командной строки"
			Add        = "Добавить функцию маршрутизации, системную переменную"
			AddOK      = "добавлен"
			AddDone    = "Добавить в комплект"
			Remove     = "Удалить функцию маршрутизации, системная переменная"
			RemoveDone = "Успешно удален"
			SIP        = "Системная упаковка сценарий"
			Unpack     = "Бэйл"
			ChkUpdate  = "Проверить наличие обновлений"
			CreateUP   = "Создать пакет обновления"
			CEUP       = "Создание пакета обновления механизма развертывания"
			zip        = "Bce программное обеспечение упаковано в формате сжатия Zip"
		}
	}
	@{
		Tag      = "ja-JP"
		Language = @{
			Usage      = "利用方法："
			Choose     = "選んでください"
			Reset      = "リセット"
			History    = "コマンドラインレコードをクリアする"
			Add        = "ルーティング機能、システム変数を追加"
			AddOK      = "追加した"
			AddDone    = "完了に追加"
			Remove     = "ルーティング関数、システム変数を削除"
			RemoveDone = "削除された"
			SIP        = "システムパッケージングスクリプト"
			Unpack     = "ベール"
			ChkUpdate  = "アップデートを確認"
			CreateUP   = "アップグレードパッケージを作成する"
			CEUP       = "デプロイメント エンジン アップグレード パッケージを作成する"
			zip        = "すべてのソフトウェアはzip圧縮形式でパッケージ化されています"
		}
	}
	@{
		Tag      = "ko-KR"
		Language = @{
			Usage      = "용법:"
			Choose     = "선택해주세요"
			Reset      = "초기화"
			History    = "명령줄 레코드 지우기"
			Add        = "라우팅 기능 추가, 시스템 변수"
			AddOK      = "추가"
			AddDone    = "완료하기 위해 추가"
			Remove     = "라우팅 기능, 시스템 변수 삭제"
			RemoveDone = "성공적으로 삭제"
			SIP        = "시스템 포장 스크립트"
			Unpack     = "곤포"
			ChkUpdate  = "업데이트 확인"
			CreateUP   = "업그레이드 패키지 생성"
			CEUP       = "배치 엔진 업그레이드 패키지 작성"
			zip        = "모든 소프트웨어는 zip 압축 형식으로 포장됩니다"
		}
	}
	@{
		Tag      = "zh-CN"
		Language = @{
			Usage      = "用法："
			Choose     = "请选择"
			Reset      = "重置"
			History    = "清理命令行记录"
			Add        = "添加路由功能、系统变量"
			AddOK      = "已添加"
			AddDone    = "添加完成"
			Remove     = "删除路由功能，系统变量"
			RemoveDone = "删除成功"
			SIP        = "系统封装脚本"
			Unpack     = "打包"
			ChkUpdate  = "检查更新"
			CreateUP   = "创建升级包"
			CEUP       = "创建部署引擎升级包"
			zip        = "所有软件都以 zip 压缩格式打包"
		}
	}
	@{
		Tag      = "zh-TW"
		Language = @{
			Usage      = "用法："
			Choose     = "請選擇"
			Reset      = "重置"
			History    = "清理命令行記錄"
			Add        = "添加路由功能、系統變量"
			AddOK      = "已添加"
			AddDone    = "添加完成"
			Remove     = "刪除路由功能，系統變量"
			RemoveDone = "刪除成功"
			SIP        = "系統封裝腳本"
			Unpack     = "打包"
			ChkUpdate  = "檢查更新"
			CreateUP   = "創建升級包"
			CEUP       = "創建部署引擎升級包"
			zip        = "所有軟件都以 zip 壓縮格式打包"
		}
	}
)

Function Language
{
	<#
		.重置语言，获取当前主语言
	#>
	$Script:lang = @()
	$Script:IsLang = ""
	$PrimaryLnguage = (Get-Culture).Name

	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq $PrimaryLnguage) {
			$Script:lang = $item.Language
			$Script:IsLang = $item.Tag
			return
		}
	}

	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq "en-US") {
			$Script:lang = $item.Language
			$Script:IsLang = $item.Tag
			return
		}
	}

	Write-Host "No language packs found, please try again." -ForegroundColor Red
	Start-Sleep -s 2
	exit
}

if ($lang) {
	ForEach ($item in $AvailableLanguages) {
		if ($item.Tag -eq $lang) {
			$Script:lang = $item.Language
			$Script:IsLang = $item.Tag
			break
		}
	}
} else {
	Language
}

function Solutions_Reset
{
	$Path = "HKCU:\SOFTWARE\Yi\Solutions"
	Remove-Item -Path $Path -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
	Clear-Host

	write-host "`n  $($Script:Lang.RemoveDone)`n" -ForegroundColor Green
}

function Mount_Fix
{
	dism /cleanup-wim | Out-Null
	Clear-WindowsCorruptMountPoint -ErrorAction SilentlyContinue | Out-Null
	Clear-Host

	write-host "`n  $($Script:Lang.RemoveDone)`n" -ForegroundColor Green
}

function Solutions_Clear_Hostiry
{
	Clear-History
	Remove-Item (Get-PSReadlineOption).HistorySavePath;
	Clear-Host

	write-host "`n  $($Script:Lang.RemoveDone)`n" -ForegroundColor Green
}

function System_Env
{
	param
	(
		[switch]$Add,
		[switch]$Remove
	)

	$Current_Folder = Convert-Path -Path $PSScriptRoot -ErrorAction SilentlyContinue
	$regLocation = "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment"
	$path = (Get-ItemProperty -Path $regLocation -Name PATH).path

	if ($Add) {
		$windows_path = $path -split ';'

		if (($windows_path) -Contains $Current_Folder) {
			write-host "`n  $($Script:Lang.AddOK)`n" -ForegroundColor Green
		} else {
			$path = "$($path);$($Current_Folder)"
			Set-ItemProperty -Path $regLocation -Name PATH -Value $path
			$Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

			write-host "`n   $($Script:Lang.AddDone)`n" -ForegroundColor Green
		}
    }

    if ($Remove) {
		$path = ($path.Split(';') | Where-Object { $_ -ne $Current_Folder }) -join ';'
		Set-ItemProperty -Path $regLocation -Name PATH -Value $path
		$Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

		write-host "`n  $($Script:Lang.RemoveDone)`n" -ForegroundColor Green
    }
}

function PSscript
{
	$PSscript = Get-Item $MyInvocation.ScriptName
	Return $PSscript
}

Function Help
{
	$PSscript = PSscript

	$Host.UI.RawUI.WindowTitle = "Yi's Solutions"
	Write-Host "`n   Yi's Solutions, v1.0.0.0"
	Write-host "   https://fengyi.tel/solutions`n" -ForegroundColor Yellow

	Write-Host "   $($Script:Lang.Usage)

    U    $($PSscript.BaseName) -Update  | $($Script:Lang.ChkUpdate)
    C    $($PSscript.BaseName) -CU      | $($Script:Lang.CreateUP)

    1    $($PSscript.BaseName) -Add     | $($Script:Lang.Add)
    2    $($PSscript.BaseName) -Remove  | $($Script:Lang.Remove)
    3    $($PSscript.BaseName) -Reset   | $($Script:Lang.Reset)
    4    $($PSscript.BaseName) -History | $($Script:Lang.History)

    5    $($PSscript.BaseName) -SIP     | $($Script:Lang.SIP)
    6    $($PSscript.BaseName) -Unpack  | $($Script:Lang.Unpack)
    7    $($PSscript.BaseName) -CEUP    | $($Script:Lang.CEUP)
    8    $($PSscript.BaseName) -zip     | $($Script:Lang.zip)`n`n"

	switch (Read-Host "  $($Script:Lang.Choose)")
	{
		'u' {
			powershell -file "$($PSScriptRoot)\..\..\_Sip.ps1" -Function Update""
		}
		'c' {
			Run_File -Name "$($PSScriptRoot)\..\..\_Create.Upgrade.Package.ps1"
		}
		'1' {
			System_Env -Add
		}
		'2' {
			System_Env -Remove
		}
		'3' {
			Solutions_Reset
		}
		'4' {
			Solutions_Clear_Hostiry
		}
		'5' {
			Run_File -Name "$($PSScriptRoot)\..\..\_Sip.ps1"
		}
		'6' {
			Run_File -Name "$($PSScriptRoot)\..\..\_Unpack.ps1"
		}
		'7' {
			Run_File -Name "$($PSScriptRoot)\..\..\_Create.Custom.Engine.upgrade.package.ps1"
		}
		'8' {
			Run_File -Name "$($PSScriptRoot)\..\..\_zip.ps1"
		}
		default {
			write-host ""
			exit
		}
	}
}

Function Run_File
{
	param
	(
		[string]$Name
	)

	if (Test-Path $Name -PathType Leaf) {
		if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
			powershell -file $Name
		} else {
			Start-Process powershell -ArgumentList "-file $($Name)" -Verb RunAs
		}
	} else {
		Write-Host "`n   $($Name)" -ForegroundColor Red
	}
}

if ($Help) {
	Help
	return
}

if ($Update) {
	powershell -file "$($PSScriptRoot)\..\..\_Sip.ps1" -Function Update""
	return
}

if ($CU) {
	Run_File -Name "$($PSScriptRoot)\..\..\_Create.Upgrade.Package.ps1"
}

if ($Add) {
	System_Env -Add
	return
}

if ($Remove) {
	System_Env -Remove
	return
}

if ($Reset) {
	Solutions_Reset
	return
}

if ($Fix) {
	Mount_Fix
	return
}

if ($History) {
	Solutions_Clear_Hostiry
	return
}

if ($SIP) {
	Run_File -Name "$($PSScriptRoot)\..\..\_Sip.ps1"
	return
}

if ($Unpack) {
	Run_File -Name "$($PSScriptRoot)\..\..\_Unpack.ps1"
	return
}

if ($CEUP) {
	Run_File -Name "$($PSScriptRoot)\..\..\_Create.Custom.Engine.upgrade.package.ps1"
	return
}

if ($Update) {
	Run_File -Name "$($PSScriptRoot)\..\..\_Create.upgrade.package.ps1"
	return
}

if ($zip) {
	Run_File -Name "$($PSScriptRoot)\..\..\_zip.ps1"
	return
}

Help