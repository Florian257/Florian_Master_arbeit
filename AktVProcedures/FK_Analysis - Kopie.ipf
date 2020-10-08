#pragma rtGlobals=1		// Use modern global access method.
#include ":User procedures:i_2PPE:i_2PPE", version>=2.00

// Meins
// ToDo:
// write different steps into the Summe
Function EnergyAverage(druckenSumme,druckenTimeevolution,druckenWeightedTimeevolution,w)
// Definiert die einzugebenden Variablen
Wave w
variable druckenSumme
variable druckenTimeevolution
variable druckenWeightedTimeevolution
//
variable NewData2
Variable color=3
Prompt Newdata2,"Add Data to existing Graphs?",popup,"Yes;No"
DoPrompt "Color Trace",NewData2
if( V_Flag )
return 0 // user canceled
endif

if(NewData2==2)

//Werden später benötigt
variable above0Holes=7, below0Holes=6
variable above0Electrons=18
//Fragt nach dem timedelay
String timedelay1
    Prompt timedelay1, "Enter timedelay of dataset"
    DoPrompt "Enter timedelay of dataset", timedelay1
//Ordner erstellen
String Workfolder = "Datafolder"
	NewDataFolder /O $Workfolder
SetDataFolder Datafolder 										// <----- DATAFOLDER
		make /N=(numpnts(w)-19) /O reduced_w
reduced_w = w[p+19]
Variable i, n=(999-19)
		make /N=(n/20) /O Summe
		make /N=(n/20) /O MedianEnergy

MedianEnergy= (0.005*x)*20-2.1
	
for(i=0;i<n;i+=20)
	Summe[i/20] = reduced_w[i]+reduced_w[i+1]+reduced_w[i+2]+reduced_w[i+3]+reduced_w[i+4]+reduced_w[i+5]+reduced_w[i+6]+reduced_w[i+7]+reduced_w[i+8]+reduced_w[i+9]+reduced_w[i+10]+reduced_w[i+11]+reduced_w[i+12]+reduced_w[i+13]+reduced_w[i+14]+reduced_w[i+15]+reduced_w[i+16]+reduced_w[i+17]+reduced_w[i+18]+reduced_w[i+19]
endfor
//Druckt ein Integriertes Spektrum

//Definiert Sachen für die Elektronen und Löcher
variable o
		make /N=(above0Holes+below0Holes) /O EnergyIntHoles
		make /N=(above0Holes+below0Holes) /O EnergyIntHolesx
	for(o=0;o<above0Holes;o+=1)	
		EnergyIntHoles[o+below0Holes] = Summe[o+21]
		EnergyIntHolesx[o+below0Holes]= MedianEnergy[o+21]
	endfor
//o ist sonst =/ 0 und macht Probleme
o=0
//für die Integration, lässt ersten Punkt aus um Löcher zu vermeiden
variable firstpointHoles = EnergyIntHoles[o+below0Holes]
	for(o=0;o<above0Holes;o+=1)
		EnergyIntHoles[o+below0Holes] = EnergyIntHoles[o+below0Holes]+EnergyIntHoles[(o-1)+below0Holes]
		EnergyIntHoles[below0Holes]= 0
	endfor
//Addiert ersten Punkt auf alle Werte
	for(o=0;o<above0Holes;o+=1)
		EnergyIntHoles[o+below0Holes] = EnergyIntHoles[o+below0Holes]+firstpointHoles
	endfor
	for(o=0;o<below0Holes;o+=1)	
		EnergyIntHoles[o] = Summe[-o+20]
		EnergyIntHolesx[o]= MedianEnergy[-o+20]
	endfor
//o ist sonst =/ 0 und macht Probleme
o=0
//jetzt kommt die Hole Integration
variable firstpointbelowHoles = EnergyIntHoles[o],k=0

	for(o=0;o<below0Holes;o+=1)
		EnergyIntHoles[o] = EnergyIntHoles[o]+EnergyIntHoles[(o-1)]
		EnergyIntHoles[k]= 0
	endfor
	
	for(o=0;o<below0Holes;o+=1)
		EnergyIntHoles[o] = (EnergyIntHoles[o]+firstpointbelowHoles)
	endfor
	
sort EnergyIntHolesx EnergyIntHolesx,EnergyIntHoles

	variable EnergystepsHoles
	 String baseName = "Holes_"
	    		for(i=0; i<(above0Holes+below0Holes); i+=1)
	    			String IntegrationszahlHoles
				sprintf IntegrationszahlHoles, "%s%d", baseName, i
				Make/O/N= (1) $IntegrationszahlHoles
				Wave xWave = $IntegrationszahlHoles
				xWave = EnergyIntHoles[i]
				endfor

// HIER FÄNGT DIE ELEKTRONEN RECHNUNG AN
variable below0Electrons=0
variable op
		make /N=(above0Electrons) /O EnergyIntElectrons
		make /N=(above0Electrons) /O EnergyIntElectronsx
	for(op=0;op<above0Electrons;op+=1)	
		EnergyIntElectrons[op] = Summe[op+21]
		EnergyIntElectronsx[op]= MedianEnergy[op+21]
	endfor
//op ist sonst =/ 0 und macht Probleme
op=0
//für die Integration, lässt ersten Punkt aus um Löcher zu vermeiden
variable firstpointElectrons = EnergyIntElectrons[op+below0Electrons]
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectrons[op+below0Electrons] = EnergyIntElectrons[op+below0Electrons]+EnergyIntElectrons[(op-1)+below0Electrons]
		EnergyIntElectrons[below0Electrons]= 0
	endfor
//Addiert ersten Punkt auf alle Werte
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectrons[op] = EnergyIntElectrons[op+below0Electrons]+firstpointElectrons
	endfor
//op ist sonst =/ 0 und macht Probleme
op=0
//jetzt kommt die Hole Integration
variable firstpointbelowElectrons = EnergyIntElectrons[op]
k=0
sort EnergyIntElectronsx EnergyIntElectronsx,EnergyIntElectrons
	variable EnergystepsElectrons
	 String baseNameElectrons = "Electrons_"
	    		for(i=0; i<(above0Electrons+below0Electrons); i+=1)
	    			String IntegrationszahlElectrons
				sprintf IntegrationszahlElectrons, "%s%d", baseNameElectrons, i
				Make/O/N= (1) $IntegrationszahlElectrons
				Wave xWave = $IntegrationszahlElectrons
				xWave = EnergyIntElectrons[i]
				endfor
