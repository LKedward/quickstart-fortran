# Quickstart Fortran on Windows

__An easy Windows installer and launcher for GFortran and the Fortran Package Manager__

Download the latest installer from the [__Releases Page__](https://github.com/LKedward/quickstart-fortran/releases/tag/Latest)

![quickstart-fortran-installer-screenshot](screenshot.png)

## Features

- Installs locally, __no adminstrator account__ required
- Optionally add everything to the PATH for the local user
- Includes:
  - GCC-GFortran 10.3.0
  - Fortran Package Manager v0.4.0
  - Git for Windows v2.33.1 (_needed for fpm_)
  - OpenBLAS (BLAS/LAPACK) v0.3.17-1
- Extra utility commands
  - `intel-setvars` to initialise the Intel OneAPI environment (if installed)
  - `setup-stdlib` to build and install the latest version of the Fortran Standard Library 



## About

The installer is built using the [Nullsoft Scriptable Install System](https://nsis.sourceforge.io/Download).

See [`quickstart-fortran-installer.nsi`](./quickstart-fortran-installer.nsi) for the configuration file and
[`make_installer.yml`](./.github/workflows/make_installer.yml) for the Github actions workflow.

The GNU Compiler Collection v10.3.0
is sourced from [WinLibs](https://winlibs.com/) based on the [MinGW-w64](https://www.mingw-w64.org/) project linked with MSVCRT.




