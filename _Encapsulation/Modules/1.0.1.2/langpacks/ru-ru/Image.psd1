﻿ConvertFrom-StringData -StringData @'
	# ru-RU
	# Russian (Russia)

	SaveModeClear                   = Очистить выбранную историю
	SaveModeTipsClear               = История сохранена, ее можно очистить.
	SelectTips                      = Советы\n\n    1. Выберите имя образа, который необходимо обработать;\n    2. После отмены задачи, требующие "монтирования", перестанут действовать.
	CacheDisk                       = Дисковый кэш
	CacheDiskCustomize              = Пользовательский путь к кэшу
	AutoSelectRAMDISK               = Разрешить автоматический выбор метки тома диска
	AutoSelectRAMDISKFailed         = Метка тома не совпадает: {0}
	ReFS_Find_Volume                = Если встречается формат диска REFS, исключите
	ReFS_Exclude                    = Раздел ReFS исключен
	RAMDISK_Change                  = Изменить имя метки тома
	RAMDISK_Restore                 = Восстановить имя инициализированного тома: {0}
	AllowTopMost                    = Разрешить закрепление открытых окон вверху
	History                         = Очистить историю
	History_Del_Tips                = При наличии задачи инкапсуляции не выполняйте следующие дополнительные параметры, иначе это вызовет неизвестные проблемы во время выполнения сценария инкапсуляции.
	History_View                    = Посмотреть историю
	HistoryLog                      = Разрешить автоматическую очистку журналов старше 7 дней.
	HistorySaveFolder               = Другие пути к источникам изображений
	HistoryClearappxStage           = Приложения InBox: удаление временных файлов, созданных во время установки.
	DoNotCheckBoot                  = Если размер файла Boot.wim превышает 520 МБ, при создании ISO автоматически выбирается перестроение.
	HistoryClearDismSave            = Удалить записи монтирования DISM, сохраненные в реестре.
	Clear_Bad_Mount                 = Удалите все ресурсы, связанные с поврежденным смонтированным образом.
	ShowCommand                     = Показать полный запуск командной строки
	Command                         = Командная строка
	SelectSettingImage              = Источник изображения
	NoSelectImageSource             = Источник изображения не выбран
	SettingImageRestore             = Восстановить место монтирования по умолчанию
	SettingImage                    = Изменить место подключения источника образа
	SelectImageMountStatus          = Получить статус монтирования после выбора источника образа
	SettingImageTempFolder          = Временный каталог
	SettingImageToTemp              = Временный каталог совпадает с местом, куда он был смонтирован.
	SettingImagePathTemp            = Использование каталога Temp
	SettingImageLow                 = Проверьте минимально доступное оставшееся пространство
	SettingImageNewPath             = Выберите монтируемый диск
	SettingImageNewPathTips         = Рекомендуется смонтировать его на диск памяти, который является самым быстрым. Вы можете использовать программное обеспечение виртуальной памяти, такое как Ultra RAMDisk и ImDisk.
	SelectImageSource               = Выбрано "Развернуть решение Engine", нажмите "ОК".
	NoImagePreSource                = Доступный источник не найден, вам следует: \n\n     1. Добавьте больше источников изображений в:\n          {0}\n\n     2. Выберите "Настройки" и повторно выберите диск поиска источника изображения;\n\n     3. Выберите "ISO" и выберите ISO для распаковки, элементы для монтирования и т. д.
	NoImageOtherSource              = Нажмите меня, чтобы "Добавить" другие пути или "Перетащить каталог" в текущее окно.
	SearchImageSource               = Диск поиска источника изображения
	Kernel                          = Ядро
	Architecture                    = Архитектура
	ArchitecturePack                = Архитектура пакета, понимание правил добавления
	ImageLevel                      = Тип установки
	LevelDesktop                    = Рабочий стол
	LevelServer                     = Сервер
	ImageCodename                   = Кодовое имя
	ImageCodenameNo                 = Не признан
	MainImageFolder                 = Домашний каталог
	MountImageTo                    = Монтировать на
	Image_Path                      = Путь к изображению
	MountedIndex                    = Индекс
	MountedIndexSelect              = Выберите индексный номер
	AutoSelectIndexFailed           = Автоматический выбор индекса {0} не удался. Повторите попытку.
	Apply                           = Приложение
	Eject                           = Неожиданно возникнуть
	Mount                           = Устанавливать
	Unmount                         = Удалить
	Mounted                         = Установлен
	NotMounted                      = Не установлен
	NotMountedSpecify               = Не смонтирован, можно указать место крепления
	MountedIndexError               = Ненормальное монтирование, удалите и повторите попытку.
	ImageSouresNoSelect             = Показать более подробную информацию после выбора источника изображения
	Mounted_Mode                    = Режим монтирования
	Mounted_Status                  = Статус монтирования
	Image_Popup_Default             = Сохранить как по умолчанию
	Image_Restore_Default           = Вернуться к настройкам по умолчанию
	Image_Popup_Tips                = Намекать:\n\nПри назначении события вы не указали номер индекса для обработки {0};\n\nВ настоящее время появился интерфейс выбора. Пожалуйста, укажите индексный номер. После завершения спецификации рекомендуется выбрать "Сохранить как по умолчанию". Он не появится снова при следующей обработке.
	Rule_Show_Full                  = Показать все
	Rule_Show_Only                  = Показать только правила
	Rule_Show_Only_Select           = Выбирайте из правил
	Image_Unmount_After             = Принудительно отключить все смонтированные образы

	Wim_Rule_Update                 = Извлечение и обновление файлов в образе
	Wim_Rule_Extract                = Извлечь файлы
	Wim_Rule_Extract_Tips           = После выбора правила пути извлеките указанный файл и сохраните его локально.

	Wim_Rule_Verify                 = Проверять
	Wim_Rule_Check                  = Исследовать
	Destination                     = Место назначения

	Wim_Rename                      = Изменить информацию об изображении
	Wim_Image_Name                  = Название изображения
	Wim_Image_Description           = Описание изображения
	Wim_Display_Name                = Отображаемое имя
	Wim_Display_Description         = Показать описание
	Wim_Edition                     = Изображение знака
	Wim_Edition_Select_Know         = Выберите известные флаги изображений
	Wim_Created                     = Дата создания
	Wim_Expander_Space              = Расширение пространства

	IABSelectNo                     = Первичный ключ не выбран: Install、WinRE、Boot
	Unique_Name                     = Уникальное имя
	Select_Path                     = Путь
	Setting_Pri_Key                 = Установите этот файл обновления в качестве основного шаблона:
	Pri_Key_Update_To               = Затем обновите до:
	Pri_Key_Template                = Установите этот файл в качестве предпочтительного шаблона для синхронизации с выбранными элементами.
	Pri_key_Running                 = Задача первичного ключа была синхронизирована и пропущена.
	ShowAllExclude                  = Показать все устаревшие исключения

	Index_Process_All               = Обработать все известные индексные номера
	Index_Is_Event_Select           = При возникновении события появляется интерфейс выбора индексного номера.
	Index_Pre_Select                = Предварительно присвоенный индексный номер
	Index_Select_Tips               = Намекать:\n\n{0}.wim в настоящее время не смонтирован, вы можете:\n\n   1. Выберите "Обрабатывать все известные порядковые номера";\n\n   2. Выберите "При возникновении события появится всплывающий интерфейс выбора индексного номера";\n\n   3. Предварительно указанный индексный номер\n      Указан номер индекса 6, номер индекса не существует во время обработки, и обработка пропускается.

	Index_Tips_Custom_Expand        = Группа: {0}\n\nПри обработке {1} необходимо присвоить индексный номер {2}, иначе обработка невозможна.\n\nПосле выбора "Синхронизировать правила обновления со всеми индексными номерами" вам останется только отметить любой из них в качестве основного шаблона.
'@