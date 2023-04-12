;+
; NAME:
;   rocket_eve_tm1_real_time_display
;
; PURPOSE:
;   Wrapper script for reading from a remote socket. Calls rocket_eve_tm1_read_packets (the interpreter) when new data comes over the pipe. 
;
; INPUTS:
;   port [integer]: The port number to open that DEWESoft will be commanded to stream data to. This requires that both machines are running on the same network.
;                   This is provided as an optional input only so that a hardcoded value can be specified and the IDLDE Run button hit, instead
;                   of needing to call the code from the command line each time. However, a known port is really is necessary.
;
; OPTIONAL INPUTS:
;   windowSize [integer, integer]:          Set this to the pixel dimensions in [x, y] that you want the display. Default is [1000, 800].
;   data_output_path_file_prepend [string]: Where output csv files will be stored. Path and whatever prepend is desired for the filename. 
;                                           Default is '/Users/minxss/Dropbox/minxss_dropbox/data/reve_36_353/tm1_files/rocket_analog_monitors_'
;   frequencyOfImageDisplay [integer]:      Number of packets to skip after each display, default=10. In conjunction with the wait, this controls
;                                           how busy the system will be. Increase to make screen refreshes less frequent to reduce the load.
;
; KEYWORD PARAMETERS:
;   DEBUG:            Set to print debugging information, such as the sizes of and listed in the packets.
;   LIGHT_BACKGROUND: Set this to use a white background and dark font instead of the default (black background and white font)
;
; OUTPUTS:
;   Produces 2 display pages with all the most important data in the world, displayed in real time from a remote socket.
;
; OPTIONAL OUTPUTS:
;   None
;   
; COMMON BLOCK VARIABLES: 
;   See rocket_eve_tm1_read_packets for a detailed description. And yes, I know common blocks are bad practice. However, we wanted socket reader / data interpreter modularity but still
;   require persistent data between the two. Passing variables back and forth between two functions is done by reference, but would result in messy code. So here we are with common blocks. 
;
; RESTRICTIONS:
;   Requires that the data pipe computer IS NOT YET RUNNING. See procedure below for the critical step-by-step to get the link up. 
;   Requires JPMRange.pro
;   Requires JPMPrintNumber.pro
;
; PROCEDURE: 
;   Prior to running this code: 
;   0) Connect this machine to a network with the machine running DEWESoft. This can be done with a crossover cable connecting their two ethernet ports. 
;   1) Start rocket_tm1_start.scpt (Note: this expects the Dewesoft computers IP to be 169.254.17.237 with port 8999 and tranfer port 8002 so if you change
;      these defaults you'll have to change both what this IDL procedure is expecting and what the apple script is doing)
;   
;   Or if you hate yourself and want to do things manually:
;   0) Connect this machine to a network with the machine running DEWESoft. This can be done with a crossover cable connecting their two ethernet ports. 
;   1) Open a terminal (e.g., terminal.app in OSX)
;   2) type: telnet ipAddress 8999 (where ipAddress is the IP address (duh) of the DEWESoft machine e.g., telnet 169.254.17.237 8999. 
;            8999 is the commanding port and should not need to be changed). You should get an acknowledgement: +CONNECTED DEWESoft TCP/IP server. 
;   3) type: listusedchs (This should return a list of all channels being used. EVE data is in three parallel streams, P1, P2, and P3. 
;            Note the corresponding channel numbers. For EVE these are ch 13, 14, and 12, respectively).
;   4) type: /stx preparetransfer
;   5) type: ch 56
;            ch 58
;            ch 62
;            ch ... (For each channel. There should be 23 in total...).
;   6) type: /etx You should get an acknowledgement: +OK
;   7) NOW you can start this code. It will open the port specified in the input parameter, or use the hard-coded default if not provided in the call. Then it will STOP. Don't continue yet. 
;   Back to the terminal window
;   8) type: starttransfer port (where port is the same port IDL is using in step 8 above, e.g., starttransfer 8002)
;   9) type: setmode 1 You'll either see +ERR Already in this mode or +OK Mode 1 (control) selected, 
;             depending on if you've already done this step during debugging this when it inevitably doesn't work the first time. 
;   10) type: startacq You should get an acknowledgement: +OK Acquiring
;   11) NOW you can continue running this code
;
; EXAMPLE:
;   See PROCEDURE above for examples of each step. 
;
; MODIFICATION HISTORY:
;   2017-08-08: James Paul Mason: Wrote script based on rocket_eve_tm2_real_time_display.
;   2018-05-29: Robert Henry Alexander Sewell: Updated for 36.336 launch
;   2021: Don Woodraska and James Mason: Updated for 36.353- added frequencyOfImageDisplay keyword to allow code to keep up
;   2023-03-10: Don Woodraska Updated for 36.389, calling convert_temeperatures
;   2023-03-30 Don Woodraska Added test_display_only keyword to allow repositioning items on the displays
;
;-
PRO rocket_eve_tm1_real_time_display, port=port, windowSize=windowSize, data_output_path_file_prepend=data_output_path_file_prepend, $
                                      DEBUG=DEBUG, LIGHT_BACKGROUND=LIGHT_BACKGROUND, frequencyOfImageDisplay=frequencyOfImageDisplay, test_display_only=test_display_only

