Windows Installer
==================
These are instructions to create installer for Osdag version 2026.02.0.0 and above for Windows.

## 1. Prepare Build Environment
Create and activate a clean build environment:
```
conda create -n bld-env python=3.12
conda activate bld-env
conda install constructor -c conda-forge

```
## 2. Ensure Osdag Conda Package Exists
Before building the installer:
- Build the Osdag conda package.
- Upload it to osdag-admin conda channel.
- Confirm the correct version is available:
```
conda search osdag -c osdag
```

## 3. Project Structure
Constructor project directory(new-constructor-installer) should contains:
```
constructor-installer/
│
├── construct.yaml
├── license.txt
├── Osdag.ico
├── post_install.bat
├── pre_uninstall.bat
├── create_shortcuts.ps1
├── remove_shortcuts.ps1
├── launch_osdag.vbs
├── Uninstall-osdag.sh
├── post_install.sh
```
No need to manually bundle anything, Constructor resolves and bundles everything from conda packages automatically.

## 4. Build Installer
Activate environment, go to Contructor project drectory and run constructor 
```
conda activate bld-env
cd \path\to\WindowsInstaller\new-contructor-installer
constructor .
```
The .exe/.sh installer will be created in the current directory.

## 5. Customizing Installer UI (Removing Default Header/Welcome Image)
Constructor internally generates an NSIS script from:
```
<conda_env>\Lib\site-packages\constructor\nsis\main.nsi.tmpl
```
If you want to remove the default welcome and header images in windows GUI installer:
#### 1. Open
```
<conda_env>\Lib\site-packages\constructor\nsis\main.nsi.tmpl
```
#### 2. Comment out lines:
- 197–199
- 197–199
These correspond to default welcome/header image definitions.
#### 3. Save the file.
#### 4. Save the file.
```
constructor .
```
## 6. Shortcut and Registry Management
Shortcuts and uninstall entries in windows are handled via:
- `post_install.bat`
- `pre_uninstall.bat`
- `create_shortcuts.ps1`
- `remove_shortcuts.ps1`
All-users installs use HKLM (64-bit registry view). All-users installs use HKLM (64-bit registry view).

In linux
- `post_install.sh`
creates startmenu shortcuts for launch and uninstall of osdag.



## 7 What Is No Longer Required
The following legacy steps are removed:

- ❌ Manual Miniconda bundling
- ❌ Manual dependency copying
- ❌ Manual LaTeX packaging
- ❌ PyInstaller wrapping of installer components
- ❌ Writing full NSIS script manually

## 8. Summary
Old workflow:
`Manual NSIS + Miniconda + dependency packaging + source bundling.`
New workflow:
`Conda package → Constructor → Installer.`

Cleaner. Reproducible. Maintainable.