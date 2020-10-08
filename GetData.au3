#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("Stepbystep5nmBP - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")

Opt("MouseCoordMode",1)
Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,882,222, 1 )
Sleep(1000)
Send ("{RIGHT}")
Sleep(500)
MouseClick ($MOUSE_CLICK_LEFT ,918,203, 1 )
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,840,242, 1 )
Send ("{ENTER}")

WEnd
Global $g_bPaused = False
