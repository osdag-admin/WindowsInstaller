# Windows Installer

This installer installs **Osdag** along with all required runtime
dependencies using a constructor-based bundled Conda environment.

Unlike earlier versions, this installer does **not** separately install
Miniconda or MiKTeX through manual steps. All required dependencies are
bundled and configured automatically.

And also support GUI installer for windows(.exe) and cli installer for linux(.sh).

------------------------------------------------------------------------

## System Requirements

### Supported Windows Operating Systems

-   Windows 10
-   Windows 11
-   Any linux-64 distribution

> Older versions (Vista, 7, 8, 8.1) are no longer officially supported.

### Supported Architecture

-   64-bit only

### RAM and Storage

-   **Minimum RAM:** 4 GB
-   **Recommended RAM:** 8 GB or higher
-   **Minimum Disk Space:** 12 GB

------------------------------------------------------------------------

## Uninstalling Earlier Versions of Osdag

If a previous version of Osdag is installed, it is strongly recommended
to uninstall it before installing a new version.

### Method 1 (Recommended)

1.  Open **Control Panel → Programs and Features**
2.  Select **Osdag**
3.  Click **Uninstall**

### Method 2

1.  Navigate to the installation directory

2.  Run:

        Uninstall-Osdag.exe

------------------------------------------------------------------------

On linux click `Uninstall-osdag` from startmenu.

## Installation Steps

1.  Download the installer:

        Osdag-<Version>-Windows-x86_64.exe or
        Osdag-<Version>-Linux-x86_64.sh


2.  Double-click the installer to start installation in windows. In linux open terminal and run `~/path/to/Osdag-<Version>-Linux-x86_64.sh` 

3.  Follow the on-screen instructions:

    -   Click **Next**
    -   Read and accept the license agreement
    -   Choose installation scope:
        -   *Just Me* (recommended)
        -   *All Users* (requires administrator privileges)
    -   Select installation directory
    -   Click **Install**

4.  Wait for installation to complete.

    > Installation may take several minutes as the Conda environment is
    > being configured.

5.  Click **Finish** once installation completes.

------------------------------------------------------------------------

## What Happens During Installation

The installer automatically:

-   Creates a dedicated Conda runtime environment
-   Installs Osdag and its dependencies
-   Configures required Python packages
-   Sets up shortcuts (if selected) via post_install script
-   Registers Osdag in Windows Programs and Features


------------------------------------------------------------------------

## Running Osdag

After installation, Osdag can be launched using any of the following
methods:

1.  Double-click the **Desktop shortcut**

2.  Press the **Windows key** and search for `Osdag`

3.  Navigate to the installation directory and run:

        Osdag.exe

------------------------------------------------------------------------

## Notes

-   For system-wide installation, administrative privileges are
    required.
-   The installer automatically handles registry entries and
    uninstallation metadata.

------------------------------------------------------------------------

## Troubleshooting

If installation fails:

1.  Ensure sufficient disk space is available.
2.  Run the installer as Administrator (for All Users install).
3.  Temporarily disable antivirus software if it interferes with
    execution.

------------------------------------------------------------------------

## Contact

For support and updates:\
https://osdag.fossee.in