; Defaults
IF ~keyword_set(port) THEN port = 8002
IF ~keyword_set(windowSize) THEN windowSize = [1000, 700]
IF ~keyword_set(frequnecyOfImageDisplay) THEN frequencyofImageDisplay = 10
IF keyword_set(LIGHT_BACKGROUND) THEN BEGIN
  fontColor = 'black'
  backgroundColor = 'white'
  boxColor = 'light steel blue'
ENDIF ELSE BEGIN
  fontColor = 'white'
  backgroundColor = 'black'
  boxColor = 'midnight blue'
ENDELSE
blueColor = 'dodger blue'
redColor = 'tomato'
greenColor='lime green'
fontSize = 16

; Edit here to change axis ranges, titles, locations, etc. 
textVSpacing = 0.05 ; Vertical spacing
textHSpacing = 0.02 ; Horizontal spacing
topLinePosition = 0.90

graphicinfo = {fontColor:fontColor, $
               backgroundColor:backgroundColor, $
               boxColor:boxColor, $
               blueColor:blueColor, $
               redColor:redColor, $
               greenColor:greenColor, $
               fontSize:fontSize, $
               textVSpacing:textVSpacing, $
               textHSpacing:textHSpacing, $
               topLinePosition:topLinePosition }

if keyword_set(test_display_only) then goto, label_create_display

; Open a port that the DEWESoft computer will be commanded to stream to (see PROCEDURE in this code's header)
socket, connectionCheckLUN, port, /LISTEN, /GET_LUN, /RAWIO
STOP, 'Wait until DEWESoft is set to startacq. Then click go.'

; Prepare a separate logical unit (LUN) to read the actual incoming data
get_lun, socketLun

; Prepare output file
open_tm1_csv_data_file_for_writing, file_lun

; Wait for the connection from DEWESoft to be detected
isConnected = 0
WHILE isConnected EQ 0 DO BEGIN

  IF file_poll_input(connectionCheckLUN, timeout = 5.0) THEN BEGIN ; Timeout is in seconds
    socket, socketLun, accept = connectionCheckLUN, /RAWIO, CONNECT_TIMEOUT = 30., READ_TIMEOUT = 30., WRITE_TIMEOUT = 30., /SWAP_IF_BIG_ENDIAN
    isConnected = 1
  ENDIF ELSE message, /INFO, JPMsystime() + ' No connection detected yet.'
ENDWHILE

; Prepare a socket read buffer
socketDataBuffer = !NULL

; Mission specific setup. Edit this to tailor data.
; e.g., instrument calibration arrays such as gain to be used in the PROCESS DATA section below
;36.336
;synctype = [0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1] ; Index which channels are synchronous (0) or async (1) corresponding to channel order pulled
;megsp_temp=0,megsa_htr=0,xrs_5v=0,csol_5v=1,slr_pressure=0,cryo_cold=0,megsb_htr=0,xrs_temp=0,megsa_ccd_temp=0,megsb_ccd_temp=1,cryo_hot=1,exprt_28v=1,vac_valve_pos=1,hvs_pressure=1,exprt_15v=1,fpga_5v=1,tv_12v=1,megsa_ff_led=1,megsb_ff_led=1,exprt_bus_cur=0,sdoor_pos=1,tm_exp_batt_volt=0,esp_fpga_time=1,esp_rec_counter=1
;esp1=1,esp2=1,esp3=1,esp4=1
;esp5=1,esp6=1,esp7=1,esp8=1
;esp9=1,megsp_fpga_time=1,megsp1=1,megsp2=1

;36.353
;synctype = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] ; 35 items
;megsp_temp=0,megsa_htr=0,**xrs_5v=0,slr_pressure=0,cryo_cold=0,megsb_htr=0,xrs_temp=0,megsa_ccd_temp=0,megsb_ccd_temp=1,cryo_hot=1,**exprt_28v=1,vac_valve_pos=1,hvs_pressure=1,**exprt_15v=1,**fpga_5v=1,tv_12v=1,megsa_ff_led=1,megsb_ff_led=1,**sdoor_pos=1,exprt_bus_cur=0,tm_exp_batt_volt=0,esp_fpga_time=1,esp_rec_counter=1
;esp1=1,esp2=1,esp3=1,esp4=1,esp5=1,esp6=1,esp7=1,esp8=1,esp9=1,
;megsp_fpga_time=1,megsp1=1,megsp2=1

