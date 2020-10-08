#pragma rtGlobals=1		// Use modern global access method.
Menu "Macros"
	" Graph with 2 y axes /S7" ,GraphHuebsch2Y() 
	End
Function GraphHuebsch2Bilder()
	ModifyGraph fStyle=1,fSize=10,font="Helvetica"
	ModifyGraph mirror(bottom)=2
	ModifyGraph mirror=2
	ModifyGraph margin(left)=31,margin(bottom)=28,width=180,height=120
	ModifyGraph tick=2,expand=3
	Label bottom "\\Z10 E [eV]"
	Label left "\\Z10PES intensity [arb.u.]"
	Label right "\\Z10 2nd y axis label"
	Legend/C/N=text0/J/F=0	
	ShowInfo 
End

Function GraphHuebsch1Bild()
	ModifyGraph fStyle=1,fSize=12,font="Helvetica"
	ModifyGraph mirror(bottom)=2
	ModifyGraph mirror=2
	ModifyGraph margin(left)=31,margin(bottom)=28,width=180,height=120
	ModifyGraph tick=2,expand=3
	Label bottom "\\Z12\\f03 E - E\\f01\\BF\\M\\Z12 (eV)"
	Label left "\\Z12energy density [µJ/cm²]"
	Legend/C/N=text0/J/F=0	
	ShowInfo 
	ModifyGraph lowTrip(left)=0.01
	TextBox/C/N=text1/B=1
End