#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("15Au7FeFPnoNorm_BGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")

Opt("MouseCoordMode",1)
Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(5)
MouseClick ($MOUSE_CLICK_LEFT,336,643,1)
Sleep(5)
Send("GiveWavename()")
Sleep(5)
Send("{Enter}")
Sleep(5)
MouseClickDrag ($MOUSE_CLICK_LEFT,338,620,414,620)
Sleep(250)
MouseClick ($MOUSE_CLICK_Right,367,621,1)
Sleep(5)
MouseClick ($MOUSE_CLICK_left,426,249,1)
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
MouseClick ($MOUSE_CLICK_Right,453,646,1)
Sleep(5)
MouseClick ($MOUSE_CLICK_Left,512,286,1)
Sleep(100)
Send("{Enter}")
Sleep(350)
Send("{Enter}")
WEnd
Global $g_bPaused = False
