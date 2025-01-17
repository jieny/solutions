﻿ConvertFrom-StringData -StringData @'
	# es-ES
	# Spanish (Spain)

	IsCreate                        = Crear
	Solution                        = Solución
	EnabledSoftwarePacker           = Recopilación
	EnabledUnattend                 = Deberia responder con anticipacion
	EnabledEnglish                  = Motor de implementación
	UnattendSelectVer               = Seleccione el idioma de la solución 'Responder a'
	UnattendLangPack                = Seleccione el paquete de idioma 'Solución'
	UnattendSelectSingleInstl       = Multilingüe, opcional durante la instalación.
	UnattendSelectMulti             = Plurilingüe
	UnattendSelectDisk              = Seleccione la solución Autounattend.xml
	UnattendSelectSemi              = Semiautomático es válido para todos los métodos de instalación.
	UnattendSelectUefi              = UEFI se instala automáticamente y debe especificarse
	UnattendSelectLegacy            = Legacy se instala automáticamente y debe especificarse
	NeedSpecified                   = Por favor seleccione lo que necesita ser especificado:
	OOBESetupOS                     = Interfaz de instalación
	OOBEProductKey                  = Clave de producto
	OOBEOSImage                     = Seleccione el sistema operativo a instalar
	OOBEEula                        = Aceptar términos de licencia
	OOBEDoNotServerManager          = El Administrador del servidor no se inicia automáticamente al iniciar sesión
	OOBEIE                          = Configuración de seguridad mejorada de Internet Explorer
	OOBEIEAdmin                     = Cerrar "Administrador"
	OObeIEUser                      = Cerrar "Usuarios"

	OOBE_Init_User                  = Usuario inicial durante la experiencia de unboxing
	OOBE_init_Create                = Crear usuarios personalizados
	OOBE_init_Specified             = Especificar usuario
	OOBE_Init_Autologin             = Inicio de sesión automático

	InstlMode                       = Método de instalación
	Business                        = Versión empresarial
	BusinessTips                    = Depende de EI.cfg, es necesario especificar el número de índice para la instalación automática.
	Consumer                        = Versión para el consumidor
	ConsumerTips                    = No depende de EI.cfg. Es necesario especificar el número de serie para la instalación automática. Al hacer una pausa en la interfaz de selección de versión, es necesario especificar el número de índice.
	CreateUnattendISO               = [ISO]:\\Autounattend.xml
	CreateUnattendISOSources        = [ISO]:\\sources\\Unattend.xml
	CreateUnattendISOSourcesOEM     = [ISO]:\\sources\\$OEM$\\$$\\Panther\\unattend.xml
	CreateUnattendPanther           = [montar a]:\\Windows\\Panther\\unattend.xml

	VerifyName                      = Agregar al nombre del directorio de inicio del disco del sistema
	VerifyNameUse                   = Verifique que el nombre del directorio no pueda contener
	VerifyNameTips                  = Solo se permite una combinación de letras y números en inglés y no puede contener: espacios, la longitud no puede ser mayor a 260 caracteres, \\ / : * ? & @ ! "" < > |
	VerifyNumberFailed              = La verificación falló, ingrese el número correcto.
	VerifyNameSync                  = Establecer el nombre del directorio como nombre de usuario principal
	VerifyNameSyncTips              = El administrador ya no se utiliza.
	ManualKey                       = Seleccione o ingrese su clave de producto manualmente
	ManualKeyTips                   = Ingrese una clave de producto válida. Si la región seleccionada no está disponible, vaya al sitio web oficial de Microsoft para verificar.
	ManualKeyError                  = La clave de producto que ingresó no es válida.
	KMSLink1                        = Clave de configuración del cliente KMS
	KMSUnlock                       = Mostrar todos los números de serie de KMS conocidos
	KMSSelect                       = Por favor seleccione el número de serie VOL
	KMSKey                          = Número de serie
	KMSKeySelect                    = Cambiar el número de serie del producto
	ClearOld                        = Limpiar archivos antiguos
	SolutionsSkip                   = Saltar creación de solución
	SolutionsTo                     = Agregue 'solución' a:
	SolutionsToMount                = Montado o agregado a la cola
	SolutionsToError                = Algunas funciones han sido deshabilitadas. Si necesita forzar su uso, haga clic en el botón "Desbloquear".\n\n
	UnlockBoot                      = Descubrir
	SolutionsToSources              = Directorio de inicio, [ISO]:\\Sources\\$OEM$
	SolutionsScript                 = Seleccione la versión 'Motor de implementación'
	SolutionsEngineRegionaUTF8      = Beta: compatibilidad con idiomas globales mediante Unicode UTF-8
	SolutionsEngineRegionaUTF8Tips  = Parece que puede causar nuevos problemas tras abrirlo. No recomendado.
	SolutionsEngineRegionaling      = Cambiar a nueva configuración regional:
	SolutionsEngineRegionalingTips  = Cambie la configuración regional del sistema, lo que afecta a todas las cuentas de usuario en la computadora.
	SolutionsEngineRegional         = Cambiar la configuración regional del sistema
	SolutionsEngineRegionalTips     = Valor predeterminado global: {0}, cambiado a: {1}
	SolutionsEngineCopyPublic       = Copiar público {0} a la implementación
	SolutionsEngineCopyOpen         = Explorar la ubicación del repositorio público {0}
	EnglineDoneReboot               = Reinicia tu computadora
	SolutionsTipsArm64              = Se prefiere el paquete arm64 y usted selecciona en orden: x64, x86.
	SolutionsTipsAMD64              = Prefiere paquetes x64, en orden: x86.
	SolutionsTipsX86                = Solo se agregan paquetes x86.
	SolutionsReport                 = Generar informe previo a la implementación
	SolutionsDeployOfficeInstall    = Implementar el paquete de instalación de Microsoft Office
	SolutionsDeployOfficeChange     = Cambiar la configuración de implementación
	SolutionsDeployOfficePre        = Versión del paquete preinstalado
	SolutionsDeployOfficeNoSelect   = No se seleccionó ningún paquete de preinstalación de Office
	SolutionsDeployOfficeVersion    = {0} versión
	SolutionsDeployOfficeOnly       = Mantener paquetes de idiomas especificados
	SolutionsDeployOfficeSync       = Preservar la sincronización del idioma con la configuración de implementación
	SolutionsDeployOfficeSyncTips   = Después de la sincronización, el script de instalación no puede determinar el idioma preferido.
	DeploySyncMainLanguage          = Sincronizar con el idioma principal
	SolutionsDeployOfficeTo         = Implemente el paquete de instalación en
	SolutionsDeployOfficeToPublic   = Escritorio publico
	DeployPackage                   = Implementar un paquete de recopilación personalizado
	DeployPackageSelect             = Seleccione un paquete de precolección
	DeployPackageTo                 = Implementar el paquete de recopilación previa en
	DeployPackageToRoot             = Disco del sistema:\\Package
	DeployPackageToSolutions        = En el directorio de inicio de la solución
	DeployTimeZone                  = Huso horario
	DeployTimeZoneChange            = Cambiar zona horaria
	DeployTimeZoneChangeTips        = Establezca el área horaria predeterminada donde se deben responder las respuestas previas, por área de idioma.

	Deploy_Tags                     = Etiqueta de implementación
	FirstExpProcess                 = Experiencia por primera vez, durante los requisitos previos de la implementación:
	FirstExpProcessTips             = Después de completar los requisitos previos, reinicie la computadora para resolver el problema de requerir un reinicio para que surta efecto.
	FirstExpFinish                  = Experiencia por primera vez, después de completar los requisitos previos.
	FirstExpSyncMark                = Permitir la búsqueda global y la sincronización de etiquetas de implementación.
	FirstExpUpdate                  = Permitir actualizaciones automáticas
	FirstExpDefender                = Agregar directorio de inicio para defender directorios excluidos
	FirstExpSyncLabel               = Etiqueta de volumen del disco del sistema: el nombre del directorio de inicio es el mismo
	MultipleLanguages               = Cuando encuentre varios idiomas:
	NetworkLocationWizard           = Asistente de ubicación de red
	PreAppxCleanup                  = Bloquear tareas de mantenimiento de limpieza de Appx
	LanguageComponents              = Evite la limpieza de paquetes de idiomas de funciones bajo demanda no utilizados
	PreventCleaningUnusedLP         = Evitar la limpieza de paquetes de idiomas no utilizados
	FirstExpContextCustomize        = Añade un "menú contextual" personalizado
	FirstExpContextCustomizeShift   = Mantenga presionada la tecla Shift y haga clic derecho

	FirstExpFinishTips              = No hay eventos importantes una vez completada la implementación. Se recomienda cancelar.
	FirstExpFinishPopup             = Abra la interfaz principal del motor de implementación
	FirstExpFinishOnDemand          = Permitir la primera vista previa, según lo planeado
	SolutionsEngineRestricted       = Restaurar la política de ejecución de Powershell: restringida
	EnglineDoneClearFull            = Eliminar toda la solución
	EnglineDoneClear                = Elimine el motor de implementación y conserve los demás.

	Unattend_Auto_Fix_Next          = La próxima vez que lo encuentre, seleccione automáticamente los elementos necesarios para solucionarlo automáticamente.
	Unattend_Auto_Fix               = Reparar automáticamente cuando no se seleccionan los requisitos previos
	Unattend_Auto_Fix_Tips          = Al agregar el motor de implementación y no seleccionar el primer comando de ejecución, se repara y selecciona automáticamente: Política de ejecución de Powershell: ejecuta el motor de implementación sin restricciones.
	Unattend_Version_Tips           = Opcionalmente, incluya solo, use el valor predeterminado para admitir ARM64, x64, x86.
	First_Run_Commmand              = Comandos a ejecutar al implementar por primera vez
	First_Run_Commmand_Setting      = Seleccione el comando para ejecutar
	Command_Not_Class               = Ya no se clasifica automáticamente al filtrar
	Command_WinSetup                = Instalación de windows
	Command_WinPE                   = Windows PE
	Command_Tips                    = Asigne la primera ejecución para que se aplique a: instalación de Windows, Windows PE\n\nTenga en cuenta que cuando se agrega un motor de implementación, debe verificar la primera ejecución: Política de ejecución de Powershell: restringida, permite ejecutar scripts del motor de implementación.
	Waring_Not_Select_Command       = Al agregar un motor de implementación, no se seleccionó la política de ejecución de Powershell: no establezca ninguna restricción y permita que se ejecute el script del motor de implementación, selecciónelo e inténtelo nuevamente, o haga clic en "La solución rápida no está seleccionada".
	Quic_Fix_Not_Select_Command     = Solución rápida, no opción

	PowerShell_Unrestricted         = Política de ejecución de Powershell: sin restricciones
	Allow_Running_Deploy_Engine     = Permitir que se ejecuten los scripts del motor de implementación
	Bypass_TPM                      = Omitir las comprobaciones de TPM durante la instalación
'@