// Make waves and put values in
//do the integration in 0.1 eV steps	ABOVE 0 eV


duplicate /O Summe SummeW
duplicate /O EnergyIntElectrons EnergyIntElectronsW
//print n
	for(i=0;i<(n/20);i+=1)
	SummeW [i]= Summe[i]*MedianEnergy[i]
	endfor
	//fixing 0.0eV Electrons
SummeW [21]= Summe[21]
	for(op=0;op<above0Electrons;op+=1)	
		EnergyIntElectronsW[op+below0Electrons] = SummeW[op+21]
		EnergyIntElectronsx[op+below0Electrons]= MedianEnergy[op+21]
	endfor
	
op=0
variable firstpointElectronsW = EnergyIntElectronsW[op+below0Electrons]

	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectronsW[op+below0Electrons] = EnergyIntElectronsW[op+below0Electrons]+EnergyIntElectronsW[(op-1)+below0Electrons]
		EnergyIntElectronsW[below0Electrons]= 0
	endfor
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectronsW[op+below0Electrons] = EnergyIntElectronsW[op+below0Electrons]+firstpointElectronsW
	endfor	
op=0
variable firstpointbelowElectronsW = EnergyIntElectrons[op]	
sort EnergyIntElectronsx EnergyIntElectronsx,EnergyIntElectronsW
//HIER
String baseNameW ="Electrons_"
	for(i=0; i<(above0Electrons); i+=1)
	    		String xNameW
			sprintf xNameW, "%s%d", baseNameW, i
			Make/O/N= (1) $xNameW
			Wave xWaveW = $xNameW
			xWaveW = EnergyIntElectronsW[i]
			endfor
// Make waves and put values in

Print "Finish"
variable makefolder=1
string foldername2 = "UsedData"
if(makefolder == 1)
NewDataFolder /O $foldername2
endif
SetDataFolder UsedData
		string yName1
						string baseName1 = "fs_reduced_w"
				sprintf yName1, "%s%s", timedelay1, baseName1
						duplicate /O ::reduced_w $yName1
	string yName2
	String baseName2 = "fs_Summe"
				sprintf yName2, "%s%s", timedelay1, baseName2
						duplicate /O ::Summe $yName2
   	string yName3
	String baseName3 = "fs_MedianEnergy"
				sprintf yName3, "%s%s", timedelay1, baseName3
						duplicate /O ::MedianEnergy $yName3
	string yName4
	String baseName4 = "fs_EnergyIntHoles"
				sprintf yName4, "%s%s", timedelay1, baseName4
						duplicate /O ::EnergyIntHoles $yName4
   	string yName5
	String baseName5 = "fs_EnergyIntHolesx"
				sprintf yName5, "%s%s", timedelay1, baseName5
				duplicate /O ::EnergyIntHolesx $yName5
				string yName12
	String baseName12 = "fs_SummeW"
				sprintf yName12, "%s%s", timedelay1, baseName12
						duplicate /O ::SummeW $yName12
	string yName13
	String baseName13 = "fs_EnergyIntElectronsW"
				sprintf yName13, "%s%s", timedelay1, baseName13
						duplicate /O ::EnergyIntElectronsW $yName13
						string yName29
	String baseName29 = "fs_EnergyIntElectrons"
				sprintf yName29, "%s%s", timedelay1, baseName29
						duplicate /O ::EnergyIntElectrons $yName29
	string yName30
	String baseName30 = "fs_EnergyIntElectronsx"
				sprintf yName30, "%s%s", timedelay1, baseName30
						duplicate /O ::EnergyIntElectronsx $yName30
				String Holes_1 = "Holes_-0.6eV"
						duplicate /O ::Holes_0 $Holes_1
				String Holes_2 = "Holes_-0.5eV"
						duplicate /O ::Holes_1 $Holes_2
				String Holes_3 = "Holes_-0.4eV"
						duplicate /O ::Holes_2 $Holes_3
				String Holes_4 = "Holes_-0.3eV"
						duplicate /O ::Holes_3 $Holes_4
				String Holes_5 = "Holes_-0.2eV"
						duplicate /O ::Holes_4 $Holes_5
				String Holes_6 = "Holes_-0.1eV"
						duplicate /O ::Holes_5 $Holes_6
				String Holes_7 = "Holes_0.0eV"
						duplicate /O ::Holes_6 $Holes_7
				String Holes_8 = "Holes_0.1eV"
						duplicate /O ::Holes_7 $Holes_8
				String Holes_9 = "Holes_0.2eV"
						duplicate /O ::Holes_8 $Holes_9
				String Holes_10 = "Holes_0.3eV"
						duplicate /O ::Holes_9 $Holes_10
				String Holes_11 = "Holes_0.4eV"
						duplicate /O ::Holes_10 $Holes_11
				String Holes_12 = "Holes_0.5eV"
						duplicate /O ::Holes_11 $Holes_12
				String Holes_13 = "Holes_0.6eV"
						duplicate /O ::Holes_12 $Holes_13
						
				String Electrons_0 = "Electrons_0.0eV"
						duplicate /O ::Electrons_0 $Electrons_0
				String Electrons_1 = "Electrons_0.1eV"
						duplicate /O ::Electrons_1 $Electrons_1
				String Electrons_2 = "Electrons_0.2eV"
						duplicate /O ::Electrons_2 $Electrons_2
				String Electrons_3 = "Electrons_0.3eV"
						duplicate /O ::Electrons_3 $Electrons_3
				String Electrons_4 = "Electrons_0.4eV"
						duplicate /O ::Electrons_4 $Electrons_4
				String Electrons_5 = "Electrons_0.5eV"
						duplicate /O ::Electrons_5 $Electrons_5
				String Electrons_6 = "Electrons_0.6eV"
						duplicate /O ::Electrons_6 $Electrons_6
				String Electrons_7 = "Electrons_0.7eV"
						duplicate /O ::Electrons_7 $Electrons_7
				String Electrons_8 = "Electrons_0.8eV"
						duplicate /O ::Electrons_8 $Electrons_8
				String Electrons_9 = "Electrons_0.9eV"
						duplicate /O ::Electrons_9 $Electrons_9
				String Electrons_10 = "Electrons_0.10eV"
						duplicate /O ::Electrons_10 $Electrons_10
				String Electrons_11 = "Electrons_0.11eV"
						duplicate /O ::Electrons_11 $Electrons_11
				String Electrons_12 = "Electrons_0.12eV"
						duplicate /O ::Electrons_12 $Electrons_12
				String Electrons_13 = "Electrons_0.13eV"
						duplicate /O ::Electrons_13 $Electrons_13
				String Electrons_14 = "Electrons_0.14eV"
						duplicate /O ::Electrons_14 $Electrons_14
				String Electrons_15 = "Electrons_0.15eV"
						duplicate /O ::Electrons_15 $Electrons_15
				String Electrons_16 = "Electrons_0.16eV"
						duplicate /O ::Electrons_16 $Electrons_16
				String Electrons_17 = "Electrons_0.17eV"
						duplicate /O ::Electrons_17 $Electrons_17
						
