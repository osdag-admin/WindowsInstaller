;NSIS script for Osdag (Open Steel Design and Graphics) installer
;-----------------------------------------------------------------------
# Notes:
	;This installer installs Miniconda3, python dependencies silently
	;Then it installs Osdag in the system
	;It also creates a desktop shortcut and a shortcut inside the Osdag installation folder
	;

;-----------------------------------------------------------------------
; Include scripts

	;Header file to update the path
	!include EnvVarUpdate.nsh

	;Header file for refreshing the environment (and it is variables) before installing the python dependencies
	!include RefreshEnvironment.nsh

	;NSIS Modern User Interface
	!include MUI2.nsh

	;Set the environment variables
	!include x64.nsh
	
	!include Sections.nsh


;-----------------------------------------------------------------------
;General Installer Settings

	;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
	;Unicode true

	;Declare name of installer file
	Name "Osdag"
	OutFile "Osdag_windows_setup.exe"
	
	;ComponentText "If you already have latex compiler installed, deselect Miktex"
	;ShowInstDetails show
	


	;Default installation directory
	InstallDir $EXEDIR\Osdag

	;Get installation folder from registry if available
	InstallDirRegKey HKLM "Software\Osdag" ""

	;Add Osdag branding and remove NSIS, in the installer
	BrandingText "Osdag version 2020.06.a.3839"

;-----------------------------------------------------------------------
;Declare Variables (User defined)
;RequestExecutionLevel highest
RequestExecutionLevel admin

;Page components

Var Start_menu_folder

!define MUI_ABORTWARNING
!define MUI_LANGDLL_ALLLANGUAGES
!define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
!define MUI_LANGDLL_REGISTRY_KEY "Software\Osdag"
!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"
!define INSTALLSIZE 2315093
;!define SECTION_ON ${SF_SELECTED}

;Start Menu Registry
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Osdag"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
!define MUI_ICON "Files\Osdag Icon.ico"
!define MUI_UNICON "Files\Osdag Icon.ico"
!define MUI_WELCOMEPAGE_TEXT "This Setup will guide you through the installation of Osdag  $\r$\n$\r$\nIt will also install some python dependencies that are required to run Osdag$\r$\n $\r$\nPLEASE UNINSTALL ANY EARLIER VERSION OF OSDAG on your system before going ahead (See README.txt for reference)$\r$\n $\r$\nPlease click Next only after uninstalling the earlier version"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Files\welcomefinishpage.bmp"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Files\License.txt"
;!insertmacro MUI_PAGE_COMPONENTS # Uncomment when Miniconda setup is embedded
;!insertmacro MUI_PAGE_DIRECTORY
;Following lines of code are for selecting default Osdag_workspace location
;!define $Osdag_workspace "$DESKTOP\Osdag_workspace"
;!define MUI_PAGE_HEADER_SUBTEXT "Select the default location for Osdag workspace"
;!define MUI_DIRECTORYPAGE_TEXT_TOP "Osdag workspace is the directory where all the design files will be saved. To select a different location, click Browse and specify a different lcoation. Click Next to continue."
;!define MUI_DIRECTORYPAGE_VARIABLE $Osdag_workspace
!insertmacro MUI_PAGE_DIRECTORY
;!define $Osdag_workspace MUI_DIRECTORYPAGE_VARIABLE

!insertmacro MUI_PAGE_STARTMENU Application $Start_menu_folder
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

;Uninstaller Design (/Layout)
!define MUI_WELCOMEPAGE_TEXT "This Setup will guide you through the uninstallation of Osdag. $\r$\n$\r$\nBefore starting the uninstallation, please make sure that Osdag is not running.$\r$\n$\r$\nClick Next to continue."
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;-----------------------------------------------------------------------
;Languages

!insertmacro MUI_LANGUAGE "English"
;!insertmacro MUI_LANGUAGE "German"
;!insertmacro REFRESH_ENVIRONMENT
;-----------------------------------------------------------------------
;User defined functions

