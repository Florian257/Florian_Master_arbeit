#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("5Au7FeFPnormBGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(500)
Send ("{RIGHT}")
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT , 1177, 328 , 1 )
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT , 1078, 379 , 1 )
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT , 1120, 351 , 1 )

WEnd
Global $g_bPaused = False
