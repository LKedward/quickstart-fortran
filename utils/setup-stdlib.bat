@echo off
REM Helper script to install latest stdlib in the local MinGW installation

set ORIG=%cd%
set ROOT=%~dp0..

echo Installation root is %ROOT%

cd %ROOT%

if NOT EXIST %ROOT%\mingw64 echo mingw64 installation not found && exit /b 1

if EXIST stdlib\ rmdir /S /Q stdlib

git clone https://github.com/fortran-lang/stdlib.git

cd stdlib
git checkout stdlib-fpm

echo [install] >> fpm.toml
echo library = true >> fpm.toml

fpm install --profile release --prefix %cd%\..\mingw64 --includedir lib\gcc\x86_64-w64-mingw32\10.3.0\finclude --verbose --flag "-DWITH_QP=1"

cd %ORIG%