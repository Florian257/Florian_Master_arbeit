#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("30Au7FeBPnoNorm_BGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT , 668, 229 , 1 )
Sleep(500)
Send ("{RIGHT}")
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,712,211, 1 )
Sleep(200)
MouseClick ($MOUSE_CLICK_LEFT ,635,248, 1 )
Sleep(1000)
Send ("{ENTER}")

WEnd
Global $g_bPaused = False
