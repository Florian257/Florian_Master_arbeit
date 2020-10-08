#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("30Au7FeFPnormBGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
Sleep(5)
MouseClick ($MOUSE_CLICK_LEFT , 1004, 467 , 1 )
Sleep(5)
Send("GiveWavename()")
Sleep(5)
Send("{Enter}")
WEnd
Global $g_bPaused = False
