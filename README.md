# Quickstart Fortran on Windows

__An easy Windows installer and launcher for GFortran and the Fortran Package Manager__

Download the latest installer from the [__Releases Page__](https://github.com/LKedward/quickstart-fortran/releases/tag/Latest)

__Note: the installer takes a little while to startup due to it size, please be patient.__

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

## FAQ

### Do I need to be administrator to install this?

No, the installer will install files to the `AppData` directory for the current user (`C:\Users\<user>\AppData\Local`).


### How can I install `stdlib` with this?

First, run the installer, making sure that GFortran, fpm and Git are selected. After install,
open up the commmand window using the `Quickstart Fortran` shortcut on the desktop or in the start menu.
At the command window type `setup-stdlib` and press ENTER.
This will fetch the latest version of `stdlib` and install it to the local GFortran installation.

__Note: The `setup-stdlib` script only works with the GFortran installation provided with this installer - it cannot
currently detect existing GFortran installations.__


## About

The installer is built using the [Nullsoft Scriptable Install System](https://nsis.sourceforge.io/Download).

See [`quickstart-fortran-installer.nsi`](./quickstart-fortran-installer.nsi) for the configuration file and
[`make_installer.yml`](./.github/workflows/make_installer.yml) for the Github actions workflow.

The GNU Compiler Collection v10.3.0
is sourced from [WinLibs](https://winlibs.com/) based on the [MinGW-w64](https://www.mingw-w64.org/) project linked with MSVCRT.