variable timedelayvar
sscanf timedelay1, "%g", timedelayvar			
make /O/N=1 timedelay
print timedelayvar
timedelay = timedelayvar
if(druckenSumme == 1)
	Display
	String IntGraphbase ="fs_Summe"
	    		String IntGraph
			sprintf IntGraph, "%s%s", timedelay1, IntGraphbase
			String IntGraphbasex ="fs_MedianEnergy"
	    		String IntGraphx
			sprintf IntGraphx, "%s%s", timedelay1, IntGraphbasex
			AppendtoGraph $IntGraph vs $IntGraphx
	ModifyGraph mode=4
	ModifyGraph rgb=(0,0,0)
	Label left "norm. PES intensity (arb. u.)"
	Label bottom "\\f02 E - E\\f00\\BF\\M (eV)"
	ModifyGraph minor(bottom)=1
	Legend/C/N=text0/A=RC/X=-2.25/Y=5.00
	ModifyGraph width=0,height=0
endif
String eV ="eV"
if(druckenTimeevolution == 1)
	Display
	String belowHolesGraphbase ="Holes_-0."
	for(i=1; i<(below0Holes+1); i+=1)
	    		String belowHolesGraph
			sprintf belowHolesGraph, "%s%d%s", belowHolesGraphbase, i, eV
			AppendtoGraph $belowHolesGraph vs timedelay
	endfor
		String aboveHolesGraphbase ="Holes_0."
				for(i=0; i<(above0Holes); i+=1)
	    				String aboveHolesGraph
					sprintf aboveHolesGraph, "%s%d%s", aboveHolesGraphbase, i, eV
					AppendtoGraph $aboveHolesGraph vs timedelay
				endfor
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
			ModifyGraph width=0,height=0
endif
if(druckenWeightedTimeevolution == 1)
	Display
	String ElectronsGraphbase ="Electrons_0."
	for(i=0; i<(above0Electrons); i+=1)
	    		String ElectronsGraph
			sprintf ElectronsGraph, "%s%d%s", ElectronsGraphbase, i, eV
			AppendtoGraph $ElectronsGraph vs timedelay
	endfor
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
endif
		
SetDataFolder ::
	Killwaves reduced_w Summe MedianEnergy EnergyIntHoles EnergyIntHolesx Holes_0 Holes_1 Holes_2 Holes_3 Holes_4 Holes_5 Holes_6 Holes_7 Holes_8 Holes_9 Holes_10 Holes_11 Holes_12 EnergyIntElectrons EnergyIntElectronsx Electrons_0 Electrons_1 Electrons_2 Electrons_3 Electrons_4 Electrons_5 Electrons_6 Electrons_7 Electrons_8 Electrons_9 Electrons_10 Electrons_11 Electrons_12 Electrons_13 Electrons_14 Electrons_15 Electrons_16 Electrons_17 SummeW EnergyIntElectronsW
SetDataFolder ::
Print "No"
elseif(NewData2==1)
SetDataFolder Datafolder
SetdataFolder UsedData
wave timedelay

Redimension/D /N=(numpnts(timedelay)+1) timedelay
make /O /N=1 timestamp
Print timedelay[(numpnts(timedelay)-2)]
timestamp = timedelay[(numpnts(timedelay)-2)]
timedelay[(numpnts(timedelay)-1)] = timestamp+5
//String timedelayAddData
 //   Prompt timedelayAddData, "Enter timedelay of dataset"
 //   DoPrompt "Enter timedelay of dataset", timedelayAddData
    
 //   variable timedelayAddDatavar
//sscanf timedelayAddData, "%g", timedelayAddDatavar	
 //  timedelay[numpnts(timedelay)] = timedelayAddDatavar
   SetDatafolder :: 				  //<----------- We are in DATAFOLDER
//Werden später benötigt
above0Holes=7
below0Holes=6
above0Electrons=18
//Fragt nach dem timedelay			
		make /N=(numpnts(w)) /O reduced_w
reduced_w = w[p]
n=(999)
		make /N=(n/20) /O Summe
		make /N=(n/20) /O MedianEnergy

MedianEnergy= (0.005*x)*20-2.20
	
for(i=0;i<n;i+=20)
	Summe[i/20] = reduced_w[i]+reduced_w[i+1]+reduced_w[i+2]+reduced_w[i+3]+reduced_w[i+4]+reduced_w[i+5]+reduced_w[i+6]+reduced_w[i+7]+reduced_w[i+8]+reduced_w[i+9]+reduced_w[i+10]+reduced_w[i+11]+reduced_w[i+12]+reduced_w[i+13]+reduced_w[i+14]+reduced_w[i+15]+reduced_w[i+16]+reduced_w[i+17]+reduced_w[i+18]+reduced_w[i+19]
endfor

//Definiert Sachen für die Elektronen und Löcher
		make /N=(above0Holes+below0Holes) /O EnergyIntHoles
		make /N=(above0Holes+below0Holes) /O EnergyIntHolesx
	for(o=0;o<above0Holes;o+=1)	
