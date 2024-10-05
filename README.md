# Introduction

This installer installs Osdag (along with Miniconda, MiKTeX and other dependecies required to run Osdag).
The installer is made using [NSIS](https://nsis.sourceforge.io/Main_Page)


# System Requirements:

1. Supported Windows Operating Systems:
	- Windows Vista
	- Windows 7
	- Windows 8
	- Windows 8.1
	- Windows 10
        - Windows 11

2. Supported Architecture(s):
	 - 64-bit

3. RAM and Storage Space:
	- Minimum RAM: 2GB 
	- Minimum (recommended) Storage Space: 4GB

 4. Microsoft Build tools
      - Install [MS Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) and add it to PATH.
          
	

# Uninstalling Earlier Version of Osdag:

If you have a previous version of Osdag installed then it is mandatory to uninstall the same.

1) Go to the location where Osdag was installed and run "Uninstall.exe".


# Installation steps:


  Run Osdag_windows_setup.exe
  
    # Follow on-screen instructions AND select the following options in the Setup:
	i) Double click on the osdag_windows_installer.exe to start the start the installation process. 
	ii) Click Next, then Install.
	iii) Read the License and click 'I Agree' to proceed.
	iv) Select the installation directory and click Next.
	v) Click Install.
	vi) Wait for the installation process to get over (this might take several minutes).
	vii) Accept the MiKTeX license and click Next.
	Viii) Choose the MiKTeX installation scope and click Next.
	ix) Select the installation directory and click Next.
	x) Keep the MiKTeX setting to default and click Next.
	xi) Click start to install MiKTeX.
	xii) Click Next.
	Xiii) (optional) You can check for MiKTeX package updates.
	xiv) After the process ends, click the Finish button.
	
	Osdag will be successfully installed!


# Running Osdag:


After the installation is complete, you may run Osdag by one of the following methods:
1. Double-clicking on the Desktop shortcut or
2. Press the Windows key and search Osdag 
3. Navigating to the installation-directory and double-clicking on the Osdag shortcut

# Creating Windows Installer Exe

1. Clone or download this repository.
2. Download Miniconda3-py37_23.1.0-1 and copy it to the Files folder, name it as 'Miniconda3-latest-Windows-x86_64.exe'
3. Download all required python dependencies (as listed in install_osdag_dependencies.bat file in dependencies folder) and copy them into the dependencies folder.
4. Download and move miktex-x64.exe into Files/latex folder.
5. Make exe of latex_package_installer.py and miktek_installer.py using [pyinstaller](https://pypi.org/project/pyinstaller/) and move the created .exe files (they will be created in dist folder) into latex folder.
6. Copy the [Osdag folder](https://github.com/osdag-admin/Osdag) into the 'Files' folder
7. Install NSIS Software and move the header files (environment files) to 'include' folder inside the Nsis installed Directory.
8. Compile the osdag.nsi using NSIS, the installer will be created in the same location as the osdag.nsi file.

# Fixes
- Modified NSIS script to install miniconda and add it to the path correctly.
- Fixed Pyqt5 installation Error. 
