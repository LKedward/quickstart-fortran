@echo off
REM Helper script to install latest stdlib in the local MinGW installation

setlocal

set ORIG=%cd%
set ROOT=%~dp0..

set GCCVER=11.2.0
set PREFIX=%ROOT%\mingw64
set INCLUDE_PATH=lib\gcc\x86_64-w64-mingw32\%GCCVER%\finclude\

echo Installation root is %ROOT%

cd %ROOT%

if NOT EXIST %ROOT%\mingw64 echo mingw64 installation not found && exit /b 1

if NOT EXIST %ROOT%\stdlib git clone https://github.com/fortran-lang/stdlib.git
if %errorlevel% neq 0 exit /b %errorlevel%

cd stdlib
git reset --hard
git checkout stdlib-fpm
git pull

echo [install] >> fpm.toml
echo library = true >> fpm.toml

REM Check output directory exists
if not exist "%PREFIX%\%INCLUDE_PATH%" (
  echo setup-stdlib error: Cannot find module include directory "%PREFIX%\%INCLUDE_PATH%"
  exit /B 3
)

fpm install --profile release --prefix %PREFIX% --includedir %INCLUDE_PATH% --verbose --flag "-DWITH_QP=1"
if %errorlevel% neq 0 exit /b %errorlevel%

del /Q %PREFIX%\%INCLUDE_PATH%\test*.mod

REM Check installation
set LIB_OUT="%PREFIX%\lib\libstdlib.a"
if not exist %LIB_OUT% (
  echo Installation failed: cannot find %LIB_OUT%
  exit /B 2
)
set INC_OUT="%PREFIX%\%INCLUDE_PATH%\stdlib_version.mod"
if not exist %INC_OUT% (
  echo Installation failed: cannot find %INC_OUT%
  exit /B 2
)

echo stdlib built and installed successfully

cd %ORIG%

endlocal