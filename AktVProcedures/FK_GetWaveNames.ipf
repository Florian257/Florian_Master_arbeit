#pragma rtGlobals=1		// Use modern global access method.
#include ":User procedures:i_2PPE:i_2PPE", version>=2.00


Function GiveWavename()
Make/N=1/O NameStampsl
Make/N=1/O NameStampso
Make/N=1/O NameStampso2
Make/N=1/O NameStampsi
Make/N=1/O NameStampsi2
Make/N=1/O NameStampsl2
NameStampsl = NameStampsl+1
	if(Namestampsl==10)
		NameStampsl=0
		NameStampso = NameStampso+1
			if(Namestampso==10)
				Namestampso=0
				NameStampsi = NameStampsi+1
			endif
	endif
Namestampso2=Namestampso
NameStampsl2= NameStampsl+1
if(Namestampsl2==10)
		NameStampsl2=0
		NameStampso2 = NameStampso2+1
			if(Namestampso2==10)
				Namestampso2=0
				NameStampsi2 = NameStampsi2+1
			endif
	endif
		String basewavename ="EDC"
		String Zwischenteil = "_"
		String firstPart
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, Namestampsi, Namestampso, Namestampsl, Zwischenteil, Namestampsi2, Namestampso2, Namestampsl2
			Print firstPart


End

Function GWN4steps()
Make/N=1/O NameStampsl
Make/N=1/O NameStampso
Make/N=1/O NameStampso2
Make/N=1/O NameStampsi
Make/N=1/O NameStampsi2
Make/N=1/O NameStampsl2
NameStampsl = NameStampsl+4
	if(Namestampsl==12)
		NameStampsl=2
		NameStampso = NameStampso+1
			if(Namestampso==10)
				Namestampso=0
				NameStampsi = NameStampsi+1
			endif
	endif
		if(Namestampsl==10)
		NameStampsl=0
		NameStampso = NameStampso+1
			if(Namestampso==10)
				Namestampso=0
				NameStampsi = NameStampsi+1
			endif
	endif
Namestampso2=Namestampso
NameStampsl2= NameStampsl+4

if(Namestampsl2==12)
		NameStampsl2=2
		NameStampso2 = NameStampso2+1
			if(Namestampso2==10)
				Namestampso2=0
				NameStampsi2 = NameStampsi2+1
			endif
	endif
if(Namestampsl2==10)
		NameStampsl2=0
		NameStampso2 = NameStampso2+1
			if(Namestampso2==10)
				Namestampso2=0
				NameStampsi2 = NameStampsi2+1
			endif
	endif
		String basewavename ="EDC"
		String Zwischenteil = "_"
		String firstPart
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, Namestampsi, Namestampso, Namestampsl, Zwischenteil, Namestampsi2, Namestampso2, Namestampsl2
			Print firstPart


End

Function GWN2steps()
Make/N=1/O NameStampsl
Make/N=1/O NameStampso
Make/N=1/O NameStampso2
Make/N=1/O NameStampsi
Make/N=1/O NameStampsi2
Make/N=1/O NameStampsl2
NameStampsl = NameStampsl+2

		if(Namestampsl==10)
		NameStampsl=0
		NameStampso = NameStampso+1
			if(Namestampso==10)
				Namestampso=0
				NameStampsi = NameStampsi+1
			endif
	endif
Namestampso2=Namestampso
NameStampsl2= NameStampsl+2

if(Namestampsl2==10)
		NameStampsl2=0
		NameStampso2 = NameStampso2+1
			if(Namestampso2==10)
				Namestampso2=0
				NameStampsi2 = NameStampsi2+1
			endif
	endif
		String basewavename ="EDC"
		String Zwischenteil = "_"
		String firstPart
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, Namestampsi, Namestampso, Namestampsl, Zwischenteil, Namestampsi2, Namestampso2, Namestampsl2
			Print firstPart


End


Function GiveallWavenames()

variable n=10
variable i,o,l
variable z,t,r
//i=erste stelle
//o zweite stelle
//l dritte stelle
String basewavename ="EDC"
String Zwischenteil = "_"
String firstPart
	for(i=0; i<n; i+=1)

		for(o=0; o<n; o+=1)
		t=o
			for(l=0; l<n; l+=1)
			r=l+1
			if(r==10)
			r=0
			t=t+1
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, i, o, l, Zwischenteil, i, t, r
			else
			
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, i, o, l, Zwischenteil, i, t, r
			
			endif
			if(t==10)
			t=0
			sprintf firstPart, "%s%d%d%d%s%d%d%d", basewavename, i, o, l, Zwischenteil, i+1, t, r
			endif
			
			Print firstPart
			endfor
		endfor
	endfor
End
//#########################################################