;36.389
synctype = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] ; Index which channels are synchronous (0) or async (1) corresponding to channel order pulled
;-- megsp_temp=0, megsa_htr=0, xrs_5v=0, slr_pressure=0, cryo_cold=0, megsb_htr=0, xrs_temp=0, megsa_ccd_temp=0, megsb_ccd_temp=1, cryo_hot=1,
;-- exprt_28v=1, vac_valve_pos=1, hvs_pressure=1, exprt_15v=1, fpga_5v=1, tv_12v=1, megsa_ff_led=1, megsb_ff_led=1,
;-- sdoor_pos=1, exprt_bus_cur=0, tm_exp_batt_volt=0,
;-- esp_fpga_time=1, esp_rec_counter=1, esp1=1, esp2=1, esp3=1, esp4=1, esp5=1, esp6=1, esp7=1, esp8=1, esp9=1,
;-- megsp_fpga_time=1, megsp1=1, megsp2=1

; door history
sdoor_history=lonarr(10)

label_create_display:

; Initialize monitor structure
analogMonitorsStructure = {megsp_temp: 0.0, megsa_htr: 0.0, xrs_5v:0.0,$
  slr_pressure:0.0,cryo_cold:0.0,megsb_htr:0.0,xrs_temp:0.0,$
  megsa_ccd_temp1:0.0,megsb_ccd_temp1:0.0, megsa_ccd_temp2:0.0,megsb_ccd_temp2:0.0, $
  ; added megsa2 & b2 temps 4/10/23 DLW
  cryo_hot:0.0,exprt_28v:0.0,$
  vac_valve_pos:0.0,hvs_pressure:0.0,exprt_15v:0.0,fpga_5v:0.0,$
  tv_12v:0.0,megsa_ff_led:0.0,megsb_ff_led:0.0,sdoor_pos:0.0,$
  exprt_bus_cur:0.0,tm_exp_batt_volt:0.0, $
  ; serial data starts here
  esp_fpga_time:0.0,esp_rec_counter:0.0,$
  esp1:0.0,esp2:0.0,esp3:0.0,esp4:0.0,esp5:0.0,esp6:0.0,esp7:0.0,esp8:0.0,esp9:0.0,$
  megsp_fpga_time:0.0,megsp1:0.0,megsp2:0.0}
; the order of the analogMonitorsStructure corresponds to the data
; order defined in rocket_tm1_start.scpt
; for the first part, the last part is serial data broken out of
; stream s2 (ESPSerialStream) and s3 (MEGSPSerialStream)

defAnalogMonitorStructure = define_analog_monitor_structure()

; Initialize invalid Dewesoft packet counters
stale_analog = 0
stale_serial = 0
sdoor_state = 'UNKNOWN'