//		EnergyIntHoles[o+below0Holes] = Summe[o+21]
		EnergyIntHolesx[o+below0Holes]= MedianEnergy[o+22]
endfor
//o ist sonst =/ 0 und macht Probleme
//o=0
//für die Integration, lässt ersten Punkt aus um Löcher zu vermeiden
//firstpointHoles = EnergyIntHoles[o+below0Holes]
//	for(o=0;o<above0Holes;o+=1)
//		EnergyIntHoles[o+below0Holes] = EnergyIntHoles[o+below0Holes]+EnergyIntHoles[(o-1)+below0Holes]
//		EnergyIntHoles[below0Holes]= 0
//	endfor
//Addiert ersten Punkt auf alle Werte
//	for(o=0;o<above0Holes;o+=1)
//		EnergyIntHoles[o+below0Holes] = EnergyIntHoles[o+below0Holes]+firstpointHoles
//	endfor
//EnergyIntHoles[below0Holes]=w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[366]+w[367]+w[368]+w[369]
//Löcher
	
	for(o=0;o<below0Holes;o+=1)	
//		EnergyIntHoles[o] = Summe[-o+20]
	EnergyIntHolesx[o]= MedianEnergy[-o+22]
	endfor
//o ist sonst =/ 0 und macht Probleme
//o=0
//jetzt kommt die Hole Integration
//firstpointbelowHoles = EnergyIntHoles[o]
//k=0

//	for(o=0;o<below0Holes;o+=1)
//		EnergyIntHoles[o] = EnergyIntHoles[o]+EnergyIntHoles[(o-1)]
//		EnergyIntHoles[k]= 0
//	endfor
//	for(o=0;o<below0Holes;o+=1)
//		EnergyIntHoles[o] = (EnergyIntHoles[o]+firstpointbelowHoles)
//	endfor
	
//sort EnergyIntHolesx EnergyIntHolesx,EnergyIntHoles