Function update_path_miniconda

	;This function adds the paths required by Miniconda3 to the Path variable

	${EnvVarUpdate} $0 "PATH" "P" "HKLM" "$PROGRAMFILES32\miniconda3\Library\bin"
	${EnvVarUpdate} $0 "PATH" "P" "HKLM" "$PROGRAMFILES32\miniconda3\Scripts"
	${EnvVarUpdate} $0 "PATH" "P" "HKLM" "$PROGRAMFILES32\miniconda3"
	${EnvVarUpdate}	$0 "PATH" "P" "HKLM" "$INSTDIR"
FunctionEnd

Function create_osdag_launcher

	;Create Osdag.bat (This batch file, when invoked, will start Osdag.)
	FileOpen $0 "$INSTDIR\Osdag.bat" w
	FileWrite $0 "@setlocal enableextensions"
	FileWrite $0 "$\r$\n@cd /d $\"%~dp0$\""
	FileWrite $0 "$\r$\n@prompt Osdag:"
	FileWrite $0 "$\r$\n@cd /d $\"$INSTDIR$\""
	FileWrite $0 "$\r$\n@REM Please do not close this window."
	FileWrite $0 "$\r$\n@REM Please wait while Osdag is being initialized..."
	FileWrite $0 "$\r$\n@REM Osdag will display python console output in this window."
	FileWrite $0 "$\r$\n@echo off"
	FileWrite $0 "$\r$\npython osdagMainPage.py"
	FileWrite $0 "$\r$\n@REM Osdag was closed."
	FileClose $0
	FileOpen $0 "$INSTDIR\Osdag.vbs" w
	FileWrite $0 "Set oShell = CreateObject ($\"Wscript.Shell$\")"
	FileWrite $0 "$\r$\nDim strArgs"
	FileWrite $0 "$\r$\nstrArgs = $\"cmd /c Osdag.bat$\""
	FileWrite $0 "$\r$\noShell.Run strArgs, 0, false"
	FileClose $0

	;Create shortcut for Osdag.vbs
	CreateShortCut "$INSTDIR\Osdag.lnk" "$INSTDIR\Osdag.vbs" "" "$INSTDIR\ResourceFiles\images\Osdag Icon.ico" "" SW_SHOWMINIMIZED

FunctionEnd


Section "OSDAG" SEC01

	;This section installs Miniconda3 and installs the python dependencies

	SetDetailsPrint textonly
	DetailPrint "Installing: Miniconda3 (Please be patient as it might take a few minutes)"
	SetDetailsPrint listonly

		;Copy the Miniconda2 installation file to $TEMP folder to install silently from there
		SetOutPath $TEMP
		File "Files\Miniconda3-latest-Windows-x86_64.exe"

		;This command silently installs Miniconda3
		ExecWait "$TEMP\Miniconda3-latest-Windows-x86_64.exe /InstallationType=AllUsers /AddToPath=0 /RegisterPython=1 /S /D=$PROGRAMFILES32\miniconda3" $0
		Call update_path_miniconda
	SetDetailsPrint both

	Call RefreshProcessEnvironmentPath
	
	SetDetailsPrint textonly
	DetailPrint "Installing: Python dependencies (Please be patient as it might take a few minutes)"
	SetDetailsPrint listonly
		SetOutPath $TEMP\dependencies
		File /r "Files\dependencies\*.*"
		nsExec::ExecToLog "$TEMP\dependencies\install_osdag_dependencies.bat"

		SetOutPath "$PROGRAMFILES32\miniconda3\Lib\site-packages\"
	SetDetailsPrint both
	
	Call RefreshProcessEnvironmentPath
	;-----------------------------------------------------------
	SetDetailsPrint textonly
	DetailPrint "Installing: Osdag (Please be patient as it might take a few minutes)"
	SetDetailsPrint listonly
		SetOutPath $INSTDIR
		File /r "Files\Osdag\*.*"

		WriteRegStr HKLM "Software\Osdag" "" $INSTDIR
		WriteUninstaller "$INSTDIR\Uninstall_Osdag.exe"

		;Call create_config_file
		Call create_osdag_launcher

		!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		CreateDirectory "$SMPROGRAMS\$Start_menu_folder"
		CreateShortCut "$SMPROGRAMS\$Start_menu_folder\Osdag.lnk" "$INSTDIR\Osdag.bat" "" "$INSTDIR\ResourceFiles\images\Osdag Icon.ico" "" SW_SHOWMINIMIZED
		CreateShortCut "$SMPROGRAMS\$Start_menu_folder\Uninstall-Osdag.lnk" "$INSTDIR\Uninstall-Osdag.exe"
		!insertmacro MUI_STARTMENU_WRITE_END

		;Create Desktop shortcut
		CreateShortCut "$DESKTOP\Osdag.lnk" "$INSTDIR\Osdag.vbs" "" "$INSTDIR\ResourceFiles\images\Osdag Icon.ico" "" SW_SHOWMINIMIZED
	SetDetailsPrint both
	;-----------------------------------------------------------------------------------
	;This section is for deleting all the files and folders which were copied temporarily to the $TEMP folder

	SetDetailsPrint textonly
	DetailPrint "Deleting: temporary files"
	SetDetailsPrint listonly

		;Delete the miniconda3,installation files
		Delete "$TEMP\Miniconda3-latest-Windows-x86_64.exe"
		;Delete the dependencies folder
		RMDir /r "$TEMP\dependencies\"
		

	SetDetailsPrint both

