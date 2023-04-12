;+
; This function provides a way to use thevarname from the csv file to
; set the conversion factor and offset for TM1 analog telemetry.
; This is only called during initialization for each analog telemetry
; item that needs to be converted.
;
; :Params:
;    dewesoft: in, required, type=array of structures
;     This is the structure defined analogously to the
;     analogMonitorsStructure. It contains all the string name info to
;     identify each element in the TM1 data that could be requested
;     from the Dewesoft program on the Altair computer.
;   thisvarname: in, required, type=string
;     This is the string corresponding to the dewesoft varname tag
;     that the conversion coefficients should be applied to.
;   conv_factor: in, required, type=float
;     The slope of the linear conversion from DN to volts. Usually
;     this is 5./1023.
;   conv_offset: in, required, type=float
;     The offset of the linear conversion from DN to volts. Usually
;     this is 0.      
;
; :Returns:
;   This function returns the same array of structures that is passed
;   in as the first argument with the conversion info updated.
;
; :Example:
;   ::
;     IDL> new = populate_analog_tmconv( new, 'XRS_5V_Raw', 2.*tenbit_to_5v, 0. )
;
;   The example shows how to call this function. The first arg is the
;   dewesoft structure from the text file. The second is a string used
;   to identify the index in the dewesoft structure comparing against
;   the varname tag. It no match is found it tries the tmdescription
;   tag from the excel telemetry file converted to a csv.
;
;-
function populate_analog_tmconv, dewesoft, thisvarname, conv_factor, conv_offset
  
  ; the string matches method fails for variable names that contain + character
  ; use logical eq instead
  idx=where(dewesoft.varname eq thisvarname, n_found)
  if n_found ne 1 then begin
     ; try tmdescription instead
     idx=where(dewesoft.tmdescription eq thisvarname, n_found)
     if n_found ne 1 then begin
        print,'ERROR: populate_analog_tmconv - cannot locate variablename '+thisvarname
        stop
     endif
  endif
  dewesoft[idx].conv_factor = conv_factor
  dewesoft[idx].conv_offset = conv_offset
  return, dewesoft
end

;+
; This function stores the TM1 analog conversions from raw DN to
; volts using linear coefficients (conv_factor and
; conv_offset). Elements in the dewesoft structure that are not
; expressly listed in this function are converted using a slope of 1
; and an offset of 0 (default).
;
; This replaces some of the array to array coordination in
; rocket_eve_tm1_read_packets.pro that is tricky to maintain for each
; rocket. 
;
;
; :Params:
;   dewesoft: in, required, type=array of structures
;     This is the structure defined analogously to the
;     analogMonitorsStructure. It contains all the string name info to
;     identify each element in the TM1 data that could be requested
;     from the Dewesoft program on the Altair computer.
;
; :Returns:
;    The identical structure is returned that has the conv_factor and
;    conv_offset variables populated.
;
;
;-
function insert_analog_conversions, dewesoft

  new = dewesoft

  tenbit_to_5v = 5./1023. ; 0.00488759
  ; default multiplicative conversion is 1.0
  ; default additive offset is 0.0
  ; change the items we know have different conversions

  ; it is convenient to have the docs open
  ; the varnames can also be viewed using something like
  ; this IDL> for i=0,155  do print,strtrim(dewesoft[i].ch,2),',',dewesoft[i].ach,',',dewesoft[i].varname,',',dewesoft[i].tmdescription

  ; most likely cases
  varnames5v = ['MEGSP_TEMP_Raw', $
                'MAHEAT_28V_Raw', $
                'SOLAR_PSI_Raw', $
                'CRYO_COLD_Raw', $
                'MBHEAT_28V_Raw', $
                'XRS_TEMP_1_Raw', $
                'MACCD_TEMP_1_Raw', $ ; PRT
                'MBCCD_TEMP_1_Raw', $ ; PRT
                'MACCD_TEMP_2_Raw', $ ; DIODE
                'MBCCD_TEMP_2_Raw', $ ; DIODE
                'CRYO_HOT_Raw', $
                'VAC_POS_Raw', $
                'HVS_PSI_Raw',$
                'TV_12V_Raw', $
                'MA_FF_LED_Raw', $
                'MB_FF_LED_Raw' ]

  foreach thisvarname, varnames5v do new = populate_analog_tmconv( new, thisvarname, tenbit_to_5v, 0. )

  ;
  ; special cases
  ;
  new = populate_analog_tmconv( new, 'XRS_5V_Raw', 2.*tenbit_to_5v, 0. )

  new = populate_analog_tmconv( new, 'BUS_28V_Raw', 10.*tenbit_to_5v, 0. )

  new = populate_analog_tmconv( new, 'EXP_15V_Raw', 0.05, 0. )

  new = populate_analog_tmconv( new, 'FPGA_5V_Raw', 0.055, 0. )

  new = populate_analog_tmconv( new, 'SD_POS_Raw', 1.0, 0. )

  new = populate_analog_tmconv( new, 'EXP_I_Raw', 0.0049, 0.09566 )
  
  new = populate_analog_tmconv( new, 'EXBUS_Mon_Raw', 0.01205, 22.0 )
  
  return, new
