#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("15Au7FeBP2 - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,912,237, 1 )
Sleep(500)
Send ("{RIGHT}")
Sleep(500)
MouseClick ($MOUSE_CLICK_LEFT ,959,213, 1 )
Sleep(400)
MouseClick ($MOUSE_CLICK_LEFT ,861,260, 1 )
Sleep(600)

WEnd
Global $g_bPaused = False