; -= CREATE PLACE HOLDER PLOTS =- ;

; Monitors
; Note that all of the t = below are just static labels so they do not need unique variables

; Serial monitor window
; Displays ESP and MEGS-P diode readouts
wb = window(DIMENSIONS = [400,750], /NO_TOOLBAR, LOCATION = [0, 0], BACKGROUND_COLOR = backgroundColor, WINDOW_TITLE = 'Serial Monitors')

; initialize tm1 display
; start with serial3 (ESP) data
position_tm1_esp_megsp_on_window, s3_time, s3_cnt, $
                                  s3_esp1, s3_esp2, s3_esp3, s3_esp4, s3_esp5, s3_esp6, s3_esp7, s3_esp8, s3_esp9, $
                                  s4_time, s4_megsp1, s4_megsp2, monitorsSerialRefreshText, $
                                  graphicInfo=graphicInfo


; Analog monitor window
; Displays limit checked hk
wa = window(DIMENSIONS = [1000, 750], /NO_TOOLBAR, LOCATION = [406, 0], BACKGROUND_COLOR = backgroundColor, WINDOW_TITLE = 'EVE Rocket 36.389 Analog Monitors')

position_tm1_analog_on_window, t_exprt_28v, t_exp_batt_volt, t_exp_bus_cur, t_sdoor_state, t_vac_valve_pos, t_HVS_Pressure, t_slr_pressure, t_cryo_cold, t_cryo_hot, t_fpga_5v, t_tv_12v, $
                               t_megsa_htr, t_megsb_htr, t_ma_ccd_temp1, t_mb_ccd_temp1, t_ma_ccd_temp2, t_mb_ccd_temp2, t_megsa_ff_led, t_megsb_ff_led, t_MEGSP_temp, $
                               monitorsRefreshText, $
                               graphicInfo=graphicInfo

serialTextObjArray = [monitorsSerialRefreshText, s3_time, s3_cnt, s3_esp1, s3_esp2, s3_esp3, s3_esp4, s3_esp5, s3_esp6, s3_esp7, s3_esp8, s3_esp9, s4_time, s4_megsp1, s4_megsp2]

analogTextObjArray = [t_exprt_28v, t_exp_batt_volt, t_exp_bus_cur, t_sdoor_state, t_vac_valve_pos, t_HVS_Pressure, t_slr_pressure, t_cryo_cold, t_cryo_hot, t_fpga_5v, t_tv_12v, $
  t_megsa_htr, t_megsb_htr, t_ma_ccd_temp1, t_mb_ccd_temp1, t_ma_ccd_temp2, t_mb_ccd_temp2, t_megsa_ff_led, t_megsb_ff_led, t_MEGSP_temp, monitorsRefreshText]

if keyword_set(test_display_only) then stop


dewesoftcounter = 0L ; initialize counter for drawing to the screen

