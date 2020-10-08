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


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,938,446, 1 )
Sleep(500)
Send ("{RIGHT}")
Sleep(500)
MouseClick ($MOUSE_CLICK_LEFT ,979,427, 1 )
Sleep(400)
MouseClick ($MOUSE_CLICK_LEFT ,898,467, 1 )
Sleep(600)

WEnd
Global $g_bPaused = False
