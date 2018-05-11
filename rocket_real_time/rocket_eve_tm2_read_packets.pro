;+
; NAME:
;   rocket_eve_tm2_read_packets
;
; PURPOSE:
;   Stripped down code with similar purpose as read_tm2_all_cd.pro, designed to return the data via a common buffer rather than save to disk as a .dat.
;   Designed to work in conjunction with eve_csol_real_time_socket_read_wrapper.pro, which shares the COMMON blocks. That code is responsible for initializing
;   many of the variables in the common blocks.
;
; INPUTS:
;   socketData [bytarr]: Data retrieved from an IP socket. 
;
; OPTIONAL INPUTS:
;   None
;   
; KEYWORD PARAMETERS:
;   VERBOSE: Set to print out additional information about how the processing is proceeding. 
;   DEBUG: Set to print out additional information useful for debugging. 
;
; COMMON BUFFER VARIABLES: 
;   megsCcdLookupTable [fltarr] [input]:          A 3 x 2 million array containing pixel indices 0-2,097,151 and their corresponding column and row in the MEGS CCD.
;                                                 Passed via common buffer so that it uses a pointer rather than copying the whole array as it would with an optional input. 
;   megsAImageBuffer [uintarr] [input/output]:    A 2048 * 1024 image to be filled in. This program updates the buffer with the current socketData. 
;                                                 Ditto for megsBImageBuffer. Ditto for csolImageBuffer, except its a 1024 * 1024 image. 
;   megsAImageIndex [long] [input/output]:        The number of images received so far. This program updates the value if a fiducial for MEGS is found. 
;                                                 Ditto for megsBImageIndex and csolImageIndex.
;   megsAPixelIndex [long] [input/output]:        A single number indicating the pixel index in the CCD. This program updates it with the number of pixels read in socketData. 
;                                                 Ditto for megsBPixelIndex.
;   megsATotalPixelsFound [long] [input/output]:  Incremements by the number of pixels found in socketData. Used for checking whether too much or too little data were
;                                                 collected for an image, which should be 2048 * 1024 pixels. Ditto for megsBTotalPixelsFound and csolTotalPixelsFound.
;   csolRowBuffer [bytarr] [input/output]:        Same idea as the image buffers but just for CSOL rows. CSOL packet metadata includes a row number and frame (image) number. 
;                                                 Once a full row is buffered, can store it in the correct row of the csolImageBuffer using that metadata. 
;   csolFrameNumberInStart [long] [input/output]: If the frame (image) number is found at the start of a new image, this program updates it. It's used for checking 
;                                                 image validity by comparing its value to csolFrameNumberInEnd. 
;   csolRowNumberInStart [long] [input/output]:   Same idea as csolFrameNumberInStart, but for the row number. 
;   csolRowNumberInEnd [long] [input/output]:     The complement to csolRowNumberInStart, but found at the end of an image row. 
;   csolFrameNumberInEnd [long] [input/output]:   The complement to csolFrameNumberInStart, but found at the end of an image.
;   sampleSizeDeweSoft [integer] [input]:         This is =2 if using synchronous data in DeweSoft for instrument channels, or =10 if using asynchronous. The additional bytes
;                                                 are from timestamps on every sample. 
;   offsetP1 [long] [input]:                      How far into the DEWESoftPacket to get to the "Data Samples" bytes of the DEWESoft channel definitions according to the binary
;                                                 data format documentation. P1 corresponds to MEGS-A. Note that another 4 bytes need to be skipped to get to the actual data. 
;                                                 The bytes of instrument samples range from [offsetP1 + 4, (offsetP1 + 4) + (numberOfDataSamplesP1 * sampleSizeDeweSoft)]                                         
;   numberOfDataSamplesP1 [ulong] [input]:        The number of instrument samples contained in the complete DEWESoft packet for the P1 (MEGS-A for EVE) defined stream. 
;   offsetP2 [long] [input]:                      Same idea as offsetP1, but for MEGS-B. 
;   numberOfDataSamplesP2 [ulong] [input]:        Same idea as numberOfDataSamplesP1, but for MEGS-B. 
;   offsetP3 [long] [input]:                      Same idea as offsetP1, but for CSOL. 
;   numberOfDataSamplesP3 [ulong] [input]:        Same idea as numberOfDataSamplesP1, but for CSOL. 
; 
; OUTPUTS:
;   No direct outputs. See common buffer variables above. 
;   
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   Requires JPMPrintNumber, JPMsystime
;   Requires StripDeweSoftHeaderAndTrailer. 
;
; PROCEDURE: 
;   TASK 1: Strip DEWESoft headers and trailers to get raw instrument data. Should end up with megsAPacketDataWithFiller, megsBPacketDataWithFiller, csolPacketDataWithFiller. 
;           The rest of the code should be repeated for each instrument separately. “instrument” variable names below would be replaced with the relevant instrument int the code. 
;   TASK 2: Remove filler. WSMR stuffs in 0x7E7E. End up with new variable, instrumentPacketData. 
;   TASK 3: Store pixels in common buffer. (Note: MEGS needs to be “unzipped”). 
;   TASK 4: Check limits:
;      4.1: If totalPixels GT imageSize, issue warning.
;      4.2: If totalPixels LE imageSize, issue warning. 
; 
; EXAMPLE:
;   rocket_eve_tm2_read_packets, socketData
;
; MODIFICATION HISTORY:
;   2015-04-13: James Paul Mason: Wrote script.
;   2015-04-25: James Paul Mason: The last few days have seen extensive edits to this code to get it work in the field where real debugging could be done. 
;   2018-05-10: James Paul Mason: Support for Compact SOLSTICE (CSOL), which replaces XRI everywhere in the code. 
;-
PRO rocket_eve_tm2_read_packets, socketData, VERBOSE = VERBOSE, DEBUG = DEBUG