end


;+
; The order of this structure matters for rocket_eve_tm1_read_packets.pro
; because conversions are applied to the structure tag index order.
;
; Build conversions into the definition instead.
;
;-
function define_analog_monitor_structure

  ; old def just had values
  oldanalogMonitorsStructure = {megsp_temp: 0.0, megsa_htr: 0.0, xrs_5v:0.0,$
                                slr_pressure:0.0,cryo_cold:0.0,megsb_htr:0.0,xrs_temp:0.0,$
                                megsa_ccd_temp:0.0,megsb_ccd_temp:0.0,cryo_hot:0.0,exprt_28v:0.0,$
                                vac_valve_pos:0.0,hvs_pressure:0.0,   exprt_15v:0.0,fpga_5v:0.0,$
                                tv_12v:0.0,megsa_ff_led:0.0,megsb_ff_led:0.0,sdoor_pos:0.0,$
                                exprt_bus_cur:0.0,tm_exp_batt_volt:0.0,esp_fpga_time:0.0,esp_rec_counter:0.0,$
                                esp1:0.0,esp2:0.0,esp3:0.0,esp4:0.0,esp5:0.0,esp6:0.0,esp7:0.0,esp8:0.0,esp9:0.0,$
                                megsp_fpga_time:0.0,megsp1:0.0,megsp2:0.0}
  
  ; conv_factor and conv_offset are used in rocket_eve_tm1_read_packets.pro
  ; ch = dewesoft channel e.g. "A97"
  ; label = dewsoft label e.g. "MEGSP_TEMP"
  ; description = dewsoft Analog Deck  e.g. "MEGS P Temperature"
  ; 

  dewesoft = read_altair_ch_descriptions()

  ; apply conversions for analog tlm
  analogMonitorsStructure = insert_analog_conversions( dewesoft )

  ; assign isanalog to 1 for analog monitors that come from analog decks
  ; megsp and esp serial data will have isanalog=0
  analogs=where(strmid(analogMonitorsStructure.ach,0,1) eq 'A')
  analogMonitorsStructure[analogs].isanalog = 1
  
  
  ; define the order here and chop out stuff we don't want
  ; use help
  ; stop

  ; items displayed on serial monitors window
  ; esp_fpga time, record counter, diode 1, 2, 3, 4, 5, 6, 7, 8, 9,
  ; megsp_fpga_time, diode 1, 2

  ; items displayed on analog monitors window
  ; esp+28vMonitor, TMExpBattVolt, TMExpBusCurr, ShutterDoor, VacValvePosition,
  ; col1 is HVSPressure, SolarSectionPressure, CryoColdTemp,CryoHotTemp, FPGA+5vMon,
  ; cameraCharger
  ; col2 is maHeater,mbHeater,maPRTTemp,mbPRTTemp,maDoideTemp,mbDiodeTemp,
  ; maFFLamp, mbFFLamp, mpTemp
  ;ch_keep = ['']
  ;keep = []
  ;analogMonitorsStructure = analogMonitorsStructure[keep]

  ;stop
  return, analogMonitorsStructure
end
