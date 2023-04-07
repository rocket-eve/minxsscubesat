function define_analog_monitor_structure

  ; old def just had values
  oldanalogMonitorsStructure = {megsp_temp: 0.0, megsa_htr: 0.0, xrs_5v:0.0,$
                                slr_pressure:0.0,cryo_cold:0.0,megsb_htr:0.0,xrs_temp:0.0,$
                                megsa_ccd_temp:0.0,megsb_ccd_temp:0.0,cryo_hot:0.0,exprt_28v:0.0,$
                                vac_valve_pos:0.0,hvs_pressure:0.0,exprt_15v:0.0,fpga_5v:0.0,$
                                tv_12v:0.0,megsa_ff_led:0.0,megsb_ff_led:0.0,sdoor_pos:0.0,$
                                exprt_bus_cur:0.0,tm_exp_batt_volt:0.0,esp_fpga_time:0.0,esp_rec_counter:0.0,$
                                esp1:0.0,esp2:0.0,esp3:0.0,esp4:0.0,esp5:0.0,esp6:0.0,esp7:0.0,esp8:0.0,esp9:0.0,$
                                megsp_fpga_time:0.0,megsp1:0.0,megsp2:0.0}

  record = {ch:'', label:'',description:'', word:0L, display_name:'', value:0.0, conv_factor:5./1023., conv_offset:0. }
  
  ; conv_factor and conv_offset are used in rocket_eve_tm1_read_packets.pro
  ; ch = dewesoft channel e.g. "A97"
  ; label = dewsoft label e.g. "MEGSP_TEMP"
  ; description = dewsoft Analog Deck  e.g. "MEGS P Temperature"
  ; 

  dewesoft = read_altair_ch_descriptions()
  stop
  return, analogMonitorStructure
end