; COMMON blocks for use with eve_real_time_socket_read_wrapper. The blocks are defined here and there to allow them to be called independently.
COMMON MEGS_PERSISTENT_DATA, megsCcdLookupTable
COMMON MEGS_A_PERSISTENT_DATA, megsAImageBuffer, megsAImageIndex, megsAPixelIndex, megsATotalPixelsFound
COMMON MEGS_B_PERSISTENT_DATA, megsBImageBuffer, megsBImageIndex, megsBPixelIndex, megsBTotalPixelsFound
COMMON CSOL_PERSISTENT_DATA, csolImageBuffer, csolImageIndex, csolRowBuffer, csolFrameNumberInStart, csolRowNumberInStart, csolTotalPixelsFound, csolNumberGapPixels
COMMON DEWESOFT_PERSISTENT_DATA, sampleSizeDeweSoft, offsetP1, numberOfDataSamplesP1, offsetP2, numberOfDataSamplesP2, offsetP3, numberOfDataSamplesP3 ; Note P1 = MEGS-A, P2 = MEGS-B, P3 = CSOL

; Telemetry stream packet structure
telemetryStreamPacketNumberOfWords = 82L ; 85L if reading a binary file, because WSMR includes 3 words of time information
telemetryStreamPacketNumberOfRows = 3L
nbytes = telemetryStreamPacketNumberOfWords * 2L * telemetryStreamPacketNumberOfRows   ; sync_1 + 3 words of time + sfid + mid + 78 words of data + sync_2
nint = nbytes / 2L

; WSMR telemetry packet sync words
; TODO: Remove this? This actually isn't used anywhere in the code
sync1Value = '2840'X
sync1Offset = nint - 1L ; 0L if reading binary file, because WSMR moves this syncbyte to the beginning of the packet
sync2Value = 'FE6B'X
sync2Offset = nint - 2L ; 1L if reading binary file, because WSMR moves sync1 to beginning of packet, making sync2 the end of the packet

; Instrument packet fiducial values (sync words)
csolFrameStartFiducialValue1 = '5555'X
csolFrameStartFiducialValue2 = '5A5'X
csolFrameEndFiducialValue1   = '5A5A'X
megsFiducialValue1           = 'FFFF'X
megsFiducialValue2           = 'AAAA'X

;
; TASK 1: Strip DEWESoft headers and trailers to get raw instrument data.
;
megsAPacketDataWithFiller = strip_dewesoft_header_and_trailer(socketData, offsetP1, numberOfDataSamplesP1, sampleSizeDeweSoft) ; [uintarr]
megsBPacketDataWithFiller = strip_dewesoft_header_and_trailer(socketData, offsetP2, numberOfDataSamplesP2, sampleSizeDeweSoft) ; [uintarr]
csolPacketDataWithFiller  = strip_dewesoft_header_and_trailer(socketData, offsetP3, numberOfDataSamplesP3, sampleSizeDeweSoft) ; [uintarr]

