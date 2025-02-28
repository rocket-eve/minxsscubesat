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
;-
PRO rocket_eve_tm1_real_time_display_36336, port=port, windowSize=windowSize, data_output_path_file_prepend=data_output_path_file_prepend, $
                                      DEBUG=DEBUG, LIGHT_BACKGROUND=LIGHT_BACKGROUND

; Defaults
IF ~keyword_set(port) THEN port = 8002
IF ~keyword_set(windowSize) THEN windowSize = [1000, 700]
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

; Open a port that the DEWESoft computer will be commanded to stream to (see PROCEDURE in this code's header)
socket, connectionCheckLUN, port, /LISTEN, /GET_LUN, /RAWIO
STOP, 'Wait until DEWESoft is set to startacq. Then click go.'

; Prepare a separate logical unit (LUN) to read the actual incoming data
get_lun, socketLun

; Prepare output file
openw, file_lun, getenv('HOME') + '/Dropbox/minxss_dropbox/data/reve_36_353/tm1_files/rocket_analog_monitors_' + strjoin(strsplit(jpmsystime(), /EXTRACT), '_')+'.csv', /GET_LUN

printf,file_lun,'Time, megsp_temp, megsa_htr, xrs_5v, slr_pressure, '+$
                'cryo_cold, megsb_htr, xrs_temp, megsa_ccd_temp, megsb_ccd_temp, cryo_hot, exprt_28v, '+$
                'vac_valve_pos, hvs_pressure, exprt_15v, fpga_5v, tv_12v, megsa_ff_led, megsb_ff_led, '+$
                'sdoor_oc','exprt_bus_cur, exprt_main_28v, esp_fpga_time, esp_rec_counter, esp1, esp2, esp3, esp4, '+$
                'esp5, esp6, esp7, esp8, esp9, megsp_fpga_time, megsp1, megsp2'

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
;megsp_temp=0,megsa_htr=0,xrs_5v=0,csol_5v=1,slr_pressure=0,cryo_cold=0,megsb_htr=0,xrs_temp=0,megsa_ccd_temp=0,megsb_ccd_temp=1,cryo_hot=1,exprt_28v=1,vac_valve_pos=1,hvs_pressure=1,exprt_15v=1,fpga_5v=1,tv_12v=1,megsa_ff_led=1,megsb_ff_led=1,exprt_bus_cur=0,sdoor_oc=1,exprt_main_28v=0,esp_fpga_time=1,esp_rec_counter=1
;esp1=1,esp2=1,esp3=1,esp4=1
;esp5=1,esp6=1,esp7=1,esp8=1
;esp9=1,megsp_fpga_time=1,megsp1=1,megsp2=1

;36.353
synctype = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
;megsp_temp=0,megsa_htr=0,**xrs_5v=0,slr_pressure=0,cryo_cold=0,megsb_htr=0,xrs_temp=0,megsa_ccd_temp=0,megsb_ccd_temp=1,cryo_hot=1,**exprt_28v=1,vac_valve_pos=1,hvs_pressure=1,**exprt_15v=1,**fpga_5v=1,tv_12v=1,megsa_ff_led=1,megsb_ff_led=1,**sdoor_oc=1,exprt_bus_cur=0,exprt_main_28v=0,esp_fpga_time=1,esp_rec_counter=1
;esp1=1,esp2=1,esp3=1,esp4=1
;esp5=1,esp6=1,esp7=1,esp8=1
;esp9=1,megsp_fpga_time=1,megsp1=1,megsp2=1
; Arrays for thermal conversions for 36.336 monitors
; TODO: move the thermal conversions to a different function call
woods5 = [0.00147408,0.00023701459,1.0839894e-7]
woods6 = [0.0014051,0.0002369,1.019e-7]
woods7 = [0.001288,0.0002356,9.557e-8]
woods8 = [0.077,0.1037,0.0256]
woods11 = [15.0,11.75,5.797]
woods14 = [15.0,12.22,5.881]
woods15 = [15.0,11.71,5.816]
woods17 = [257.122,-257.199]

esp_d1 = []
esp_d2 = []
esp_d3 = []
esp_d4 = []
esp_d5 = []
esp_d6 = []
esp_d7 = []
esp_d8 = []
esp_d9 = []

megsp_d1 = []
megsp_d2 = []

sdoor_history=lonarr(10)
; Initialize monitor structure

analogMonitorsStructure = {megsp_temp: 0.0, megsa_htr: 0.0, xrs_5v:0.0,$
  slr_pressure:0.0,cryo_cold:0.0,megsb_htr:0.0,xrs_temp:0.0,$
  megsa_ccd_temp:0.0,megsb_ccd_temp:0.0,cryo_hot:0.0,exprt_28v:0.0,$
  vac_valve_pos:0.0,hvs_pressure:0.0,exprt_15v:0.0,fpga_5v:0.0,$
  tv_12v:0.0,megsa_ff_led:0.0,megsb_ff_led:0.0,sdoor_oc:0.0,$
  exprt_bus_cur:0.0,exprt_main_28v:0.0,esp_fpga_time:0.0,esp_rec_counter:0.0,$
  esp1:0.0,esp2:0.0,esp3:0.0,esp4:0.0,esp5:0.0,esp6:0.0,esp7:0.0,esp8:0.0,esp9:0.0,$
  megsp_fpga_time:0.0,megsp1:0.0,megsp2:0.0}

; Initialize invalid Dewesoft packet counters
stale_a = 0
stale_s = 0
sdoor_state = 'UNKNOWN'

; -= CREATE PLACE HOLDER PLOTS =- ;
; Edit here to change axis ranges, titles, locations, etc. 
textVSpacing = 0.05 ; Vertical spacing
textHSpacing = 0.02 ; Horizontal spacing
topLinePosition = 0.90

; Monitors
; Note that all of the t = below are just static labels so they do not need unique variables

; Serial monitor window
; Displays ESP and MEGS-P diode readouts
wb = window(DIMENSIONS = [400,750], /NO_TOOLBAR, LOCATION = [0, 0], BACKGROUND_COLOR = backgroundColor, WINDOW_TITLE = 'Serial Monitors')

t =         text(0.4, 0.95, 'ESP', FONT_SIZE = fontSize + 6, FONT_COLOR = blueColor)
t =         text(0.6, topLinePosition, 'ESP FPGA Time = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_time =   text(0.6 + textHSpacing, topLinePosition, '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (1 * textVSpacing), 'Record Counter = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_cnt =    text(0.6 + textHSpacing, topLinePosition - (1 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (2 * textVSpacing), 'Diode 1 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp1 =   text(0.6 + textHSpacing, topLinePosition - (2 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (3 * textVSpacing), 'Diode 2 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp2 =   text(0.6 + textHSpacing, topLinePosition - (3 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (4 * textVSpacing), 'Diode 3 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp3 =   text(0.6 + textHSpacing, topLinePosition - (4 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (5 * textVSpacing), 'Diode 4 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp4 =   text(0.6 + textHSpacing, topLinePosition - (5 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (6 * textVSpacing), 'Diode 5 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp5 =   text(0.6 + textHSpacing, topLinePosition - (6 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (7 * textVSpacing), 'Diode 6 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp6 =   text(0.6 + textHSpacing, topLinePosition - (7 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (8 * textVSpacing), 'Diode 7 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp7 =   text(0.6 + textHSpacing, topLinePosition - (8 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (9 * textVSpacing), 'Diode 8 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp8 =   text(0.6 + textHSpacing, topLinePosition - (9 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (10 * textVSpacing), 'Diode 9 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s3_esp9 =   text(0.6 + textHSpacing, topLinePosition - (10 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.4, topLinePosition - (11 * textVSpacing), 'MEGS-P', FONT_SIZE = fontSize + 6, FONT_COLOR = blueColor)
t =         text(0.6, topLinePosition-(12 * textVSpacing), 'MEGS-P FPGA Time = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s4_time =   text(0.6 + textHSpacing, topLinePosition-(12 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (13 * textVSpacing), 'Diode 1 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s4_megsp1 = text(0.6 + textHSpacing, topLinePosition - (13 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =         text(0.6, topLinePosition - (14 * textVSpacing), 'Diode 2 = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
s4_megsp2 = text(0.6 + textHSpacing, topLinePosition - (14 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
monitorsSerialRefreshText = text(1.0, 0.0, 'Last full refresh: ' + JPMsystime(), COLOR = blueColor, ALIGNMENT = 1.0,font_size=14)

; Analog monitor window
; Displays limit checked hk
wa = window(DIMENSIONS = [1000, 750], /NO_TOOLBAR, LOCATION = [406, 0], BACKGROUND_COLOR = backgroundColor, WINDOW_TITLE = 'EVE Rocket 36.336 Analog Monitors')

; Left column
t =     text(0.25, 0.95, 'Payload', FONT_SIZE = fontSize + 6, FONT_COLOR = blueColor)
t =     text(0.35, topLinePosition, 'Exp +28V Monitor = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta23 =  text(0.35 + textHSpacing, topLinePosition, '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)

t =     text(0.35, topLinePosition - (1 * textVSpacing), 'TM Exp Batt Volt [V] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta124 = text(0.35 + textHSpacing, topLinePosition - (1 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (2 * textVSpacing), 'TM Exp Bus Curr [A] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta106 = text(0.35 + textHSpacing, topLinePosition - (2 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (4 * textVSpacing), 'Shutter Door = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta82 =  text(0.35 + textHSpacing, topLinePosition - (4 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (5 * textVSpacing), 'Vac Valve Position = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta25 =  text(0.35 + textHSpacing, topLinePosition - (5 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (6 * textVSpacing), 'HVS Pressure = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta26 =  text(0.35 + textHSpacing, topLinePosition - (6 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (7 * textVSpacing), 'Solar Section Pressure = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta13 =  text(0.35 + textHSpacing, topLinePosition - (7 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (9 * textVSpacing), 'Cryo Cold Finger Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta14 =  text(0.35 + textHSpacing, topLinePosition - (9 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (10 * textVSpacing), 'Cryo Hot Side Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta22 =  text(0.35 + textHSpacing, topLinePosition - (10 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (12 * textVSpacing), 'FPGA +5V Monitor [V] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta29 =  text(0.35 + textHSpacing, topLinePosition - (12 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.35, topLinePosition - (13 * textVSpacing), 'Camera Charger [V] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta30 =  text(0.35 + textHSpacing, topLinePosition - (13 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)

; Right column
t =     text(0.75, 0.95, 'MEGS', FONT_SIZE = fontSize + 6, FONT_COLOR = blueColor)
t =     text(0.8, topLinePosition, 'MEGS A Heater = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta3 =   text(0.8 + textHSpacing, topLinePosition, '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (1 * textVSpacing), 'MEGS B Heater = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta15 =  text(0.8 + textHSpacing, topLinePosition - (1 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (2 * textVSpacing), 'MEGS A CCD Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta19 =  text(0.8 + textHSpacing, topLinePosition - (2 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (3 * textVSpacing), 'MEGS B CCD Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta20 =  text(0.8 + textHSpacing, topLinePosition - (3 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (5 * textVSpacing), 'MEGS A FF Lamp = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta31 =  text(0.8 + textHSpacing, topLinePosition - (5 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (6 * textVSpacing), 'MEGS B FF Lamp = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta32 =  text(0.8 + textHSpacing, topLinePosition - (6 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
t =     text(0.8, topLinePosition - (8 * textVSpacing), 'MEGS-P Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = fontSize, FONT_COLOR = fontColor)
ta1 =   text(0.8 + textHSpacing, topLinePosition - (8 * textVSpacing), '--', FONT_SIZE = fontSize, FONT_COLOR = fontColor)
monitorsRefreshText = text(1.0, 0.0, 'Last full refresh: ' + JPMsystime(), COLOR = blueColor, ALIGNMENT = 1.0,font_size=14)
counter=0

;w = window(DIMENSIONS = windowSize, /DEVICE, LOCATION = [1415, 0], WINDOW_TITLE = 'EVE Rocket 36.336 ESP/MEGSP Science Data', BACKGROUND_COLOR = backgroundColor)
;p1 = plot(findgen(10), sin(findgen(10)), COLOR = orangeColor, '2*-', LAYOUT=[1,2,1], /CURRENT, FONT_COLOR = fontColor, $
;  TITLE = 'MEGSP', $
;  XTITLE = 'Data Packet', XCOLOR = fontColor, $
;  YTITLE = 'Intensity [DN]', YCOLOR = fontColor, $
;  NAME = 'NULL')
;p1a = plot(findgen(10), sin(findgen(10)), COLOR = orangeColor, '2*-', /OVERPLOT, $
;    NAME = 'MEGS Diode 1')
;p1b = plot(findgen(10), sin(findgen(10) + 0.3), COLOR = blueColor, '2*-', /OVERPLOT, $
;  NAME = 'MEGS Diode 2')
;t1a = text(0.0, -0.3, 'MEGSP FPGA Time = --', /RELATIVE, TARGET = p1, FONT_COLOR = fontColor)
;
;p2 = plot(findgen(10), tan(findgen(10)), COLOR = orangeColor, '2*-', /CURRENT, LAYOUT = [1, 2, 2], FONT_COLOR = fontColor, $
;  TITLE = 'ESP', $
;  YTITLE = 'Intensity [DN]', YCOLOR = fontColor, $
;  XTITLE = 'Data Packet', XCOLOR = fontColor, $
;  NAME = 'NULL')
;p2a = plot(findgen(10), tan(findgen(10)), COLOR = orangeColor, '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 1') 
;p2b = plot(findgen(10), tan(findgen(10) + 0.1), COLOR = blueColor, '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 2')
;p2c = plot(findgen(10), tan(findgen(10) + 0.2), COLOR = greenColor, '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 3')
;p2d = plot(findgen(10), tan(findgen(10) + 0.3), COLOR = greenColor, '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 4')
;p2e = plot(findgen(10), tan(findgen(10) + 0.4), COLOR = 'white', '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 5')
;p2f = plot(findgen(10), tan(findgen(10) - 0.1), COLOR = 'pink', '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 6')
;p2g = plot(findgen(10), tan(findgen(10) - 0.2), COLOR = 'purple', '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 7')
;p2h = plot(findgen(10), tan(findgen(10) - 0.3), COLOR = 'red', '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 8')
;p2i = plot(findgen(10), tan(findgen(10) - 0.4), COLOR = 'yellow', '2*-', /OVERPLOT, $
;  NAME = 'ESP Diode 9')
;t2a = text(0.0, -0.3, 'ESP FPGA Time = --', /RELATIVE, TARGET = p2a, FONT_COLOR = fontColor)
;t2b = text(1.0, -0.3, 'ESP Record Counter = --', /RELATIVE, ALIGNMENT = 1.0, TARGET = p2, FONT_COLOR = fontColor)

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
    print,strtrim(systime(),2)+' bytes read = '+strtrim(n_elements(socketData),2)
    
    ; Stuff the new socketData into the buffer. This will work even the first time around when the buffer is !NULL. 
    socketDataBuffer = [temporary(socketDataBuffer), temporary(socketData)]
    
    ; Do an efficient search for just the last DEWESoft sync byte
    sync7Indices = where(socketDataBuffer EQ 7, numSync7s)
    
    ; If some 0x07 sync bytes were found, THEN loop to verify the rest of the sync byte pattern (0x00 0x01 0x02 0x03 0x04 0x05 0x06)
    ; and process the data between every set of two verified sync byte patterns
    IF numSync7s GE 2 THEN BEGIN
      
      ; Reset the index of the verified sync patterns
      verifiedSync7Index = !NULL
      
      FOR sync7LoopIndex = 0, numSync7s - 1 DO BEGIN
        
        ; Verify the rest of the sync pattern
        IF sync7Indices[0] LT 7 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 1] NE 6 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 2] NE 5 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 3] NE 4 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 4] NE 3 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 5] NE 2 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 6] NE 1 THEN CONTINUE
        IF socketDataBuffer[sync7Indices[sync7LoopIndex] - 7] NE 0 THEN CONTINUE
        
        ; If this is the first syncLoopIndex, THEN verify this sync pattern and continue to the next sync pattern to determine 
        ; the data to process (singleFullDeweSoftPacket) between the two sync patterns
        IF sync7LoopIndex EQ 0 THEN BEGIN
          verifiedSync7Index = sync7Indices[sync7LoopIndex]
          CONTINUE
        ENDIF
        
        ; Store the data to be processed between two DEWESoft sync patterns
        singleFullDeweSoftPacket = socketDataBuffer[verifiedSync7Index - 7:sync7Indices[sync7LoopIndex] - 8]
        
        ; Check if packet type is 0 (i.e. a data packet) ELSE skip
        packetType = byte2ulong(singleFullDeweSoftPacket[12:12+3])
        IF packetType NE 0 THEN BEGIN
          IF keyword_set(debug) THEN print, "Skipping as datatype is ", packetType
          verifiedSync7Index = sync7Indices[sync7LoopIndex]
          CONTINUE
        ENDIF
        
        counter++
        IF counter GT 10 THEN BEGIN
          counter=0
        
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
            ENDIF ELSE BEGIN
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
                                                     stale_a, stale_s, sdoor_state,sdoor_history)
        
        ; Convert voltages to temperature for the 36.336 flight
        ; TODO: move these to a seperate function
        R_therm_MEGSP = woods14[1]/((woods14[0]/(analogMonitors.megsp_temp))-(woods14[1]/woods14[2])-1)*1000
        t_MEGSP = 1/(woods7[0]+woods7[1]*alog(R_therm_MEGSP)+woods7[2]*((alog(R_therm_MEGSP))^3))-273.15
        
        R_therm_XRS1 = woods15[1]/((woods15[0]/(analogMonitors.xrs_temp))-(woods15[1]/woods15[2])-1)*1000
        t_XRS1 = 1/(woods6[0]+woods6[1]*alog(R_therm_XRS1)+woods6[2]*((alog(R_therm_XRS1))^3))-273.15
        
        R_therm_Cryo_Hotside = woods11[1]/((woods11[0]/(analogMonitors.cryo_hot))-(woods11[1]/woods11[2])-1)*1000
        t_Cryo_Hotside = 1/(woods5[0]+woods5[1]*alog(R_therm_Cryo_Hotside)+woods5[2]*((alog(R_therm_Cryo_Hotside))^3))-273.15
        
        v_convert_ = woods8[2]*(analogMonitors.cryo_cold)^2+woods8[1]*(analogMonitors.cryo_cold)+woods8[0]
        t_Cold_Finger = woods17[0]*v_convert_+woods17[1]
        
        megsa_ccd = 34.5*analogMonitors.megsa_ccd_temp-143
        megsb_ccd = 34.45*analogMonitors.megsb_ccd_temp-156
        
        ; Write data to file if its new
        IF stale_a EQ 0 THEN BEGIN
          printf, file_lun, string(systime(/julian),format='(F32.16)')+', '+jpmprintnumber(analogMonitors.megsp_temp)+', '+jpmprintnumber(analogMonitors.megsa_htr)+', '+jpmprintnumber(analogMonitors.xrs_5v)+$
                           ', '+jpmprintnumber(analogMonitors.slr_pressure)+', '+jpmprintnumber(analogMonitors.cryo_cold)+', '+jpmprintnumber(analogMonitors.megsb_htr)+$
                           ', '+jpmprintnumber(analogMonitors.xrs_temp)+', '+jpmprintnumber(analogMonitors.megsa_ccd_temp)+', '+jpmprintnumber(analogMonitors.megsb_ccd_temp)+', '+jpmprintnumber(analogMonitors.cryo_hot)+$
                           ', '+jpmprintnumber(analogMonitors.exprt_28v)+', '+jpmprintnumber(analogMonitors.vac_valve_pos)+', '+jpmprintnumber(analogMonitors.hvs_pressure)+', '+jpmprintnumber(analogMonitors.exprt_15v)+$
                           ', '+jpmprintnumber(analogMonitors.fpga_5v)+', '+jpmprintnumber(analogMonitors.tv_12v)+', '+jpmprintnumber(analogMonitors.megsa_ff_led)+', '+jpmprintnumber(analogMonitors.megsb_ff_led)+', '+jpmprintnumber(analogMonitors.sdoor_oc)+$
                           ', '+jpmprintnumber(analogMonitors.exprt_bus_cur)+', '+jpmprintnumber(analogMonitors.exprt_main_28v)+', '+jpmprintnumber(analogMonitors.esp_fpga_time)+', '+jpmprintnumber(analogMonitors.esp_rec_counter)+$
                           ', '+jpmprintnumber(analogMonitors.esp1)+', '+jpmprintnumber(analogMonitors.esp2)+', '+jpmprintnumber(analogMonitors.esp3)+', '+jpmprintnumber(analogMonitors.esp4)+$
                           ', '+jpmprintnumber(analogMonitors.esp5)+', '+jpmprintnumber(analogMonitors.esp6)+', '+jpmprintnumber(analogMonitors.esp7)+', '+jpmprintnumber(analogMonitors.esp8)+$
                           ', '+jpmprintnumber(analogMonitors.esp9)+', '+jpmprintnumber(analogMonitors.megsp_fpga_time)+', '+jpmprintnumber(analogMonitors.megsp1)+', '+jpmprintnumber(analogMonitors.megsp2)
        ENDIF
        
        ;save diode data for plotting
;        if stale_s EQ 0 THEN BEGIN
;          esp_d1=[esp_d1,analogMonitors.esp1]
;          esp_d2=[esp_d2,analogMonitors.esp2]
;          esp_d3=[esp_d3,analogMonitors.esp3]
;          esp_d4=[esp_d4,analogMonitors.esp4]
;          esp_d5=[esp_d5,analogMonitors.esp5]
;          esp_d6=[esp_d6,analogMonitors.esp6]
;          esp_d7=[esp_d7,analogMonitors.esp7]
;          esp_d8=[esp_d8,analogMonitors.esp8]
;          esp_d9=[esp_d9,analogMonitors.esp9]
;          megsp_d1=[megsp_d1,analogMonitors.megsp1]
;          megsp_d2=[megsp_d2,analogMonitors.megsp2] 
;        ENDIF   
;         
;        ; -= UPDATE PLOT WINDOWS WITH REASONABLE REFRESH RATE =- ;
;        !Except = 0 ; Disable annoying divide by 0 messages
;        ;plot the last 10 valid esp and megs readings
;        if n_elements(megsp_d1) GT 10 THEN BEGIN
;          p1a.setdata,megsp_d1[n_elements(megsp_d1)-1-10:n_elements(megsp_d1)-1]
;          p1b.setdata,megsp_d2[n_elements(megsp_d2)-1-10:n_elements(megsp_d2)-1]
;          
;          p2a.setdata,esp_d1[n_elements(esp_d1)-1-10:n_elements(esp_d1)-1]
;          p2b.setdata,esp_d2[n_elements(esp_d2)-1-10:n_elements(esp_d2)-1]
;          p2c.setdata,esp_d3[n_elements(esp_d3)-1-10:n_elements(esp_d3)-1]
;          p2d.setdata,esp_d4[n_elements(esp_d4)-1-10:n_elements(esp_d4)-1]
;          p2e.setdata,esp_d5[n_elements(esp_d5)-1-10:n_elements(esp_d5)-1]
;          p2f.setdata,esp_d6[n_elements(esp_d6)-1-10:n_elements(esp_d6)-1]
;          p2g.setdata,esp_d7[n_elements(esp_d7)-1-10:n_elements(esp_d7)-1]
;          p2h.setdata,esp_d8[n_elements(esp_d8)-1-10:n_elements(esp_d8)-1]
;          p2i.setdata,esp_d9[n_elements(esp_d9)-1-10:n_elements(esp_d9)-1]
;        ENDIF
;        t1a.string='MEGSP FPGA Time = '+jpmprintnumber(analogMonitors.megsp_fpga_time)
;        t2a.string='ESP FPGA Time = '+jpmprintnumber(analogMonitors.esp_fpga_time)
;        t2b.string='ESP Record Counter = '+jpmprintnumber(analogMonitors.esp_rec_counter)
        
        ; We continually update the display as, even if we don't get a new valid Dewesoft packet, the valid data is still in the monitor struct
        ; Window 1 display
        wtime = tic()
        ta23.string = jpmprintnumber(analogMonitors.exprt_28v)
        ta124.string = jpmprintnumber(analogMonitors.exprt_main_28v)
        ta106.string = jpmprintnumber(analogMonitors.exprt_bus_cur)
        ta13.string = jpmprintnumber(analogMonitors.slr_pressure)
        ta14.string = jpmprintnumber(t_Cold_Finger)
        ta29.string = jpmprintnumber(analogMonitors.fpga_5v)
        ta30.string = jpmprintnumber(analogMonitors.tv_12v)
        ta19.string = jpmprintnumber(megsa_ccd)+" ("+jpmprintnumber(analogMonitors.megsa_ccd_temp)+")"
        ta20.string = jpmprintnumber(megsb_ccd)+" ("+jpmprintnumber(analogMonitors.megsb_ccd_temp)+")"
        ta1.string = jpmprintnumber(t_MEGSP)
        ta26.string = jpmprintnumber(analogMonitors.hvs_pressure)
        ta22.string = jpmprintnumber(t_Cryo_Hotside)
        ;ta82.string = jpmprintnumber(analogMonitors.sdoor_oc)
        
        ; Window 0 display
        s3_time.string = jpmprintnumber(analogMonitors.esp_fpga_time)
        s3_cnt.string = jpmprintnumber(analogMonitors.esp_rec_counter)
        s3_esp1.string = jpmprintnumber(analogMonitors.esp1)
        s3_esp2.string = jpmprintnumber(analogMonitors.esp2)
        s3_esp3.string = jpmprintnumber(analogMonitors.esp3)
        s3_esp4.string = jpmprintnumber(analogMonitors.esp4)
        s3_esp5.string = jpmprintnumber(analogMonitors.esp5)
        s3_esp6.string = jpmprintnumber(analogMonitors.esp6)
        s3_esp7.string = jpmprintnumber(analogMonitors.esp7)
        s3_esp8.string = jpmprintnumber(analogMonitors.esp8)
        s3_esp9.string = jpmprintnumber(analogMonitors.esp9)
        s4_time.string = jpmprintnumber(analogMonitors.megsp_fpga_time)
        s4_megsp1.string = jpmprintnumber(analogMonitors.megsp1)
        s4_megsp2.string = jpmprintnumber(analogMonitors.megsp2)
        
        ; -= LIMIT CHECKING =- ;
        
        ; Sets the refresh text at the bottom of the analog window to purple if we get 20 invalid dewesoft packets
        IF (stale_a GT 20) THEN BEGIN       
          monitorsRefreshText.font_color = 'purple'
          ta23.font_color = 'purple'
          ta124.font_color = 'purple'
          ta106.font_color = 'purple'
          ta82.font_color = 'purple'
          ta25.font_color = 'purple'
          ta26.font_color = 'purple'
          ta13.font_color = 'purple'
          ta14.font_color = 'purple'
          ta22.font_color = 'purple'
          ta29.font_color = 'purple'
          ta30.font_color = 'purple'
          ta3.font_color = 'purple'
          ta15.font_color = 'purple'
          ta19.font_color = 'purple'
          ta20.font_color = 'purple'
          ta31.font_color = 'purple'
          ta32.font_color = 'purple'
          ta1.font_color = 'purple'
        ENDIF ELSE BEGIN
          monitorsRefreshText.font_color = bluecolor
          IF (analogMonitors.megsa_htr LE -1 or analogMonitors.megsa_htr GE 0.2) THEN BEGIN
            ta3.string = 'Heater ON ('+jpmprintnumber(analogMonitors.megsa_htr)+')'
            ta3.font_color=redcolor
          ENDIF ELSE BEGIN
            ta3.string = 'Heater OFF('+jpmprintnumber(analogMonitors.megsa_htr)+')'
            ta3.font_color=greencolor
          ENDELSE

          IF (analogMonitors.megsb_htr LE -1 or analogMonitors.megsb_htr GE 0.2) THEN BEGIN
            ta15.string = 'Heater ON ('+jpmprintnumber(analogMonitors.megsb_htr)+')'
            ta15.font_color=redcolor
          ENDIF ELSE BEGIN
            ta15.string = 'Heater OFF ('+jpmprintnumber(analogMonitors.megsb_htr)+')'
            ta15.font_color=greencolor
          ENDELSE

          
          IF (analogMonitors.exprt_28v LE 1) then BEGIN
            ta124.font_color=redcolor
          ENDIF ELSE BEGIN
            IF (analogMonitors.exprt_28v GE 22 and analogMonitors.exprt_28v LE 35) then begin 
              ta124.font_color=greencolor
            endif else begin
                ta124.font_color='yellow'
            endelse
          ENDELSE

          IF ((analogMonitors.vac_valve_pos LE 0.2 and analogMonitors.vac_valve_pos GT -1) or (analogMonitors.vac_valve_pos GE 3.3 and analogMonitors.vac_valve_pos lt 3.6)) THEN BEGIN
            ta25.font_color='yellow'
            ta25.string="Moving ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDIF ELSE IF (analogMonitors.vac_valve_pos LE -1 or analogMonitors.vac_valve_pos GE 3.6) THEN BEGIN
            ta25.font_color=redcolor
            ta25.string="Open ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDIF ELSE BEGIN
            ta25.font_color=greencolor
            ta25.string="Closed ("+jpmprintnumber(analogMonitors.vac_valve_pos)+")"
          ENDELSE

          IF (analogMonitors.fpga_5v LE 4.5 or analogMonitors.fpga_5v GE 5.5) THEN BEGIN
            ta29.font_color=redcolor
          ENDIF ELSE BEGIN
            ta29.font_color=greencolor
          ENDELSE

          IF (analogMonitors.megsa_ff_led LE .15) THEN BEGIN
            ta31.font_color=greencolor
            ta31.string = "OFF ("+jpmprintnumber(analogMonitors.megsa_ff_led)+")"
          ENDIF ELSE IF (analogMonitors.megsa_ff_led GE .2) THEN BEGIN
            ta31.font_color=redcolor
            ta31.string = "ON ("+jpmprintnumber(analogMonitors.megsa_ff_led)+")"
          ENDIF ELSE BEGIN
            ta31.font_color=redcolor
            ta31.string = "UNKNOWN ("+jpmprintnumber(analogMonitors.megsa_ff_led)+")"
          ENDELSE

          IF (analogMonitors.megsb_ff_led LE .15) THEN BEGIN
            ta32.font_color=greencolor
            ta32.string = "OFF ("+jpmprintnumber(analogMonitors.megsb_ff_led)+")"
          ENDIF ELSE IF (analogMonitors.megsb_ff_led GE .2) THEN BEGIN
            ta32.font_color=redcolor
            ta32.string = "ON ("+jpmprintnumber(analogMonitors.megsb_ff_led)+")"
          ENDIF ELSE BEGIN
            ta32.font_color=redcolor
            ta32.string = "UNKNOWN ("+jpmprintnumber(analogMonitors.megsb_ff_led)+")"
          ENDELSE

          IF sdoor_state EQ "Closed" THEN BEGIN
            ta82.font_color=redcolor
            ta82.string = "Closed ("+jpmprintnumber(analogMonitors.sdoor_oc)+")"
          ENDIF ELSE IF sdoor_state EQ "Open" THEN BEGIN
            ta82.font_color=greencolor
            ta82.string = "Open ("+jpmprintnumber(analogMonitors.sdoor_oc)+")"
          ENDIF ELSE BEGIN
            ta82.font_color=redcolor
            ta82.string = "UNKNOWN ("+jpmprintnumber(analogMonitors.sdoor_oc)+")"
          ENDELSE

          IF (analogMonitors.exprt_bus_cur LE .9 or analogMonitors.exprt_bus_cur GE 2) THEN BEGIN
            ta106.font_color=redcolor
          ENDIF ELSE BEGIN
            ta106.font_color=greencolor
          ENDELSE

          IF (analogMonitors.exprt_28v LE 1) THEN BEGIN
            ta124.font_color=greencolor
          ENDIF ELSE BEGIN
            IF (analogMonitors.exprt_28v GE 22 and analogMonitors.exprt_28v LE 35) then begin
              ta124.font_color=redcolor
            endif else begin
              ta124.font_color='yellow'
            endelse
          ENDELSE
        ENDELSE
    
        ; Sets the refresh text at the bottom of the serial window to purple if we get 20 invalid dewesoft packets
        IF (stale_s GT 20) THEN BEGIN
          monitorsSerialRefreshText.font_color = 'purple'
          s3_time.font_color='purple'    
          s3_cnt.font_color='purple'
          s3_esp1.font_color='purple'
          s3_esp2.font_color='purple'
          s3_esp3.font_color='purple'
          s3_esp4.font_color='purple'
          s3_esp5.font_color='purple'
          s3_esp6.font_color='purple'
          s3_esp7.font_color='purple'
          s3_esp8.font_color='purple'
          s3_esp9.font_color='purple'
          s4_time.font_color='purple'
          s4_megsp1.font_color='purple'
          s4_megsp2.font_color='purple'
        ENDIF ELSE BEGIN
          monitorsSerialRefreshText.font_color = bluecolor
          s3_time.font_color=fontColor
          s3_cnt.font_color=fontColor
          s3_esp1.font_color=fontColor
          s3_esp2.font_color=fontColor
          s3_esp3.font_color=fontColor
          s3_esp4.font_color=fontColor
          s3_esp5.font_color=fontColor
          s3_esp6.font_color=fontColor
          s3_esp7.font_color=fontColor
          s3_esp8.font_color=fontColor
          s3_esp9.font_color=fontColor
          s4_time.font_color=fontColor
          s4_megsp1.font_color=fontColor
          s4_megsp2.font_color=fontColor
        ENDELSE
        print,'window write time = '+strtrim(toc(wtime),2)
          
        !Except = 1 ; Re-enable math error logging
        
        ; Set the index of this verified sync pattern for use in the next iteration of the DEWESoft sync7Loop
        verifiedSync7Index = sync7Indices[sync7LoopIndex]
      ENDIF
      ENDFOR ; sync7LoopIndex = 0, numSync7s - 1
      
      ; Now that all processable data has been processed, overwrite the buffer to contain only bytes from the beginning of 
      ; last sync pattern to the end of socketDataBuffer
      socketDataBuffer = socketDataBuffer[verifiedSync7Index - 7:-1]
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
free_lun,file_lun

END