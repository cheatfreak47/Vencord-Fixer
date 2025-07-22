#NoEnv
#NoTrayIcon
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; =============== SELF BUILD VALIDATION ===============
if (!A_IsCompiled) {
    Loop, % A_Args.Length() {
        if (A_Args[A_Index] = "--build") {
            goto Build
        }
        break
    }
}

; =============== MAIN OPERATION ===============

;Check if VencordInstallerCli exists, if not, download it!
IfNotExist, VencordInstallerCli.exe
{
    UrlDownloadToFile, https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe, VencordInstallerCli.exe
    IfNotExist, VencordInstallerCli.exe
    {
        MsgBox, 16, Error, Failed to download VencordInstallerCli.exe. Please check your connection.
        ExitApp
    }
}

;Locate Discord
EnvGet, LocalAppData, LocalAppData
DiscordPath := LocalAppData . "\Discord\Update.exe"
;First we hardkill discord, no mercy.
RunWait, "taskkill" /f /im Discord.exe, , Hide
;Ask VencordInstallerCli to Update Self
RunWait, %ComSpec% /c "VencordInstallerCli.exe" -update-self, , Hide
;Ask VencordInstallerCli to Install Vencord
RunWait, %ComSpec% /c "VencordInstallerCli.exe" -location %LocalAppData%\Discord -install, , Hide
;Star Discord and Exit
Run, "%DiscordPath%" --processStart Discord.exe
ExitApp

; =============== BUILD SECTION ===============
Build:
    RegRead, InstallDir, HKEY_LOCAL_MACHINE, SOFTWARE\Wow6432Node\AutoHotkey, InstallDir
    if (ErrorLevel) {
        RegRead, InstallDir, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, InstallDir
    }
    if (ErrorLevel) {
        MsgBox, 48, Error, AutoHotkey not found in registry.
        ExitApp
    }

    ScriptName := SubStr(A_ScriptName, 1, InStr(A_ScriptName, ".",, 0) - 1)
    if FileExist(ScriptName . ".ico") {
        RunWait, "%InstallDir%\Compiler\ahk2exe.exe" /in "%A_ScriptFullPath%" /out "%A_WorkingDir%\%ScriptName%.exe" /icon "%ScriptName%.ico"
    } else {
        RunWait, "%InstallDir%\Compiler\ahk2exe.exe" /in "%A_ScriptFullPath%" /out "%A_WorkingDir%\%ScriptName%.exe"
    }
    MsgBox, 64, Success, Compiled successfully!
    ExitApp
return