;
;
; -= INSTRUMENT: MEGS-A =- ;
;
;

;
; TASK 2: Remove filler. WSMR stuffs in 0x7E7E. End up with new variable, instrumentPacketData.
;
megsAPacketDataGoodIndices = where(megsAPacketDataWithFiller NE 0 AND megsAPacketDataWithFiller NE '7E7E'X, numberOfFoundMegsAPixels)
IF numberOfFoundMegsAPixels NE 0 THEN BEGIN 

  megsAPacketData = megsAPacketDataWithFiller[megsAPacketDataGoodIndices]
  
  ;
  ; TASK 3: Store pixels in common buffer. (Note: MEGS needs to be “unzipped”). 
  ;
  FOR packetIndex = 0, n_elements(megsAPacketData) - 1 DO BEGIN
    IF megsAPixelIndex LT 2048LL * 1024LL THEN BEGIN
      megsACcdColumnRow = megsCcdLookupTable[1:2, megsAPixelIndex]
      megsAImageBuffer[megsACcdColumnRow[0], megsACcdColumnRow[1]] = ((megsAPacketData[packetIndex] + '2000'X) AND '3FFF'X) ; The 0x2000 and 0x3FFF mask out the extra 2 bits (14 bits instead of 16)
      megsAPixelIndex++
    ENDIF
  ENDFOR
  megsATotalPixelsFound += n_elements(megsAPacketData)
  IF keyword_set(DEBUG) THEN message, /INFO, JPMsystime() + ' MEGS-A total pixels found in this image so far: ' + JPMPrintNumber(megsATotalPixelsFound, /NO_DECIMALS)
  
  ;
  ;   TASK 4: Check limits:
  ;      4.1: If totalPixels GT imageSize, issue warning.
  ;
  IF megsATotalPixelsFound GT 2048LL * 1024LL THEN BEGIN
    message, /INFO, JPMsystime() + ' MEGS A image has accumulated too many pixels. Expected 2048x1024 = 2,097,152 pixels but received ' + JPMPrintNumber(megsATotalPixelsFound, /NO_DECIMALS)
    megsAPixelIndex = 0LL
    megsATotalPixelsFound = 0L
    megsAImageIndex++
  ENDIF
ENDIF ELSE BEGIN ; End of numberOfFoundMegsAPixels NE 0
  
  ; Getting to this point implies that all data in the packet was 0 or 0x7e7e (filler), which only (should) happen when the image is finished being dumped and WSMR is filling
  ; the remaining bandwidth (10 Mbps) of the telemetry link with filler. 
  
  ;
  ; TASK 4.2: If totalPixels LE imageSize, issue warning.
  ;
  IF megsATotalPixelsFound LT 2048L * 1024L - 2L AND megsATotalPixelsFound NE 0 THEN BEGIN
    message, /INFO, JPMsystime() + $ ; -2 because we're expecting to lose two pixels due to including fiducials
                    ' Some MEGS A data in previous image was lost. Expected 2048x1024 = 2,097,152 pixels but received ' + JPMPrintNumber(megsATotalPixelsFound, /NO_DECIMALS)
  ENDIF
  
  ; Reset image pointers for a new image
  megsAPixelIndex = 0LL
  megsATotalPixelsFound = 0L
  
  ; Increment the number of image read
  megsAImageIndex++  
ENDELSE

;
;
; -= INSTRUMENT: MEGS-B =- ;
;
;