; Start an infinite loop to check the socket for data
WHILE 1 DO BEGIN

  ; Start a timer
  wrapperClock = TIC()
  
  ; Store how many bytes are on the socket
  socketDataSize = (fstat(socketLun)).size
  
  ; Trigger data processing if there's actually something to process
  IF socketDataSize GT 0 THEN BEGIN
    
    ; Read data on the socket
    socketData = bytarr((fstat(socketLun)).size)
    readu, socketLun, socketData
    IF keyword_set(DEBUG) THEN BEGIN
      print,strtrim(systime(),2)+' bytes read = '+strtrim(n_elements(socketData),2)
    ENDIF
    
    ; make winodws stale if no updates for 10 seconds
    IF toc(serialMonitorUpdateTime) GT 10 AND toc(serialMonitorUpdateTime) LT 20 THEN BEGIN
      set_monitor_window_color, serialTextObjArray
    ENDIF
    IF toc(analogMonitorUpdateTime) GT 10 AND toc(analogMonitorUpdateTime) LT 20 THEN BEGIN
      set_monitor_window_color, analogTextObjArray
    ENDIF
    
    wait, 0.05 ; Tune this so that the above print statement is telling you that you get ~18,000-20,000 bytes per read (or so)
    
    ; Stuff the new socketData into the buffer. This will work even the first time around when the buffer is !NULL. 
    socketDataBuffer = [temporary(socketDataBuffer), temporary(socketData)]
    
    ; Do an efficient search for just the last DEWESoft sync byte
    sync7Indices = where(socketDataBuffer EQ 7, numSync7s)
    
    ; Find all start syncs
    wStartSync = where(socketDataBuffer EQ 0 AND $
      shift(socketDataBuffer, -1) EQ 1 AND $
      shift(socketDataBuffer, -2) EQ 2 AND $
      shift(socketDataBuffer, -3) EQ 3 AND $
      shift(socketDataBuffer, -4) EQ 4 AND $
      shift(socketDataBuffer, -5) EQ 5 AND $
      shift(socketDataBuffer, -6) EQ 6 AND $
      shift(socketDataBuffer, -7) EQ 7 AND $
      shift(socketDataBuffer, -12) EQ 0 AND $
      shift(socketDataBuffer, -13) EQ 0 AND $
      shift(socketDataBuffer, -14) EQ 0 AND $
      shift(socketDataBuffer, -15) EQ 0, nsync)
    IF nsync LE 1 THEN BEGIN
      CONTINUE ; Go back to the socket and read more data because we don't have a start and stop sync yet
    ENDIF
    
    ; Get the stop sync location
    wStopSync = wStartSync[1:*] - 15 ; last one may be wrong (it's the end of the buffer, not necessarily the stop sync
    
    ; Prepare to include the start sync itself in the full Dewesoft packet -- wStartSync is now the index of 0
    
    ; Read packet type and if it's not our data (type 0) then ... something
    packetType = byte2ulong(socketDataBuffer[wStartSync[-2]+12:wStartSync[-2]+12+3])
    IF packetType NE 0 THEN BEGIN
      message, /INFO, 'ERROR: PackerType is incorrect - fatal - cannot continue :'+strtrim(packetType,2)
      STOP
    ENDIF
    
    ; Store the data to be processed between the DEWESoft start/stop syncs
    singleFullDeweSoftPacket = socketDataBuffer[wStartSync[-2]:wStopSync[-1]]
    
    
    
    ; If some 0x07 sync bytes were found, THEN loop to verify the rest of the sync byte pattern (0x00 0x01 0x02 0x03 0x04 0x05 0x06)
    ; and process the data between every set of two verified sync byte patterns
    IF numSync7s GE 2 THEN BEGIN
      
      ; Reset the index of the verified sync patterns
      verifiedSync7Index = wStartSync[1]
      
        
        
        ; -= PROCESS DATA =- ;
        
        ; Offsets will be an array of where in the Dewesoft packet our data is per channel
        offsets = []
        ; Samplesize is the length of each of our data channels within the Dewesoft packet
        samplesize = []
        
        ; Grab packet samples
        FOR i = 0, n_elements(synctype)-13 DO BEGIN ; JPM: Why -13?
          IF i EQ 0 THEN BEGIN
            offsets = [offsets, 36] ; Header of Dewesoft packet is 36 bytes long until the first packet size
            samplesize = [samplesize, byte2ulong(singleFullDeweSoftPacket[offsets[i]:offsets[i] + 3])] ; Sample size is the next long word
          ENDIF ELSE BEGIN
            IF synctype[i-1] EQ 0 THEN BEGIN
              sampleSizeDeweSoft = 2 ; This is the multiplication factor for synchronus data to get the data channel size
            ENDIF ELSE BEGIN ; in 36.389 everything is asynchronous
              sampleSizeDeweSoft = 10 ; This is the multiplication factor for asynchronus data to get the data channel size
            ENDELSE
            IF samplesize[i-1] EQ 0 THEN BREAK ; Handle when dewesoft pads packets for some reason and we can no longer get the correct offsets
            offsets = [offsets, offsets[i-1] + 4 + sampleSizeDeweSoft * samplesize[i-1]]
            samplesize = [samplesize, byte2ulong(singleFullDeweSoftPacket[offsets[i]:offsets[i] + 3])]
          ENDELSE
        ENDFOR
        offsets = [offsets, n_elements(singleFullDeweSoftPacket)] ; Last offset is the end of the Dewesoft packet +1
        
        ; -= INTERPRET DATA =- ;
        ; rocket_eve_tm1_read_packets actually processes the channel data using offsets and sample size and passes back a struct with our data
        analogMonitors = rocket_eve_tm1_read_packets(singleFullDeweSoftPacket, analogMonitorsStructure, offsets, samplesize, monitorsRefreshText, monitorsSerialRefreshText, $
                                                     stale_analog, stale_serial, sdoor_state,sdoor_history)
        
        dewesoftcounter += 1
        
        if dewesoftcounter gt frequencyOfImageDisplay then begin

          ; Convert voltages to temperature for the 36.336 flight

          ; 36.389 uses convert_temperatures function
          ; analogMonitors contains voltages
          ; temperatures end in _temp
          MEGSP_temp = convert_temperatures( analogMonitors.megsp_temp, /megsp_temp )
          XRS1_temp = convert_temperatures( analogMonitors.xrs_temp, /xrs_temp ) ; NOT USED?
          Cryo_Hotside_temp = convert_temperatures( analogMonitors.cryo_hot, /cryo_hot )
          cryo_coldside_temp = convert_temperatures( analogMonitors.cryo_cold, /cryo_cold )
          megsa_ccd_prt_temp = convert_temperatures( analogMonitors.megsa_ccd_temp1, /megsa_ccd_prt )
          megsb_ccd_prt_temp = convert_temperatures( analogMonitors.megsb_ccd_temp1, /megsb_ccd_prt )
          megsa_ccd_diode_temp = convert_temperatures( analogMonitors.megsa_ccd_temp2, /megsa_ccd_diode )
          megsb_ccd_diode_temp = convert_temperatures( analogMonitors.megsb_ccd_temp2, /megsb_ccd_diode )
          
          ; Write data to file if its new
          IF stale_analog EQ 0 THEN BEGIN
             write_tm1_to_csv_data_file, file_lun, analogMonitors
          ENDIF
          
  ;        ; -= UPDATE PLOT WINDOWS WITH REASONABLE REFRESH RATE =- ;
  ;        !Except = 0 ; Disable annoying divide by 0 messages
  ;        t1a.string='MEGSP FPGA Time = '+jpmprintnumber(analogMonitors.megsp_fpga_time)
  ;        t2a.string='ESP FPGA Time = '+jpmprintnumber(analogMonitors.esp_fpga_time)
  ;        t2b.string='ESP Record Counter = '+jpmprintnumber(analogMonitors.esp_rec_counter)
          
          ; We continually update the display as, even if we don't get a new valid Dewesoft packet, the valid data is still in the monitor struct
          ; Window 1 display
          wtime = tic()
          t_exprt_28v.string = jpmprintnumber(analogMonitors.exprt_28v)
          t_exp_batt_volt.string = jpmprintnumber(analogMonitors.tm_exp_batt_volt)
          t_exp_bus_cur.string = jpmprintnumber(analogMonitors.exprt_bus_cur)
          t_slr_pressure.string = jpmprintnumber(analogMonitors.slr_pressure)
          t_cryo_cold.string = jpmprintnumber(cryo_coldside_temp)
          t_fpga_5v.string = jpmprintnumber(analogMonitors.fpga_5v)
          t_tv_12v.string = jpmprintnumber(analogMonitors.tv_12v)
          t_ma_ccd_temp1.string = jpmprintnumber(megsa_ccd_prt_temp)+" ("+jpmprintnumber(analogMonitors.megsa_ccd_temp1)+")"
          t_mb_ccd_temp1.string = jpmprintnumber(megsb_ccd_prt_temp)+" ("+jpmprintnumber(analogMonitors.megsb_ccd_temp1)+")"
          t_ma_ccd_temp2.string = jpmprintnumber(megsa_ccd_diode_temp)+" ("+jpmprintnumber(analogMonitors.megsa_ccd_temp2)+")"
          t_mb_ccd_temp2.string = jpmprintnumber(megsb_ccd_diode_temp)+" ("+jpmprintnumber(analogMonitors.megsb_ccd_temp2)+")"
          t_MEGSP_temp.string = jpmprintnumber(MEGSP_temp)
          t_HVS_Pressure.string = jpmprintnumber(analogMonitors.hvs_pressure)
          ; t_megsa_ff_led and t_megsb_ff_led are updated in the limit checking
          t_cryo_hot.string = jpmprintnumber(Cryo_Hotside_temp)
          t_sdoor_state.string = sdoor_state
          IF ((analogMonitors.vac_valve_pos LE 0.2 AND analogMonitors.vac_valve_pos GT -1) OR (analogMonitors.vac_valve_pos GE 3.3 AND analogMonitors.vac_valve_pos LT 3.6)) THEN BEGIN
            t_vac_valve_pos.string="Moving ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDIF ELSE IF (analogMonitors.vac_valve_pos LE -1 OR analogMonitors.vac_valve_pos GE 3.6) THEN BEGIN
            t_vac_valve_pos.string="Open ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDIF ELSE BEGIN
            t_vac_valve_pos.string="Closed ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDELSE
          
          
          ; Window 0 display
          s3_time.string = jpmprintnumber(analogMonitors.esp_fpga_time, /NO_DECIMALS)
          s3_cnt.string = jpmprintnumber(analogMonitors.esp_rec_counter, /NO_DECIMALS)
          s3_esp1.string = jpmprintnumber(analogMonitors.esp1, /NO_DECIMALS)
          s3_esp2.string = jpmprintnumber(analogMonitors.esp2, /NO_DECIMALS)
          s3_esp3.string = jpmprintnumber(analogMonitors.esp3, /NO_DECIMALS)
          s3_esp4.string = jpmprintnumber(analogMonitors.esp4, /NO_DECIMALS)
          s3_esp5.string = jpmprintnumber(analogMonitors.esp5, /NO_DECIMALS)
          s3_esp6.string = jpmprintnumber(analogMonitors.esp6, /NO_DECIMALS)
          s3_esp7.string = jpmprintnumber(analogMonitors.esp7, /NO_DECIMALS)
          s3_esp8.string = jpmprintnumber(analogMonitors.esp8, /NO_DECIMALS)
          s3_esp9.string = jpmprintnumber(analogMonitors.esp9, /NO_DECIMALS)
          s4_time.string = jpmprintnumber(analogMonitors.megsp_fpga_time, /NO_DECIMALS)
          s4_megsp1.string = jpmprintnumber(analogMonitors.megsp1, /NO_DECIMALS)
          s4_megsp2.string = jpmprintnumber(analogMonitors.megsp2, /NO_DECIMALS)

          serialMonitorUpdateTime = tic()
          
          ; -= LIMIT CHECKING =- ;
          
          ; Sets the refresh text at the bottom of the analog window to purple if we get 20 invalid dewesoft packets
          IF (stale_analog GT 20) THEN BEGIN
            set_monitor_window_color, analogTextObjArray
          ENDIF ELSE BEGIN
            monitorsRefreshText.font_color = blueColor
            set_monitor_window_color, [t_sdoor_state, t_vac_valve_pos, t_HVS_Pressure, t_tv_12v, t_MEGSP_temp,t_cryo_hot], color=fontColor

            get_color_limit, t_exprt_28v, analogMonitors.exprt_28v, rl=0, rh=22
            get_color_limit, t_exp_batt_volt, analogMonitors.tm_exp_batt_volt, rl=22, rh=35
            get_color_limit, t_exp_bus_cur, analogMonitors.exprt_bus_cur, rl=0.9, rh=2
            get_color_limit, t_slr_pressure, analogMonitors.slr_pressure, rl=0, rh=.5
            get_color_limit, t_cryo_cold, cryo_coldside_temp, rl=-273, rh=-35
            get_color_limit, t_fpga_5v, analogMonitors.fpga_5v, rl=4.5, rh=5.5
            get_color_limit, t_megsa_htr, analogMonitors.megsa_htr, rl=-1, rh=0.2, red_string='ON ', green='OFF '
            get_color_limit, t_megsb_htr, analogMonitors.megsb_htr, rl=-1, rh=0.2, red_string='ON ', green='OFF '
            get_color_limit, t_ma_ccd_temp1, analogMonitors.megsa_ccd_temp1, rl=0, rh=3, green_string=megsa_ccd_prt_temp, red_string=megsa_ccd_prt_temp
            get_color_limit, t_mb_ccd_temp1, analogMonitors.megsb_ccd_temp1, rl=0, rh=3, green_string=megsb_ccd_prt_temp, red_string=megsb_ccd_prt_temp
            get_color_limit, t_ma_ccd_temp2, analogMonitors.megsa_ccd_temp2, rl=0, rh=3, green_string=megsa_ccd_diode_temp, red_string=megsa_ccd_diode_temp
            get_color_limit, t_mb_ccd_temp2, analogMonitors.megsb_ccd_temp2, rl=0, rh=3, green_string=megsb_ccd_diode_temp, red_string=megsb_ccd_diode_temp
            get_color_limit, t_megsa_ff_led, analogMonitors.megsa_ff_led, rl=-0.1, rh=0.2, red_string='ON ', green='OFF '
            get_color_limit, t_megsb_ff_led, analogMonitors.megsb_ff_led, rl=-0.1, rh=0.2, red_string='ON ', green='OFF '

            analogMonitorUpdateTime = tic()
            
          ENDELSE
      
          ; Sets the refresh text at the bottom of the serial window to purple if we get 20 invalid dewesoft packets
          IF (stale_serial GT 40) THEN BEGIN
            set_monitor_window_color, serialTextObjArray
          ENDIF ELSE BEGIN
            monitorsSerialRefreshText.font_color = bluecolor
            set_monitor_window_color,[s3_time, s3_cnt, s3_esp1, s3_esp2, s3_esp3, s3_esp4, s3_esp5, s3_esp6, s3_esp7, s3_esp8, s3_esp9, s4_time, s4_megsp1, s4_megsp2], color=fontColor
          ENDELSE
          IF keyword_set(DEBUG) THEN BEGIN
            print,'window write time = '+strtrim(toc(wtime),2)
          ENDIF
            
          !Except = 1 ; Re-enable math error logging
          
          dewesoftcounter = 0L ; reset
        ENDIF ; If dewesoftcounter > frequencyOfImageDisplay

        
        ; Loop to find the full sync and throw out the unncessarily fast samples
        wStartSync = where(socketDataBuffer[sync7Indices] EQ 7 AND $
                     socketDataBuffer[sync7Indices-1] EQ 6 AND $
                     socketDataBuffer[sync7Indices-2] EQ 5 AND $
                     socketDataBuffer[sync7Indices-3] EQ 4 AND $
                     socketDataBuffer[sync7Indices-4] EQ 3 AND $
                     socketDataBuffer[sync7Indices-5] EQ 2 AND $
                     socketDataBuffer[sync7Indices-6] EQ 1, nsync)
        IF nsync GT 0 THEN BEGIN
          lastStartSync = wStartSync[-1]
          socketDataBuffer = socketDataBuffer[ sync7Indices[lastStartSync]-7:-1 ]
        ENDIF
      
    ENDIF ; IF numSync7s GE 2
  ENDIF ;ELSE IF keyword_set(DEBUG) THEN message, /INFO, JPMsystime() + ' Socket connected but 0 bytes on socket.' ; If socketDataSize GT 0

  ;IF keyword_set(DEBUG) THEN BEGIN
    ;IF !version.release GT '8.2.2' THEN message, /INFO, JPMsystime() + ' Finished processing socket data in time = ' + JPMPrintNumber(TOC(wrapperClock)) ELSE $
  ;                                      message, /INFO, JPMsystime() + ' Finished processing socket data in time = ' + JPMPrintNumber(JPMsystime(/SECONDS) - wrapperClock)
  ;ENDIF
  ;message, /INFO, JPMsystime() + ' Finished processing socket data in ' + JPMPrintNumber(TOC(wrapperClock), /SCIENTIFIC_NOTATION) + 'seconds'
ENDWHILE ; Infinite loop

; These lines never get called since the only way to exit the above infinite loop is to stop the code
free_lun, socketlun
free_lun, file_lun

END