//MANUELLE BERECHNUNG
EnergyIntHoles[0]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]+w[328]+w[329]+w[330]+w[331]+w[332]+w[333]+w[334]+w[335]+w[336]+w[337]+w[338]+w[339]+w[340]+w[341]+w[342]+w[343]+w[344]+w[345]+w[346]+w[309]+w[310]+w[311]+w[312]+w[313]+w[314]+w[315]+w[316]+w[317]+w[318]+w[319]+w[320]+w[321]+w[322]+w[323]+w[324]+w[325]+w[326]+w[327]+w[290]+w[291]+w[292]+w[293]+w[294]+w[295]+w[296]+w[297]+w[298]+w[299]+w[300]+w[301]+w[302]+w[303]+w[304]+w[305]+w[306]+w[307]+w[308]+w[271]+w[272]+w[273]+w[274]+w[275]+w[276]+w[277]+w[278]+w[279]+w[280]+w[281]+w[282]+w[283]+w[284]+w[285]+w[286]+w[287]+w[288]+w[289]+w[252]+w[253]+w[254]+w[255]+w[256]+w[257]+w[258]+w[259]+w[260]+w[261]+w[262]+w[263]+w[264]+w[265]+w[266]+w[267]+w[268]+w[269]+w[270]
EnergyIntHoles[1]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]+w[328]+w[329]+w[330]+w[331]+w[332]+w[333]+w[334]+w[335]+w[336]+w[337]+w[338]+w[339]+w[340]+w[341]+w[342]+w[343]+w[344]+w[345]+w[346]+w[309]+w[310]+w[311]+w[312]+w[313]+w[314]+w[315]+w[316]+w[317]+w[318]+w[319]+w[320]+w[321]+w[322]+w[323]+w[324]+w[325]+w[326]+w[327]+w[290]+w[291]+w[292]+w[293]+w[294]+w[295]+w[296]+w[297]+w[298]+w[299]+w[300]+w[301]+w[302]+w[303]+w[304]+w[305]+w[306]+w[307]+w[308]+w[271]+w[272]+w[273]+w[274]+w[275]+w[276]+w[277]+w[278]+w[279]+w[280]+w[281]+w[282]+w[283]+w[284]+w[285]+w[286]+w[287]+w[288]+w[289]
EnergyIntHoles[2]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]+w[328]+w[329]+w[330]+w[331]+w[332]+w[333]+w[334]+w[335]+w[336]+w[337]+w[338]+w[339]+w[340]+w[341]+w[342]+w[343]+w[344]+w[345]+w[346]+w[309]+w[310]+w[311]+w[312]+w[313]+w[314]+w[315]+w[316]+w[317]+w[318]+w[319]+w[320]+w[321]+w[322]+w[323]+w[324]+w[325]+w[326]+w[327]+w[290]+w[291]+w[292]+w[293]+w[294]+w[295]+w[296]+w[297]+w[298]+w[299]+w[300]+w[301]+w[302]+w[303]+w[304]+w[305]+w[306]+w[307]+w[308]
EnergyIntHoles[3]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]+w[328]+w[329]+w[330]+w[331]+w[332]+w[333]+w[334]+w[335]+w[336]+w[337]+w[338]+w[339]+w[340]+w[341]+w[342]+w[343]+w[344]+w[345]+w[346]+w[309]+w[310]+w[311]+w[312]+w[313]+w[314]+w[315]+w[316]+w[317]+w[318]+w[319]+w[320]+w[321]+w[322]+w[323]+w[324]+w[325]+w[326]+w[327]
EnergyIntHoles[4]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]+w[328]+w[329]+w[330]+w[331]+w[332]+w[333]+w[334]+w[335]+w[336]+w[337]+w[338]+w[339]+w[340]+w[341]+w[342]+w[343]+w[344]+w[345]+w[346]
EnergyIntHoles[5]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[347]+w[348]+w[349]+w[350]+w[351]+w[352]+w[353]+w[354]+w[355]+w[356]+w[357]+w[358]+w[359]+w[360]+w[361]+w[362]+w[363]+w[364]+w[365]
EnergyIntHoles[6]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]
EnergyIntHoles[7]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]
EnergyIntHoles[8]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]+w[404]+w[405]+w[406]+w[407]+w[408]+w[409]+w[410]+w[411]+w[412]+w[413]+w[414]+w[415]+w[416]+w[417]+w[418]+w[419]+w[420]+w[421]+w[422]
EnergyIntHoles[9]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]+w[404]+w[405]+w[406]+w[407]+w[408]+w[409]+w[410]+w[411]+w[412]+w[413]+w[414]+w[415]+w[416]+w[417]+w[418]+w[419]+w[420]+w[421]+w[422]+w[423]+w[424]+w[425]+w[426]+w[427]+w[428]+w[429]+w[430]+w[431]+w[432]+w[433]+w[434]+w[435]+w[436]+w[437]+w[438]+w[439]+w[440]+w[441]
EnergyIntHoles[10]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]+w[404]+w[405]+w[406]+w[407]+w[408]+w[409]+w[410]+w[411]+w[412]+w[413]+w[414]+w[415]+w[416]+w[417]+w[418]+w[419]+w[420]+w[421]+w[422]+w[423]+w[424]+w[425]+w[426]+w[427]+w[428]+w[429]+w[430]+w[431]+w[432]+w[433]+w[434]+w[435]+w[436]+w[437]+w[438]+w[439]+w[440]+w[441]+w[442]+w[443]+w[444]+w[445]+w[446]+w[447]+w[448]+w[449]+w[450]+w[451]+w[452]+w[453]+w[454]+w[455]+w[456]+w[457]+w[458]+w[459]+w[460]
EnergyIntHoles[11]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]+w[404]+w[405]+w[406]+w[407]+w[408]+w[409]+w[410]+w[411]+w[412]+w[413]+w[414]+w[415]+w[416]+w[417]+w[418]+w[419]+w[420]+w[421]+w[422]+w[423]+w[424]+w[425]+w[426]+w[427]+w[428]+w[429]+w[430]+w[431]+w[432]+w[433]+w[434]+w[435]+w[436]+w[437]+w[438]+w[439]+w[440]+w[441]+w[442]+w[443]+w[444]+w[445]+w[446]+w[447]+w[448]+w[449]+w[450]+w[451]+w[452]+w[453]+w[454]+w[455]+w[456]+w[457]+w[458]+w[459]+w[460]+w[461]+w[462]+w[463]+w[464]+w[465]+w[466]+w[467]+w[468]+w[469]+w[470]+w[471]+w[472]+w[473]+w[474]+w[475]+w[476]+w[477]+w[478]+w[479]
EnergyIntHoles[12]=w[366]+w[367]+w[368]+w[369]+w[370]+w[371]+w[372]+w[373]+w[374]+w[375]+w[376]+w[377]+w[378]+w[379]+w[380]+w[381]+w[382]+w[383]+w[384]+w[385]+w[386]+w[387]+w[388]+w[389]+w[390]+w[391]+w[392]+w[393]+w[394]+w[395]+w[396]+w[397]+w[398]+w[399]+w[400]+w[401]+w[402]+w[403]+w[404]+w[405]+w[406]+w[407]+w[408]+w[409]+w[410]+w[411]+w[412]+w[413]+w[414]+w[415]+w[416]+w[417]+w[418]+w[419]+w[420]+w[421]+w[422]+w[423]+w[424]+w[425]+w[426]+w[427]+w[428]+w[429]+w[430]+w[431]+w[432]+w[433]+w[434]+w[435]+w[436]+w[437]+w[438]+w[439]+w[440]+w[441]+w[442]+w[443]+w[444]+w[445]+w[446]+w[447]+w[448]+w[449]+w[450]+w[451]+w[452]+w[453]+w[454]+w[455]+w[456]+w[457]+w[458]+w[459]+w[460]+w[461]+w[462]+w[463]+w[464]+w[465]+w[466]+w[467]+w[468]+w[469]+w[470]+w[471]+w[472]+w[473]+w[474]+w[475]+w[476]+w[477]+w[478]+w[479]+w[480]+w[481]+w[482]+w[483]+w[484]+w[485]+w[486]+w[487]+w[488]+w[489]+w[490]+w[491]+w[492]+w[493]+w[494]+w[495]+w[496]+w[497]+w[498]
	 String baseNameAddData = "Holes_"
	    		for(i=0; i<(above0Holes+below0Holes); i+=1)
	    			String IntegrationszahlHolesAddData
				sprintf IntegrationszahlHolesAddData, "%s%d", baseNameAddData, i
				Make/O/N= (1) $IntegrationszahlHolesAddData
				Wave xWave = $IntegrationszahlHolesAddData
				xWave = EnergyIntHoles[i]
				endfor

// HIER FÄNGT DIE ELEKTRONEN RECHNUNG AN
below0Electrons=0
		make /N=(above0Electrons) /O EnergyIntElectrons
		make /N=(above0Electrons) /O EnergyIntElectronsx
	for(op=0;op<above0Electrons;op+=1)	
		EnergyIntElectrons[op] = Summe[op+22]
		EnergyIntElectronsx[op]= MedianEnergy[op+22]
	endfor
//op ist sonst =/ 0 und macht Probleme
op=0
//für die Integration, lässt ersten Punkt aus um Löcher zu vermeiden
firstpointElectrons = EnergyIntElectrons[op+below0Electrons]
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectrons[op+below0Electrons] = EnergyIntElectrons[op+below0Electrons]+EnergyIntElectrons[(op-1)+below0Electrons]
		EnergyIntElectrons[below0Electrons]= 0
	endfor
//Addiert ersten Punkt auf alle Werte
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectrons[op] = EnergyIntElectrons[op+below0Electrons]+firstpointElectrons
	endfor
//op ist sonst =/ 0 und macht Probleme
op=0
//jetzt kommt die Hole Integration
firstpointbelowElectrons = EnergyIntElectrons[op]
k=0
sort EnergyIntElectronsx EnergyIntElectronsx,EnergyIntElectrons
	 String baseNameElectronsAddData = "Electrons_"
	    		for(i=0; i<(above0Electrons+below0Electrons); i+=1)
	    			String IntegrationszahlElectronsAdd
				sprintf IntegrationszahlElectronsAdd, "%s%d", baseNameElectronsAddData, i
				Make/O/N= (1) $IntegrationszahlElectronsAdd
				Wave xWave = $IntegrationszahlElectronsAdd
				xWave = EnergyIntElectrons[i]
				endfor