;
; TASK 2: Remove filler. WSMR stuffs in 0x7E7E. End up with new variable, instrumentPacketData.
;
megsBPacketDataGoodIndices = where(megsBPacketDataWithFiller NE 0 AND megsBPacketDataWithFiller NE '7E7E'X, numberOfFoundMegsBPixels)
IF numberOfFoundMegsBPixels NE 0 THEN BEGIN
  
  megsBPacketData = megsBPacketDataWithFiller[megsBPacketDataGoodIndices]
   
  ;
  ; TASK 3: Store pixels in common buffer. (Note: MEGS needs to be “unzipped”).
  ;
  FOR packetIndex = 0, n_elements(megsBPacketData) - 1 DO BEGIN
    IF megsBPixelIndex LT 2048LL * 1024LL THEN BEGIN
      megsBCcdColumnRow = megsCcdLookupTable[1:2, megsBPixelIndex]
      megsBImageBuffer[megsBCcdColumnRow[0], megsBCcdColumnRow[1]] = ((megsBPacketData[packetIndex] + '2000'X) AND '3FFF'X) ; The 0x2000 and 0x3FFF mask out the extra 2 bits (14 bits instead of 16)
      megsBPixelIndex++
    ENDIF
  ENDFOR
  megsBTotalPixelsFound += n_elements(megsBPacketData)
  IF keyword_set(DEBUG) THEN message, /INFO, JPMsystime () + 'MEGS-B total pixels found in this image so far: ' + JPMPrintNumber(megsBTotalPixelsFound, /NO_DECIMALS)
  
  ;
  ;   TASK 4: Check limits:
  ;      4.1: If totalPixels GT imageSize, issue warning.
  ;
  IF megsBTotalPixelsFound GT 2048L * 1024L THEN BEGIN
    message, /INFO, JPMsystime() + ' MEGS B image has accumulated too many pixels. Expected 2048x1024 = 2,097,152 pixels but received ' + JPMPrintNumber(megsBTotalPixelsFound, /NO_DECIMALS)
    megsBPixelIndex = 0LL
    megsBTotalPixelsFound = 0L
    megsBImageIndex++
  ENDIF
ENDIF ELSE BEGIN ; End of numberOfFoundMegsBPixels NE 0
  
  ; Getting to this point implies that all data in the packet was 0 or 0x7e7e (filler), which only (should) happen when the image is finished being dumped and WSMR is filling
  ; the remaining bandwidth (10 Mbps) of the telemetry link with filler. 
  
  ; TASK 4.2: If totalPixels LE imageSize, issue warning. 
  IF megsBTotalPixelsFound LT 2048L * 1024L - 2L AND megsBTotalPixelsFound NE 0 THEN BEGIN
    message, /INFO, JPMsystime() + $ ; -2 because we're expecting to lose two pixels due to including fiducials
                    ' Some MEGS B data in previous image was lost. Expected 2048x1024 = 2,097,152 pixels but received ' + JPMPrintNumber(megsBTotalPixelsFound, /NO_DECIMALS)
  ENDIF
  
  ; Reset image pointers for a new image
  megsBPixelIndex = 0LL
  megsBTotalPixelsFound = 0L
  
  ; Increment the number of image read
  megsBImageIndex++  
ENDELSE

;
;
; -= INSTRUMENT: CSOL =- ;
;
;

