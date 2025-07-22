# Vencord Fixer

A tiny program that automatically downloads and installs/updates Vencord for your Discord client invisibly and instantly.

## Usage
1. Download the latest `VencordFixer.exe` from Releases.
2. If Windows Defender flips out, allow the thread. See below for why this happens.
3. Put it wherever you keep small programs (Desktop, `C:\Tools\`, etc.)
4. *(Optional)* Right-click > Create shortcut to place on:
   - Desktop
   - Start menu folder (`%APPDATA%\Microsoft\Windows\Start Menu\Programs`)
5. Open it and let it do its thing!

## What It Does
- Downloads the latest `VencordInstallerCli.exe` if missing
- Force-closes Discord (saves you the trouble)
- Updates VencordInstallerCli via `-update-self`
- Installs Vencord to your local Discord folder
- Restarts Discord automatically
- It does all that invisibly (no windows, popups, nothing)

## Why does Windows Defender flip out?
It's because we download the latest VencordInstallerCli.exe from [Vencord.dev](https://vencord.dev) and then immediately execute it to... ya know. Install vencord. You can see the source code for yourself above, or follow the build instructions to compile your own binary instead.

## Build Instructions (Developers)
1. Install [AutoHotkey 1.1](https://www.autohotkey.com/download/ahk-install.exe)
2. Clone this repo: `git clone <repo-url>`
3. Run the script with `--build` 

## Requirements
- Windows OS
- Discord installed in default `AppData\Local\Discord` location
- Internet connection (for initial VencordInstallerCli download)