// Make waves and put values in
//do the integration in 0.1 eV steps	ABOVE 0 eV


duplicate /O Summe SummeW
duplicate /O EnergyIntElectrons EnergyIntElectronsW
//print n
//fixing 0.0eV Electrons
SummeW [23]= Summe[23]
for(i=0;i<(n/20);i+=1)
SummeW [i]= Summe[i]*MedianEnergy[i]
endfor
	for(op=0;op<above0Electrons;op+=1)	
		EnergyIntElectronsW[op+below0Electrons] = SummeW[op+22]
		EnergyIntElectronsx[op+below0Electrons]= MedianEnergy[op+22]
	endfor
	
op=0
firstpointElectronsW = EnergyIntElectronsW[op+below0Electrons]

	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectronsW[op+below0Electrons] = EnergyIntElectronsW[op+below0Electrons]+EnergyIntElectronsW[(op-1)+below0Electrons]
		EnergyIntElectronsW[below0Electrons]= 0
	endfor
	for(op=0;op<above0Electrons;op+=1)
		EnergyIntElectronsW[op+below0Electrons] = EnergyIntElectronsW[op+below0Electrons]+firstpointElectronsW
	endfor	
op=0
firstpointbelowElectronsW = EnergyIntElectrons[op]	
sort EnergyIntElectronsx EnergyIntElectronsx,EnergyIntElectronsW
//HIER
String baseNameWAddData ="Electrons_"
	for(i=0; i<(above0Electrons); i+=1)
	    		String xNameWAddData
			sprintf xNameWAddData, "%s%d", baseNameWAddData, i
			Make/O/N= (1) $xNameWAddData
			Wave xWaveW = $xNameWAddData
			xWaveW = EnergyIntElectronsW[i]
			endfor
// Make waves and put values in
SetDatafolder UsedData
	string yName1Add
	string baseName1Add = "fs_reduced_w"
				sprintf yName1Add, "%d%s", timedelay[numpnts(timedelay)], baseName1Add
						duplicate /O ::reduced_w $yName1Add
	string yName2Add
	String baseName2Add = "fs_Summe"
				sprintf yName2Add, "%d%s", timedelay[numpnts(timedelay)], baseName2Add
						duplicate /O ::Summe $yName2Add
   	string yName3Add
	String baseName3Add = "fs_MedianEnergy"
				sprintf yName3Add, "%d%s", timedelay[numpnts(timedelay)], baseName3Add
						duplicate /O ::MedianEnergy $yName3Add
	string yName4Add
	String baseName4Add = "fs_EnergyIntHoles"
				sprintf yName4Add, "%d%s", timedelay[numpnts(timedelay)], baseName4Add
						duplicate /O ::EnergyIntHoles $yName4Add
   	string yName5Add
	String baseName5Add = "fs_EnergyIntHolesx"
				sprintf yName5Add, "%d%s", timedelay[numpnts(timedelay)], baseName5Add
				duplicate /O ::EnergyIntHolesx $yName5Add
	string yName12Add
	String baseName12Add = "fs_SummeW"
				sprintf yName12Add, "%d%s", timedelay[numpnts(timedelay)], baseName12Add
						duplicate /O ::SummeW $yName12Add
	string yName13Add
	String baseName13Add = "fs_EnergyIntElectronsW"
				sprintf yName13Add, "%d%s", timedelay[numpnts(timedelay)], baseName13Add
						duplicate /O ::EnergyIntElectronsW $yName13Add
	string yName29Add
	String baseName29Add = "fs_EnergyIntElectrons"
				sprintf yName29Add, "%d%s", timedelay[numpnts(timedelay)], baseName29Add
						duplicate /O ::EnergyIntElectrons $yName29Add
	string yName30Add
	String baseName30Add = "fs_EnergyIntElectronsx"
				sprintf yName30Add, "%d%s", timedelay[numpnts(timedelay)], baseName30Add
						duplicate /O ::EnergyIntElectronsx $yName30Add
	
	Redimension/D /N=(numpnts('Holes_-0.3eV')+1) 'Holes_-0.3eV'
	Redimension/D /N=(numpnts('Holes_-0.2eV')+1) 'Holes_-0.2eV'
	Redimension/D /N=(numpnts('Holes_-0.1eV')+1) 'Holes_-0.1eV'
	Redimension/D /N=(numpnts('Holes_0.0eV')+1) 'Holes_0.0eV'
	Redimension/D /N=(numpnts('Holes_0.1eV')+1) 'Holes_0.1eV'
	Redimension/D /N=(numpnts('Holes_0.2eV')+1) 'Holes_0.2eV'
	Redimension/D /N=(numpnts('Holes_0.3eV')+1) 'Holes_0.3eV'
	Redimension/D /N=(numpnts('Holes_-0.4eV')+1) 'Holes_-0.4eV'
	Redimension/D /N=(numpnts('Holes_-0.5eV')+1) 'Holes_-0.5eV'
	Redimension/D /N=(numpnts('Holes_-0.6eV')+1) 'Holes_-0.6eV'
	Redimension/D /N=(numpnts('Holes_0.4eV')+1) 'Holes_0.4eV'
	Redimension/D /N=(numpnts('Holes_0.5eV')+1) 'Holes_0.5eV'
	Redimension/D /N=(numpnts('Holes_0.6eV')+1) 'Holes_0.6eV'
	
	Redimension/D /N=(numpnts('Electrons_0.0eV')+1) 'Electrons_0.0eV'
	Redimension/D /N=(numpnts('Electrons_0.1eV')+1) 'Electrons_0.1eV'
	Redimension/D /N=(numpnts('Electrons_0.2eV')+1) 'Electrons_0.2eV'
	Redimension/D /N=(numpnts('Electrons_0.3eV')+1) 'Electrons_0.3eV'
	Redimension/D /N=(numpnts('Electrons_0.4eV')+1) 'Electrons_0.4eV'
	Redimension/D /N=(numpnts('Electrons_0.5eV')+1) 'Electrons_0.5eV'
	Redimension/D /N=(numpnts('Electrons_0.6eV')+1) 'Electrons_0.6eV'
	Redimension/D /N=(numpnts('Electrons_0.7eV')+1) 'Electrons_0.7eV'
	Redimension/D /N=(numpnts('Electrons_0.8eV')+1) 'Electrons_0.8eV'
	Redimension/D /N=(numpnts('Electrons_0.9eV')+1) 'Electrons_0.9eV'
	Redimension/D /N=(numpnts('Electrons_0.10eV')+1) 'Electrons_0.10eV'
	Redimension/D /N=(numpnts('Electrons_0.11eV')+1) 'Electrons_0.11eV'
	Redimension/D /N=(numpnts('Electrons_0.12eV')+1) 'Electrons_0.12eV'
	Redimension/D /N=(numpnts('Electrons_0.13eV')+1) 'Electrons_0.13eV'
	Redimension/D /N=(numpnts('Electrons_0.14eV')+1) 'Electrons_0.14eV'
	Redimension/D /N=(numpnts('Electrons_0.15eV')+1) 'Electrons_0.15eV'
	Redimension/D /N=(numpnts('Electrons_0.16eV')+1) 'Electrons_0.16eV'
	Redimension/D /N=(numpnts('Electrons_0.17eV')+1) 'Electrons_0.17eV'
	
    	MoveWave :'Electrons_0.0eV', ::
    	MoveWave :'Electrons_0.1eV', ::
    	MoveWave :'Electrons_0.2eV', ::
    	MoveWave :'Electrons_0.3eV', ::
    	MoveWave :'Electrons_0.4eV', ::
    	MoveWave :'Electrons_0.5eV', ::
    	MoveWave :'Electrons_0.6eV', ::
    	MoveWave :'Electrons_0.7eV', ::
    	MoveWave :'Electrons_0.8eV', ::
    	MoveWave :'Electrons_0.9eV', ::
    	MoveWave :'Electrons_0.10eV', ::
    	MoveWave :'Electrons_0.11eV', ::
    	MoveWave :'Electrons_0.12eV', ::
    	MoveWave :'Electrons_0.13eV', ::
    	MoveWave :'Electrons_0.14eV', ::
    	MoveWave :'Electrons_0.15eV', ::
    	MoveWave :'Electrons_0.16eV', ::
    	MoveWave :'Electrons_0.17eV', ::
    	
    	MoveWave :'Holes_-0.3eV', ::
    	MoveWave :'Holes_-0.2eV', ::
    	MoveWave :'Holes_-0.1eV', ::
    	MoveWave :'Holes_0.0eV', ::
    	MoveWave :'Holes_0.1eV', ::
    	MoveWave :'Holes_0.2eV', ::
    	MoveWave :'Holes_0.3eV', ::
    	MoveWave :'Holes_-0.4eV', ::
    	MoveWave :'Holes_-0.5eV', ::
    	MoveWave :'Holes_-0.6eV', ::
    	MoveWave :'Holes_0.4eV', ::
    	MoveWave :'Holes_0.5eV', ::
    	MoveWave :'Holes_0.6eV', ::

