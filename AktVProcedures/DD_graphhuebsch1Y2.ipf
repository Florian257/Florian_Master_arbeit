	#pragma rtGlobals=1		// Use modern global access method.
Menu "Macros"
	" Plot /S1" ,plot() 
	End
Function plot()
	ModifyGraph fStyle=1,fSize=10,font="Helvetica"
	ModifyGraph mirror(bottom)=2
	ModifyGraph margin(left)=37,margin(bottom)=34,width=201.26,height=143.717
	ModifyGraph tick=1.5,mirror=2,expand=3
 	Label left " pH \u "
	Label bottom " Delta V ml "
	ShowInfo 
	ModifyGraph expand =3 
	SetAxis/A
	ShowTools
	ModifyGraph mode=0
	ModifyGraph prescaleExp(bottom)=0
	//ModifyGraph tick=2,fStyle=1,fSize=10,prescaleExp(right)=3,btLen=4,font="Helvetica",axRGB(right)=(1,16019,65535),tlblRGB(right)=(1,16019,65535),alblRGB(right)=(1,16019,65535);DelayUpdate
	ModifyGraph tick=2,fStyle=1,fSize=10
End

