#pragma rtGlobals=3		// Use modern global access method and strict wave access.

Function FindPeaks2D(wave2D, [minamp, box])
	Wave wave2D
	Variable minamp, box
	Variable i,p0,threshold
	Variable rows=DimSize(wave2D,0)
	Variable x0=DimOffset(wave2D,0)
	Variable dx=DimDelta(wave2D,0)
	Variable columns=DimSize(wave2D,1)
	Variable y0=DimOffset(wave2D,1)
	Variable dy=DimDelta(wave2D,1)
	minamp=ParamIsDefault(minamp) ? 0.8 : minamp
	box=ParamIsDefault(box) ? 5 : box
	
	String outputName = "peaks_" + NameOfWave(wave2D)
	Make/O/N=(columns) $outputName
	Wave wOut = $outputName
	SetScale/P x, y0, dy, wOut
	
	for(i=0;i<columns;i+=1)
		p0=i*rows
		threshold=WaveMax(wave2D,pnt2x(wave2D,p0),pnt2x(wave2D,p0+rows-1))*minamp
		//FindPeak /B=(box) /M=(threshold) /Q /R=[p0,p0+rows-1] wave2D
		FindAPeak threshold, 1, box, wave2D[p0,p0+rows-1]
		wOut[i]=V_flag ? NaN : V_peakX-p0*dx
	endfor
	wout[0,x2pnt(wout,0.2)-1]=NaN
	wout[x2pnt(wout,2.1),columns-1]=NaN
	Smooth /B=2 /E=3 10, wout
	wout[0,x2pnt(wout,0.2)-1]=NaN
	wout[x2pnt(wout,2.1),columns-1]=NaN
	//Display/VERT wOut
	//SetAxis bottom x0, x0+rows*dx-dx
End

Function zeroOffset(wpeaks, minE, maxE)
	Wave wpeaks
	Variable minE, maxE
	Variable offset = mean(wpeaks, minE, maxE)
	wpeaks -= offset
	printf "offset = %.2f fs\r", offset
End

Function normmax2D(wave2D)
	Wave wave2D
	String outputName = "norm" + NameOfWave(wave2D)
	Duplicate/O wave2D $outputName
	Wave wnorm = $outputName
	wnorm/=1.0641
	Display;AppendImage wnorm
	Execute "sh2D()"
	ModifyImage '' ctab= {0,1,Terrain256,0}
	SetAxis left 0.1, 2.2
	Label left "Intermediate State Energy E-E\\BF\\M (eV)"
End