SetDatafolder ::
	rename 'Electrons_0.0eV', SE0
    	rename 'Electrons_0.1eV', SE1
    	rename 'Electrons_0.2eV', SE2
    	rename 'Electrons_0.3eV', SE3
    	rename 'Electrons_0.4eV', SE4
    	rename 'Electrons_0.5eV', SE5
    	rename 'Electrons_0.6eV', SE6
    	rename 'Electrons_0.7eV', SE7
 	rename 'Electrons_0.8eV', SE8
 	rename 'Electrons_0.9eV', SE9
 	rename 'Electrons_0.10eV', SE10
 	rename 'Electrons_0.11eV', SE11
 	rename 'Electrons_0.12eV', SE12
 	rename 'Electrons_0.13eV', SE13
    	rename 'Electrons_0.14eV', SE14
    	rename 'Electrons_0.15eV', SE15
    	rename 'Electrons_0.16eV', SE16
    	rename 'Electrons_0.17eV', SE17
    	
    	rename 'Holes_-0.6eV', SH0
    	rename 'Holes_-0.5eV', SH1
    	rename 'Holes_-0.4eV', SH2
    	rename 'Holes_-0.3eV', SH3
    	rename 'Holes_-0.2eV', SH4
    	rename 'Holes_-0.1eV', SH5
    	rename 'Holes_0.0eV', SH6
    	rename 'Holes_0.1eV', SH7
    	rename 'Holes_0.2eV', SH8
    	rename 'Holes_0.3eV', SH9
    	rename 'Holes_0.4eV', SH10
    	rename 'Holes_0.5eV', SH11
    	rename 'Holes_0.6eV', SH12
    	
    	rename 'Electrons_0', E0
    	rename 'Electrons_1', E1
    	rename 'Electrons_2', E2
    	rename 'Electrons_3', E3
    	rename 'Electrons_4', E4
    	rename 'Electrons_5', E5
    	rename 'Electrons_6', E6
    	rename 'Electrons_7', E7
    	rename 'Electrons_8', E8
    	rename 'Electrons_9', E9
    	rename 'Electrons_10', E10
    	rename 'Electrons_11', E11
    	rename 'Electrons_12', E12
    	rename 'Electrons_13', E13
    	rename 'Electrons_14', E14
    	rename 'Electrons_15', E15
    	rename 'Electrons_16', E16
    	rename 'Electrons_17', E17
    	
    	rename 'Holes_0', H0
    	rename 'Holes_1', H1
    	rename 'Holes_2', H2
    	rename 'Holes_3', H3
    	rename 'Holes_4', H4
    	rename 'Holes_5', H5
    	rename 'Holes_6', H6
    	rename 'Holes_7', H7
    	rename 'Holes_8', H8
    	rename 'Holes_9', H9
    	rename 'Holes_10', H10
    	rename 'Holes_11', H11
    	rename 'Holes_12', H12
  		wave E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17
		wave H0,H1,H2,H3,H4,H5,H6,H7,H8,H9,H10,H11,H12
		wave SE0,SE1,SE2,SE3,SE4,SE5,SE6,SE7,SE8,SE9,SE10,SE11,SE12,SE13,SE14,SE15,SE16,SE17
		wave SH0,SH1,SH2,SH3,SH4,SH5,SH6,SH7,SH8,SH9,SH10,SH11,SH12

