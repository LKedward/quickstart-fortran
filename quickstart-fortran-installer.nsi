; NSIS Installer script for the Quickstart Fortran Command Line

; 'Modern' Installer UI macros
!include "MUI2.nsh"

; Compress installer
SetCompress auto

; Installer anme
Name "Quickstart Fortran"

; Default installation folder (local)
InstallDir "$LOCALAPPDATA\quickstart_fortran"
  
; Get installation folder from registry if available
InstallDirRegKey HKCU "Software\quickstart_fortran" ""

; Request application privileges
RequestExecutionLevel user

; Interface Settings
!define MUI_ABORTWARNING

; Installer icon
!define MUI_ICON "fortran-lang.ico"



; ---------------- Installer Pages ----------------
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES


; ---------------- Uninstaller Pages ----------------
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!addplugindir ".\nsis-plugins\EnVar_plugin\Plugins\x86-unicode"

  
; Language
!insertmacro MUI_LANGUAGE "English"


Section "-Quickstart Fortran" SecCore

  SetOutPath "$INSTDIR"

  File "quickstart_cmd.bat"
  File "init.bat"
  File /r "utils"
  File "fortran-lang.ico"

  CreateDirectory "$SMPROGRAMS\Quickstart Fortran"
  CreateShortcut "$SMPROGRAMS\Quickstart Fortran\Launch Command Line.lnk" "$INSTDIR\quickstart_cmd.bat" "" "$INSTDIR\fortran-lang.ico"
  CreateShortcut "$SMPROGRAMS\Quickstart Fortran\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

  ;Store installation folder
  WriteRegStr HKCU "Software\quickstart_fortran" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


Section "GFortran Compiler" SecGFortran

  SetOutPath "$INSTDIR"
  
  File /r "mingw64"
  
SectionEnd


Section "FPM" SecFPM

  SetOutPath "$INSTDIR"
  
  File /r "fpm"

SectionEnd


Section "Git for Windows" SecGit

  SetOutPath "$INSTDIR"
  
  File /r "MinGit"

SectionEnd


Section "Desktop Shortcut" SecDesktopShortcut

  CreateShortcut "$DESKTOP\QuickStart Fortran Command Line.lnk" "$INSTDIR\quickstart_cmd.bat" "" "$INSTDIR\fortran-lang.ico"

SectionEnd

Section "Add to path" SecPath

  EnVar::SetHKCU

  EnVar::AddValue "PATH" "$INSTDIR\mingw64\bin"
  EnVar::AddValue "PATH" "$INSTDIR\fpm"
  EnVar::AddValue "PATH" "$INSTDIR\MinGit\mingw64\bin"
  EnVar::AddValue "PATH" "$INSTDIR\utils"

SectionEnd



;--------------------------------
;Descriptions

;Language strings
LangString DESC_SecGFortran ${LANG_ENGLISH} "The open source GCC GFortran compiler for Windows (MinGW-w64-msvcrt, winlibs.com)"
LangString DESC_SecFPM ${LANG_ENGLISH} "The Fortran Package Manager"
LangString DESC_SecGit ${LANG_ENGLISH} "Git version control (required for FPM)"
LangString DESC_SecDesktopShortcut ${LANG_ENGLISH} "Desktop shortcut to command line launcher"
LangString DESC_SecPath ${LANG_ENGLISH} "Add new installation to user PATH variable"

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGFortran} $(DESC_SecGFortran)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecFPM} $(DESC_SecFPM)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecGit} $(DESC_SecGit)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktopShortcut} $(DESC_SecDesktopShortcut)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecPath} $(DESC_SecPath)
!insertmacro MUI_FUNCTION_DESCRIPTION_END



; Uninstaller
Section "Uninstall"

  Delete "$DESKTOP\QuickStart Fortran Command Line.lnk"

  RMDir /r "$INSTDIR"
  RMDir /r "$SMPROGRAMS\Quickstart Fortran"

  DeleteRegKey /ifempty HKCU "Software\quickstart_fortran"

  EnVar::SetHKCU

  EnVar::DeleteValue "PATH" "$INSTDIR\mingw64\bin"
  EnVar::DeleteValue "PATH" "$INSTDIR\fpm"
  EnVar::DeleteValue "PATH" "$INSTDIR\MinGit\mingw64\bin"
  EnVar::DeleteValue "PATH" "$INSTDIR\utils"

SectionEnd