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

; =============== UPDATED USER FLOW ===============
CheckForInstaller:
    ; Check script dir first (always priority)
    IfExist, VencordInstallerCli.exe
    {
        goto ExecuteVencord
    }

    ; Check Downloads folder second (stealth helper mode)
    EnvGet, UserProfile, UserProfile
    DownloadsPath := UserProfile . "\Downloads\VencordInstallerCli.exe"
    IfExist, %DownloadsPath%
    {
        FileCopy, %DownloadsPath%, VencordInstallerCli.exe, 1
        IfExist, VencordInstallerCli.exe
        {
            goto ExecuteVencord
        }
        else
        {
            MsgBox, 16, Error, Found file in Downloads but couldn't copy it!`n`nPlease move it manually to:`n%A_ScriptDir%
            goto WaitForUser
        }
    }

    ; Final fallback: Ask user to download
    MsgBox, 0x24, File Needed, VencordInstallerCli.exe is missing!`n`n1. Download from:`ngithub.com/Vencord/Installer`n2. Save to THIS folder:`n%A_ScriptDir%`n...or just drop in Downloads!`n`nClick YES to open download page.

    IfMsgBox, Yes
    {
        Run, https://github.com/Vencord/Installer/releases/latest
    }

WaitForUser:
    MsgBox, 0x40, Ready When You Are, Place VencordInstallerCli.exe in either:`n- THIS folder: %A_ScriptDir%`n- OR your Downloads folder`n`nThen click OK to continue.
    goto CheckForInstaller  ; Loop back like a responsible script

; =============== MAIN OPERATION ===============
ExecuteVencord:
    ; Murder Discord with extreme prejudice
    RunWait, taskkill /f /im Discord.exe,, Hide

    ; Update Vencord CLI (silent)
    RunWait, %ComSpec% /c "VencordInstallerCli.exe" -update-self,, Hide

    ; Install/Update Vencord
    EnvGet, LocalAppData, LocalAppData
    RunWait, %ComSpec% /c "VencordInstallerCli.exe" -location "%LocalAppData%\Discord" -install,, Hide

    ; Restart Discord like nothing happened
    Run, "%LocalAppData%\Discord\Update.exe" --processStart Discord.exe
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