SE0[numpnts(SE0)] = E0[1]
SE1[numpnts(SE1)] = E1[1]
SE2[numpnts(SE2)] = E2[1]
SE3[numpnts(SE3)] = E3[1]
SE4[numpnts(SE4)] = E4[1]
SE5[numpnts(SE5)] = E5[1]
SE6[numpnts(SE6)] = E6[1]
SE7[numpnts(SE7)] = E7[1]
SE8[numpnts(SE8)] = E8[1]
SE9[numpnts(SE9)] = E9[1]
SE10[numpnts(SE10)] = E10[1]
SE11[numpnts(SE11)] = E11[1]
SE12[numpnts(SE12)] = E12[1]
SE13[numpnts(SE13)] = E13[1]
SE14[numpnts(SE14)] = E14[1]
SE15[numpnts(SE15)] = E15[1]
SE16[numpnts(SE16)] = E16[1]
SE17[numpnts(SE17)] = E17[1]

SH0[numpnts(SE0)] = H0[1]
SH1[numpnts(SE1)] = H1[1]
SH2[numpnts(SE2)] = H2[1]
SH3[numpnts(SE3)] = H3[1]
SH4[numpnts(SE4)] = H4[1]
SH5[numpnts(SE5)] = H5[1]
SH6[numpnts(SE6)] = H6[1]
SH7[numpnts(SE7)] = H7[1]
SH8[numpnts(SE8)] = H8[1]
SH9[numpnts(SE9)] = H9[1]
SH10[numpnts(SE10)] = H10[1]
SH11[numpnts(SE11)] = H11[1]
SH12[numpnts(SE12)] = H12[1]

	rename SE0,'Electrons_0.0eV'
    	rename SE1,'Electrons_0.1eV'
    	rename SE2,'Electrons_0.2eV'
    	rename SE3,'Electrons_0.3eV'
    	rename SE4'Electrons_0.4eV'
    	rename SE5'Electrons_0.5eV'
    	rename SE6'Electrons_0.6eV'
    	rename SE7,'Electrons_0.7eV'
    	rename SE8,'Electrons_0.8eV'
    	rename SE9,'Electrons_0.9eV'
    	rename SE10,'Electrons_0.10eV'
    	rename SE11,'Electrons_0.11eV'
    	rename SE12,'Electrons_0.12eV'
    	rename SE13,'Electrons_0.13eV'
    	rename SE14,'Electrons_0.14eV'
    	rename SE15,'Electrons_0.15eV'
    	rename SE16,'Electrons_0.16eV'
    	rename SE17,'Electrons_0.17eV'
    	
    	rename SH0,'Holes_-0.6eV'
    	rename SH1,'Holes_-0.5eV'
    	rename SH2,'Holes_-0.4eV'
    	rename SH3,'Holes_-0.3eV'
    	rename SH4,'Holes_-0.2eV'
    	rename SH5,'Holes_-0.1eV'
    	rename SH6,'Holes_0.0eV'
    	rename SH7,'Holes_0.1eV'
    	rename SH8,'Holes_0.2eV'
    	rename SH9,'Holes_0.3eV'
    	rename SH10,'Holes_0.4eV'
    	rename SH11,'Holes_0.5eV'
    	rename SH12,'Holes_0.6eV'

				
    	MoveWave :'Electrons_0.0eV', :UsedData:
    	MoveWave :'Electrons_0.1eV', :UsedData:
    	MoveWave :'Electrons_0.2eV', :UsedData:
    	MoveWave :'Electrons_0.3eV', :UsedData:
    	MoveWave :'Electrons_0.4eV', :UsedData:
    	MoveWave :'Electrons_0.5eV', :UsedData:
    	MoveWave :'Electrons_0.6eV', :UsedData:
    	MoveWave :'Electrons_0.7eV', :UsedData:
    	MoveWave :'Electrons_0.8eV', :UsedData:
    	MoveWave :'Electrons_0.9eV', :UsedData:
    	MoveWave :'Electrons_0.10eV', :UsedData:
    	MoveWave :'Electrons_0.11eV', :UsedData:
    	MoveWave :'Electrons_0.12eV', :UsedData:
    	MoveWave :'Electrons_0.13eV', :UsedData:
    	MoveWave :'Electrons_0.14eV', :UsedData:
    	MoveWave :'Electrons_0.15eV', :UsedData:
    	MoveWave :'Electrons_0.16eV', :UsedData:
    	MoveWave :'Electrons_0.17eV', :UsedData:
    	
    	MoveWave :'Holes_-0.3eV', :UsedData:
    	MoveWave :'Holes_-0.2eV', :UsedData:
    	MoveWave :'Holes_-0.1eV', :UsedData:
    	MoveWave :'Holes_0.0eV', :UsedData:
    	MoveWave :'Holes_0.1eV', :UsedData:
    	MoveWave :'Holes_0.2eV', :UsedData:	
    	MoveWave :'Holes_0.3eV', :UsedData:	
    	MoveWave :'Holes_0.4eV', :UsedData:	
    	MoveWave :'Holes_0.5eV', :UsedData:	
    	MoveWave :'Holes_0.6eV', :UsedData:	
    	MoveWave :'Holes_-0.4eV', :UsedData:	
    	MoveWave :'Holes_-0.5eV', :UsedData:		
    	MoveWave :'Holes_-0.6eV', :UsedData:		
 Killwaves EnergyIntHoles EnergyIntHolesx
Killwaves reduced_w Summe MedianEnergy H0 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 EnergyIntElectrons EnergyIntElectronsx E0 E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12 E13 E14 E15 E16 E17 SummeW EnergyIntElectronsW
//Print "FinishNo"
SetDatafolder ::
endif
End

Function StoreData(w,v)
Wave w
Wave v
redimension /N=(numpnts(v)+1) v
v[numpnts(v)]=w[1]
End