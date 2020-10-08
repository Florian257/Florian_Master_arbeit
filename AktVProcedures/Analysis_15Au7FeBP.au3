#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("15Au7FeBP_BGSnoNormtest - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")

Opt("MouseCoordMode",1)
Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(5)
MouseClick ($MOUSE_CLICK_LEFT,593,686,1)
Sleep(5)
Send("GiveWavename()")
Sleep(5)
Send("{Enter}")
Sleep(5)
MouseClickDrag ($MOUSE_CLICK_LEFT,594,662,672,664)
Sleep(250)
MouseClick ($MOUSE_CLICK_Right,626,662,1)
Sleep(5)
MouseClick ($MOUSE_CLICK_left,678,288,1)
Sleep(5)
Send("{Up}")
Sleep(5)
Send("{Up}")
Sleep(5)
Send("{Enter}")
Sleep(5)
Send("{Left}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
Send("{BACKSPACE}")
Sleep(5)
MouseClick ($MOUSE_CLICK_Right,709,686,1)
Sleep(5)
MouseClick ($MOUSE_CLICK_Left,776,332,1)
Sleep(100)
Send("{Enter}")
Sleep(350)
Send("{Enter}")
WEnd
Global $g_bPaused = False
