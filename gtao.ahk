; version 2021060100 ; don't touch this line please

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 25, 20  ; Key press delays

tryUpdate()

#IfWinActive ahk_class grcWindow

^+t::
;SendInput,{Shift}{Ctrl} ; Try to release modifier keys
CbText := StrReplace(Clipboard, "`t", "  ")
Loop, Parse, CbText, `n, `r
{
  sendMessageToChat(A_LoopField)
}
return

^+v::
;SendInput,{Shift}{Ctrl} ; Try to release modifier keys
Send {raw}%Clipboard%
return

sendMessageToChat(text) {
  SendRaw t
  Sleep 100
  Send {raw}%text%
  Send {Enter}
  Sleep 1000
}

tryUpdate() {
  URLDownloadToFile, https://raw.githubusercontent.com/bill876/gta-online-ahk/main/gtao.ahk, update.txt
  if (errorlevel) {
    FileDelete, update.txt
    return
  }

  FileReadLine, newVersion, update.txt, 1
  FileReadLine, currentVersion, %A_ScriptName%, 1
  if (newVersion = currentVersion) {
    FileDelete, update.txt
  } else if InStr(update, " version" ) {
    FileCopy, update.txt, %A_ScriptName%, 1
    FileDelete, update.txt
    Reload
  }
  FileDelete, update.txt
}