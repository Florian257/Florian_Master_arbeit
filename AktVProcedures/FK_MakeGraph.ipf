


#pragma rtGlobals=1		// Use modern global access method.
#include ":User procedures:i_2PPE:i_2PPE", version>=2.00

// Meins
Function ElectronGraph()

ModifyGraph rgb=(0,0,0)
		
Legend/C/N=text0/J "\\s('Electrons_0.1eV') 'Electrons_0.1eV'\r\\s('Electrons_0.2eV') 'Electrons_0.2eV'\r\\s('Electrons_0.3eV') 'Electrons_0.3eV'";DelayUpdate
AppendText/N=text0 "\\s('Electrons_0.4eV') 'Electrons_0.4eV'\r\\s('Electrons_0.5eV') 'Electrons_0.5eV'\r\\s('Electrons_0.6eV') 'Electrons_0.6eV'";DelayUpdate
AppendText/N=text0 "\\s('Electrons_0.7eV') 'Electrons_0.7eV'\r\\s('Electrons_0.8eV') 'Electrons_0.8eV'\r\\s('Electrons_0.9eV') 'Electrons_0.9eV'";DelayUpdate
AppendText/N=text0 "\\s('Electrons_0.10eV') 'Electrons_1.0eV'\r\\s('Electrons_0.11eV') 'Electrons_1.1eV'\r\\s('Electrons_0.12eV') 'Electrons_1.2eV'";DelayUpdate
AppendText/N=text0 "\\s('Electrons_0.13eV') 'Electrons_1.3eV'\r\\s('Electrons_0.14eV') 'Electrons_1.4eV'\r\\s('Electrons_0.15eV') 'Electrons_1.5eV'";DelayUpdate
AppendText/N=text0 "\\s('Electrons_0.16eV') 'Electrons_1.6eV'\r\\s('Electrons_0.17eV') 'Electrons_1.7eV'"	
		
ModifyGraph rgb('Electrons_0.0eV')=(65280,0,0);DelayUpdate
ModifyGraph rgb('Electrons_0.1eV')=(65280,0,26112);DelayUpdate
ModifyGraph rgb('Electrons_0.2eV')=(65280,16384,55552);DelayUpdate
ModifyGraph rgb('Electrons_0.3eV')=(36864,14592,58880);DelayUpdate
ModifyGraph rgb('Electrons_0.4eV')=(0,0,65280);DelayUpdate
ModifyGraph rgb('Electrons_0.5eV')=(16384,28160,65280);DelayUpdate
ModifyGraph rgb('Electrons_0.6eV')=(0,43520,65280);DelayUpdate
ModifyGraph rgb('Electrons_0.7eV')=(0,52224,52224);DelayUpdate
ModifyGraph rgb('Electrons_0.8eV')=(0,65280,33024);DelayUpdate
ModifyGraph rgb('Electrons_0.9eV')=(0,39168,0);DelayUpdate
ModifyGraph rgb('Electrons_0.10eV')=(39168,39168,0);DelayUpdate
ModifyGraph rgb('Electrons_0.11eV')=(39168,13056,0);DelayUpdate
ModifyGraph rgb('Electrons_0.12eV')=(52224,0,0);DelayUpdate
ModifyGraph rgb('Electrons_0.13eV')=(65280,0,0)	;DelayUpdate
ModifyGraph rgb('Electrons_0.14eV')=(65280,21760,0);DelayUpdate
ModifyGraph rgb('Electrons_0.16eV')=(0,52224,52224);DelayUpdate
ModifyGraph rgb('Electrons_0.17eV')=(65280,0,26112)
	ModifyGraph mode=4
	Label left "energy density (J/cm²)"
	Label bottom "time delay (fs)"
	ModifyGraph minor(bottom)=1
	Legend/C/N=text0/A=RC/X=-2.25/Y=5.00
	ModifyGraph width=400,height=300

End

Function HolesGraph()

ModifyGraph rgb=(0,0,0)
			ModifyGraph marker('Holes_-0.1eV')=17,rgb('Holes_-0.1eV')=(65280,0,0);DelayUpdate
			ModifyGraph marker('Holes_-0.2eV')=16,rgb('Holes_-0.2eV')=(65280,0,0);DelayUpdate
			ModifyGraph marker('Holes_-0.3eV')=19,rgb('Holes_-0.3eV')=(65280,0,0);DelayUpdate
			ModifyGraph marker('Holes_0.1eV')=17,marker('Holes_0.2eV')=16
			Legend/K/N=text0
ModifyGraph marker('Holes_-0.4eV')=17,msize('Holes_-0.4eV')=2;DelayUpdate
ModifyGraph rgb('Holes_-0.4eV')=(0,52224,0),marker('Holes_-0.5eV')=16;DelayUpdate
ModifyGraph rgb('Holes_-0.5eV')=(0,52224,0),marker('Holes_-0.6eV')=19;DelayUpdate
ModifyGraph rgb('Holes_-0.6eV')=(0,52224,0),marker('Holes_0.4eV')=17;DelayUpdate
ModifyGraph rgb('Holes_0.4eV')=(0,0,65280),marker('Holes_0.5eV')=16;DelayUpdate
ModifyGraph rgb('Holes_0.5eV')=(0,0,65280),marker('Holes_0.6eV')=19;DelayUpdate
ModifyGraph rgb('Holes_0.6eV')=(0,0,65280)
Legend/C/N=text0/J/A=RC "\\s('Holes_-0.6eV') 'Holes_-0.6eV'\r\\s('Holes_-0.5eV') 'Holes_-0.5eV'\r\\s('Holes_-0.4eV') 'Holes_-0.4eV'";DelayUpdate
AppendText "\\s('Holes_-0.3eV') 'Holes_-0.3eV'\r\\s('Holes_-0.2eV') 'Holes_-0.2eV'\r\\s('Holes_-0.1eV') 'Holes_-0.1eV'\r\\s('Holes_0.0eV') 'Holes_0.0eV'";DelayUpdate
AppendText "\\s('Holes_0.1eV') 'Holes_0.1eV'\r\\s('Holes_0.2eV') 'Holes_0.2eV'\r\\s('Holes_0.3eV') 'Holes_0.3eV'\r\\s('Holes_0.4eV') 'Holes_0.4eV'";DelayUpdate
AppendText "\\s('Holes_0.5eV') 'Holes_0.5eV'\r\\s('Holes_0.6eV') 'Holes_0.6eV'"
			ModifyGraph marker('Holes_0.3eV')=19,msize('Holes_0.3eV')=0
			ModifyGraph mode=4
			Label left "n\\B+/- \\M(t)"
			Label bottom "time delay (fs)"
			ModifyGraph minor(bottom)=1
			Legend/K/N=text0
			Legend/C/N=text0/A=RC/X=-2.25/Y=5.00
	ModifyGraph width=400,height=300
	ModifyGraph msize=1
End