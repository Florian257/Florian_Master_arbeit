#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("5Au7FeFPNoNorm_BGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,678,217, 1 )
Sleep(500)
Send ("{RIGHT}")
Sleep(500)
MouseClick ($MOUSE_CLICK_LEFT ,730,199, 1 )
Sleep(400)
MouseClick ($MOUSE_CLICK_LEFT ,654,238, 1 )
Sleep(400)

WEnd
Global $g_bPaused = False
