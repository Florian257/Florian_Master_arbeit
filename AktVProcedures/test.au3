#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <AutoItConstants.au3>
WinWaitActive("5Au7FeFP_BGS - Igor Pro 6.37")
HotKeySet("{ESC}", "Terminate")


Func Terminate()
    Exit
EndFunc   ;==>Terminate

While 1
MouseClick ($MOUSE_CLICK_LEFT ,493,198, 1 )
Send ("{RIGHT}")
MouseClick ($MOUSE_CLICK_LEFT ,534,179, 1 )
MouseClick ($MOUSE_CLICK_LEFT ,455,217, 1 )

WEnd
Global $g_bPaused = False
