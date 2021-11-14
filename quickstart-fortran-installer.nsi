; NSIS Installer script for the Quickstart Fortran Command Line

; ---------------- Properties ----------------
; Name used in installer GUI
Name "Quickstart Fortran"

; Name for folder location and reg key
!define INSTALL_NAME "quickstart_fortran"

; Name of Start Menu group folder
!define SM_FOLDER "Quickstart Fortran"

; Installer icon
!define MUI_ICON "fortran-lang.ico"

; Compress installer
SetCompress auto

; Always produce unicode installer
Unicode true

; ---------------- Setup ----------------
; Use EnVar plugin (https://nsis.sourceforge.io/EnVar_plug-in)
!addplugindir ".\nsis-plugins\EnVar_plugin\Plugins\x86-unicode"

; Use the 'Modern' Installer UI macros
!include "MUI2.nsh"

; Default installation folder (local)
InstallDir "$LOCALAPPDATA\${INSTALL_NAME}"
  
; Get installation folder from registry if available
InstallDirRegKey HKCU "Software\${INSTALL_NAME}" ""

; Request application privileges
RequestExecutionLevel user


; ---------------- Installer Pages ----------------
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES


; ---------------- Uninstaller Pages ----------------
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

  
; MUI Language
!insertmacro MUI_LANGUAGE "English"


; ---------------- Component: Core Installation ----------------
Section "-Quickstart Fortran" SecCore

  SetOutPath "$INSTDIR"

  File "quickstart_cmd.bat"
  File "init.bat"
  File /r "utils"
  File "fortran-lang.ico"

  CreateDirectory "$SMPROGRAMS\${SM_FOLDER}"
  CreateShortcut "$SMPROGRAMS\${SM_FOLDER}\Launch Command Line.lnk" "$INSTDIR\quickstart_cmd.bat" "" "$INSTDIR\fortran-lang.ico"
  CreateShortcut "$SMPROGRAMS\${SM_FOLDER}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

  ; Store installation folder
  WriteRegStr HKCU "Software\${INSTALL_NAME}" "" $INSTDIR
  
  ; Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


; ---------------- Component: Mingw64 ----------------
Section "GFortran Compiler" SecGFortran

  SetOutPath "$INSTDIR"
  
  File /r "mingw64"
  
SectionEnd


; ---------------- Component: fpm ----------------
Section "FPM" SecFPM

  SetOutPath "$INSTDIR"
  
  File /r "fpm"

SectionEnd


; ---------------- Component: Git ----------------
Section "Git for Windows" SecGit

  SetOutPath "$INSTDIR"
  
  File /r "MinGit"

SectionEnd


; ---------------- Component: Desktop Shortcut ----------------
Section "Desktop Shortcut" SecDesktopShortcut

  CreateShortcut "$DESKTOP\QuickStart Fortran Command Line.lnk" "$INSTDIR\quickstart_cmd.bat" "" "$INSTDIR\fortran-lang.ico"

SectionEnd


; ---------------- Component: Add to PATH ----------------
Section "Add to path" SecPath

  EnVar::SetHKCU

  EnVar::AddValue "PATH" "$INSTDIR\mingw64\bin"
  EnVar::AddValue "PATH" "$INSTDIR\fpm"
  EnVar::AddValue "PATH" "$INSTDIR\MinGit\mingw64\bin"
  EnVar::AddValue "PATH" "$INSTDIR\utils"

SectionEnd


; ---------------- Uninstaller ----------------
Section "Uninstall"

  Delete "$DESKTOP\QuickStart Fortran Command Line.lnk"

  RMDir /r "$INSTDIR"
  RMDir /r "$SMPROGRAMS\${SM_FOLDER}"

  DeleteRegKey /ifempty HKCU "Software\${INSTALL_NAME}"

  EnVar::SetHKCU

  EnVar::DeleteValue "PATH" "$INSTDIR\mingw64\bin"
  EnVar::DeleteValue "PATH" "$INSTDIR\fpm"
  EnVar::DeleteValue "PATH" "$INSTDIR\MinGit\mingw64\bin"
  EnVar::DeleteValue "PATH" "$INSTDIR\utils"

SectionEnd


; ---------------- Component description Strings (EN) ----------------
LangString DESC_SecGFortran ${LANG_ENGLISH} "The open source GCC GFortran compiler for Windows (MinGW-w64-msvcrt, winlibs.com)"
LangString DESC_SecFPM ${LANG_ENGLISH} "The Fortran Package Manager"
LangString DESC_SecGit ${LANG_ENGLISH} "Git version control (required for FPM)"
LangString DESC_SecDesktopShortcut ${LANG_ENGLISH} "Desktop shortcut to command line launcher"
LangString DESC_SecPath ${LANG_ENGLISH} "Add new installation to user PATH variable"


!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGFortran} $(DESC_SecGFortran)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecFPM} $(DESC_SecFPM)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGit} $(DESC_SecGit)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktopShortcut} $(DESC_SecDesktopShortcut)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPath} $(DESC_SecPath)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
