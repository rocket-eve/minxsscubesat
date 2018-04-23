;+
; NAME:
;   minxss_plot_adcs_jitter
;
; PURPOSE:
;   Plot the pointing jitter as a function of time
;
; INPUTS:
;   None
;
; OPTIONAL INPUTS:
;   saveloc [string]: The path to save the plot. Default is current directory.
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   Plot of pointing jitter vs time and optionally altitude
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   Requires MinXSS level 0c data
;
; EXAMPLE:
;   Just run it!
;
; MODIFICATION HISTORY:
;   2017-05-19: James Paul Mason: Wrote script.
;   2017-05-26: James Paul Mason: Updated to generate a histogram rather than a time series.
;-
PRO minxss_plot_adcs_jitter, saveloc = saveloc

; Defaults
IF saveloc EQ !NULL THEN BEGIN
  saveloc = './'
ENDIF

; Setup
smoothNumberOfPoints = 500
rad2rpm = 9.54929659643
fwhm2sigma = 2.355
fontSize = 16

; Restore the level 0c data
restore, getenv('minxss_data') + '/fm1/level0c/minxss1_l0c_all_mission_length.sav'

; Extract ADCS flags from adcs info
adcs_mode = ISHFT(adcs3.adcs_info AND '01'X, 0) ; extract 1-bit flag

; Filter for only data in fine reference mode
fineRefIndices = where(adcs_mode EQ 1)
adcs3 = adcs3[fineRefIndices]

;; Filter out eclipse data
;insolatedIndices = where(adcs3.SUN_POINT_ANGLE_ERROR LT 180)
;adcs3 = adcs3[insolatedIndices]
;
;; Filter out bad tracker data
;goodTrackerIndices = where(adcs3.TRACKER_ATTITUDE_STATUS EQ 0)
;adcs3 = adcs3[goodTrackerIndices]

; Determine jitter over 10-second period (MinXSS requirement)
timeJd = !NULL
FOR i = 0, n_elements(adcs3) - 1 DO BEGIN
  currentTime = adcs3[i].time
  within10SecondsIndices = where(adcs3.time GE currentTime AND adcs3.time LT currentTime + 10, numInBin)
  
  IF numInBin EQ 1 THEN CONTINUE
  
  minmax1 = minmax(-adcs3[within10SecondsIndices].attitude_error2 * !RADEG) ; MinXSS +X = XACT -Y
  minmax2 = minmax(adcs3[within10SecondsIndices].attitude_error1 * !RADEG) ; MinXSS +Y = XACT +X
  minmax3 = minmax(adcs3[within10SecondsIndices].attitude_error3 * !RADEG) ; MinXSS +Z = XACT +Z
  
  jitter1 = (jitter1 EQ !NULL) ? minmax1[1] - minmax1[0] : [jitter1, minmax1[1] - minmax1[0]]
  jitter2 = (jitter2 EQ !NULL) ? minmax2[1] - minmax2[0] : [jitter2, minmax2[1] - minmax2[0]]
  jitter3 = (jitter3 EQ !NULL) ? minmax3[1] - minmax3[0] : [jitter3, minmax3[1] - minmax3[0]]
  
  numPointsInBin = (numPointsINBin EQ !NULL) ? numInBin : [numPointsInBin, numInBin]
  
  timeJd = (timeJd EQ !NULL) ? adcs3[i].time_jd : [timeJd, adcs3[i].time_jd]
  
  i += numInBin
ENDFOR

; Create histogram data
xHistogram = histogram(jitter1, NBINS = 1000000, LOCATIONS = xBins)
yHistogram = histogram(jitter2, NBINS = 1000000, LOCATIONS = yBins)
zHistogram = histogram(jitter3, NBINS = 1000000, LOCATIONS = zBins)

; Determine the sigma value
; At what jitter value are 66% of the points captured
binIndex = 0
foundXSigma = 0
foundYSigma = 0
foundZSigma = 0
WHILE foundXSigma EQ 0 OR foundYSigma EQ 0 OR foundZSigma EQ 0 DO BEGIN
  IF foundXSigma EQ 0 AND total(xHistogram[0:binIndex]) / total(xHistogram) GE 0.66 THEN BEGIN
    foundXSigma = 1
    xSigma = xBins[binIndex]
  ENDIF
  IF foundYSigma EQ 0 AND total(yHistogram[0:binIndex]) / total(yHistogram) GE 0.66 THEN BEGIN
    foundYSigma = 1
    ySigma = yBins[binIndex]
  ENDIF
  IF foundZSigma EQ 0 AND total(zHistogram[0:binIndex]) / total(zHistogram) GE 0.66 THEN BEGIN
    foundZSigma = 1
    zSigma = zBins[binIndex]
  ENDIF
  
  binIndex++
ENDWHILE

; Plot histograms
p1 = plot(xBins, xHistogram, COLOR = 'tomato', /HISTOGRAM, THICK = 2, LAYOUT = [1, 3, 1], FONT_SIZE = fontSize, $
          XTITLE = 'Jitter [º (10 s$^{-1}$)]', XRANGE = [0, 0.05], $
          YTITLE = '#', $
          NAME = 'X')
p2 = plot(yBins, yHistogram, COLOR = 'lime green', /HISTOGRAM, THICK = 2, LAYOUT = [1, 3, 2], /CURRENT, FONT_SIZE = fontSize, $
          XTITLE = 'Jitter [º (10 s$^{-1}$)]', XRANGE = [0, 0.05], $
          YTITLE = '#', $
          NAME = 'Y')
p3 = plot(zBins, zHistogram, COLOR = 'dodger blue', /HISTOGRAM, THICK = 2, LAYOUT = [1, 3, 3], /CURRENT, FONT_SIZE = fontSize, $
          XTITLE = 'Jitter [º (10 s$^{-1}$)]', XRANGE = [0, 0.05], $
          YTITLE = '#', $
          NAME = 'Z')
l1 = legend(POSITION = [0.26, 0.41], TARGET = [p1, p2, p3], FONT_SIZE = fontSize - 2)
t1 = text(0.25, 0.87, '3$\sigma$ = ' + JPMPrintNumber(3 * xSigma, NUMBER_OF_DECIMALS = 4) + '$\deg$ (10 s$^{-1}$)', COLOR = 'tomato', FONT_SIZE = fontSize - 2)
t2 = text(0.25, 0.55, '3$\sigma$ = ' + JPMPrintNumber(3 * ySigma, NUMBER_OF_DECIMALS = 4) + '$\deg$ (10 s$^{-1}$)', COLOR = 'lime green', FONT_SIZE = fontSize - 2)
t3 = text(0.25, 0.21, '3$\sigma$ = ' + JPMPrintNumber(3 * zSigma, NUMBER_OF_DECIMALS = 4) + '$\deg$ (10 s$^{-1}$)', COLOR = 'dodger blue', FONT_SIZE = fontSize - 2)

; Save plot to disk
p1.save, saveloc + 'Jitter Histogram.png'

END