;;
;; TASK 2: Remove filler. WSMR stuffs in 0x7E7E. End up with new variable, instrumentPacketData.
;;
csolPacketDataGoodIndices = where(csolPacketDataWithFiller NE 0 AND csolPacketDataWithFiller NE '7E7E'X, numberOfFoundCsolPixels)
IF numberOfFoundCsolPixels NE 0 THEN BEGIN
  
  csolPacketData = csolPacketDataWithFiller[csolPacketDataGoodIndices]
  
  ;
  ; TASK 3: Store pixels in common buffer.
  ;
  
  ; Find the start sync
  csolFrameStartFiducial2Index = where(csolPacketData EQ csolFrameStartFiducialValue2)
  IF keyword_set(DEBUG) THEN BEGIN
    IF n_elements(csolFrameStartFiducial2Index) GT 1 THEN BEGIN
      message, /INFO, JPMsystime() + ' Only expected to find one CSOL start sync byte but found ' + JPMPrintNumber(n_elements(csolFrameStartFiducial2Index), /NO_DECIMALS)
    ENDIF
  ENDIF
  
  ; Extract the row number and columns that contain the desired measurements 
  IF csolFrameStartFiducial2Index NE [-1] THEN BEGIN
    csolFrameStartSyncFound = 1
    rowNumber = uint(csolPacketData[csolFrameStartFiducial2Index + 1]) ; TODO: Is any casting needed at all?
    
    ; Regions of interest
    darkTopData = csolPacketData[csolFrameStartFiducial2Index + 1 + 301: csolFrameStartFiducial2Index + 1 + 388]
    fuvData = csolPacketData[csolFrameStartFiducial2Index + 1 + 547: csolFrameStartFiducial2Index + 1 + 634]
    darkMiddleData = csolPacketData[csolFrameStartFiducial2Index + 1 + 757: csolFrameStartFiducial2Index + 1 + 844]
    muvData = csolPacketData[csolFrameStartFiducial2Index + 1 + 965: csolFrameStartFiducial2Index + 1 + 1052]
    darkBottomData = csolPacketData[csolFrameStartFiducial2Index + 1 + 1201: csolFrameStartFiducial2Index + 1 + 1288]
    
    ; Reformat and stuff into COMMON buffer variable -- swapping rows and columns to make the image wide rather than tall
    ; There's a gap between each of these that need not be manually populated -- can just be left 0
    csolImageBuffer[rowNumber, 0:88] = darkTopData
    csolImageBuffer[rowNumber, 1 * 88 + 1 * csolNumberGapPixels + 1: 2 * 88 + 1 * csolNumberGapPixels] = fuvData
    csolImageBuffer[rowNumber, 2 * 88 + 2 * csolNumberGapPixels + 1: 3 * 88 + 2 * csolNumberGapPixels] = darkMiddleData
    csolImageBuffer[rowNumber, 3 * 88 + 3 * csolNumberGapPixels + 1: 4 * 88 + 3 * csolNumberGapPixels] = muvData
    csolImageBuffer[rowNumber, 4 * 88 + 4 * csolNumberGapPixels + 1: 5 * 88 + 4 * csolNumberGapPixels] = darkBottomData
    
    csolTotalPixelsFound += 5L * 8L
    IF keyword_set(DEBUG) THEN message, /INFO, JPMsystime () + 'CSOL total pixels found in this image so far: ' + JPMPrintNumber(csolTotalPixelsFound, /NO_DECIMALS)
  ENDIF ELSE BEGIN ; Didn't find csolFrameStartFiducialValue2
    IF keyword_set(DEBUG) OR keyword_set(VERBOSE) THEN BEGIN
      message, /INFO, JPMsystime() + ' Did not find CSOL frame start sync byte 2: 0x' + csolFrameStartFiducialValue2.ToHex()
    ENDIF
  ENDELSE
  
  ; Find the end sync
  csolFrameEndFiducial1Index = where(csolPacketData EQ csolFrameEndFiducialValue1)
  IF keyword_set(DEBUG) THEN BEGIN
    IF n_elements(csolFrameEndFiducial1Index) GT 1 THEN BEGIN
      message, /INFO, JPMsystime() + ' Only expected to find one CSOL end sync byte but found ' + JPMPrintNumber(n_elements(csolFrameStartFiducial2Index), /NO_DECIMALS)
      STOP
    ENDIF
  ENDIF
  
  ; Increment the image counter if found the start and end syncs
  IF csolFrameStartFiducial2Index NE [-1] AND csolFrameEndFiducial1Index NE [-1] THEN BEGIN
    csolImageIndex++
  ENDIF
  
  ;
  ; TASK 4: Check limits:
  ;      4.1: If totalPixels GT imageSize, issue warning.
  ;      4.2: If totalPixels LE imageSize, issue warning.
  ;
  
  IF csolTotalPixelsFound GT 2000L * (5L * 88L) THEN message, /INFO, 'CSOL image has accumulated too many pixels. Expected 2000x(5*8) = 80,000 pixels but received ' + JPMPrintNumber(csolTotalPixelsFound, /NO_DECIMALS)
  IF csolFrameEndSyncFound AND csolTotalPixelsFound LT 1024L * 1024L THEN message, /INFO, 'Some CSOL data in previous image was lost. Expected 2000x(5*8) = 80,000  pixels but received ' + JPMPrintNumber(csolTotalPixelsFound, /NO_DECIMALS)
ENDIF ELSE BEGIN ; End CSOL data found
  
  ; Getting to this point implies that all data in the packet was 0 or 0x7e7e (filler), which only (should) happen when the image is finished being dumped and WSMR is filling
  ; the remaining bandwidth (10 Mbps) of the telemetry link with filler.

  ; TASK 4.2: If totalPixels LE imageSize, issue warning.
  IF csolTotalPixelsFound LT 2000L * (5L * 88L) AND csolTotalPixelsFound NE 0 THEN BEGIN
    message, /INFO, JPMsystime() + ' Some CSOL data in previous image was lost. Expected 2000x(5*8) = 80,000 pixels but received ' + JPMPrintNumber(csolTotalPixelsFound, /NO_DECIMALS)
  ENDIF
  
  ; Reset image pointers for a new image
  csolTotalPixelsFound = 0L

  ; Increment the number of image read
  csolImageIndex++
ENDELSE

END