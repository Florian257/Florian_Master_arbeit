	#pragma rtGlobals=1		// Use modern global access method.
Menu "Macros"
	" Refractive Index  /7" ,n_index() 
	End
Function n_index()
	
	ModifyGraph fStyle=1,fSize=10,font="Helvetica"
	ModifyGraph mirror(bottom)=2
	//ModifyGraph margin(left)=37,margin(bottom)=34
	modifygraph width=201.26,height=143.717
	ModifyGraph tick=1.5,mirror=2,expand=3
	ModifyGraph prescaleExp(left)=0,mode=0
	ModifyGraph prescaleExp(bottom)=0
	ModifyGraph btLen=4
 	Label left "n (gc) "
	Label bottom "\\F'Symbol' l  \\F'Helvetica' [nm] "
	ShowInfo 
	//SetAxis bottom 32000,42000
	ModifyGraph expand =3 
	ShowTools
End