SectionEnd

Section "MIKTEX" SEC02
	SetDetailsPrint textonly
	DetailPrint "Installing: Latex (Please be patient as it might take a few minutes)"
	SetDetailsPrint listonly
		SetOutPath $TEMP\latex
		File /r "Files\latex\*.*"
		ExecWait "$TEMP\latex\latex.exe"
		Call RefreshProcessEnvironmentPath
		ExecWait "$TEMP\latex\test.exe /S"
	SetDetailsPrint both
	Call RefreshProcessEnvironmentPath
	RMDir /r "$TEMP\latex\"
		
SectionEnd

Section "Uninstall"

	;Uninstaller Section

	;Remove Start Menu shortcuts
	!insertmacro MUI_STARTMENU_GETFOLDER Application $Start_menu_folder
	Delete "$SMPROGRAMS\$Start_menu_folder\Uninstall.lnk"
	RMDir /r "$SMPROGRAMS\$Start_menu_folder\"

	;Remove Desktop shortcut (if it exists)
	Delete "$DESKTOP\Osdag.lnk"

	;Remove installed files
	Delete "$INSTDIR\Uninstall Osdag.exe" ;Explicitly delete the Uninstaller
	RMDir /r "$INSTDIR\*"
	RMDir $INSTDIR
	
	ExecWait "$PROGRAMFILES32\miniconda3\Uninstall-Anaconda.exe /S /wait" $0

	RMDir /r "$PROGRAMFILES32\miniconda3\*"
	${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$PROGRAMFILES32\miniconda3\Library\bin"
	${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$PROGRAMFILES32\miniconda3\Scripts"
	${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$PROGRAMFILES32\miniconda3"
	${un.EnvVarUpdate} $0 "PATH" "P" "HKLM" "$INSTDIR"
	
	

	;Remove Registry Entry
	;Add /isempty parameter if the Osdag registry entry needs to be kept for future installation
	;Ideally, a clean uninstall also removes the registry entries.
	DeleteRegKey HKLM "Software\Osdag"

SectionEnd

Function .onInstSuccess

	;Function that calls a messagebox when installation finished correctly
	MessageBox MB_OK "You have successfully installed Osdag. Use the Desktop shortcut or the Start Menu shortcut to run Osdag.$\r$\n$\r$\nIf you face any problems (program crashing or not opening) while trying to run Osdag, please see 'Important Notes' section of 'README.txt'."

FunctionEnd

Function un.onUninstSuccess

	;Function that calls a messagebox when uninstallation finished correctly
	MessageBox MB_OK "You have successfully uninstalled Osdag."

FunctionEnd