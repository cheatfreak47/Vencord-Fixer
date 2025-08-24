# Vencord Fixer

A tiny program that automatically downloads and installs/updates Vencord for your Discord client invisibly and instantly.

## Usage
1. Download the latest `VencordFixer.exe` from Releases.
2. If Windows Defender flips out, allow it/add it as an exception. See below for why this happens.
3. Put it wherever you keep small programs (Desktop, `C:\Tools\`, etc.)
4. *(Optional)* Right-click > Create shortcut to place on:
   - Desktop
   - Start menu folder (`%APPDATA%\Microsoft\Windows\Start Menu\Programs`)
5. Open it and let it do its thing!

## What It Does
- Asks you if it can download the latest `VencordInstallerCli.exe` if missing
- Force-closes Discord (saves you the trouble)
- Updates VencordInstallerCli via `-update-self`
- Installs Vencord to your local Discord folder
- Restarts Discord automatically
- It does all that invisibly (no windows, popups, nothing)

## Windows Defender flipping out?
As of 1.0.1 it shouldn't do this anymore, but if it's complaining, it's because we download the latest `VencordInstallerCli.exe` from [Vencord.dev](https://vencord.dev) and execute it to Install/Update Vencord. You can see the source code for yourself above, or follow the build instructions to compile your own binary instead.

## Build Instructions
1. Install [AutoHotkey 1.1](https://www.autohotkey.com/download/ahk-install.exe)
2. Clone this repo: `git clone https://github.com/cheatfreak47/Vencord-Fixer.git`
3. Run the script with `--build` 

## Requirements
- Windows OS
- Discord installed in default `AppData\Local\Discord` location
- Internet connection (for initial VencordInstallerCli download)
