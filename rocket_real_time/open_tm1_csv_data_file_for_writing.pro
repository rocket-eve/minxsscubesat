pro open_tm1_csv_data_file_for_writing, file_lun

  csv_file = getenv('HOME') + '/Dropbox/minxss_dropbox/data/reve_36_389/tm1_files/rocket_analog_monitors_' + strjoin(strsplit(jpmsystime(), ' :', /EXTRACT), '_')+'.csv'

  openw, file_lun, csv_file, /GET_LUN

  printf,file_lun,'Time, megsp_temp, megsa_htr, xrs_5v, slr_pressure, '+$
         'cryo_cold, megsb_htr, xrs_temp, megsa_ccd_temp1, megsb_ccd_temp1,megsa_ccd_temp2, megsb_ccd_temp2, cryo_hot, exprt_28v, '+$
         'vac_valve_pos, hvs_pressure, exprt_15v, fpga_5v, tv_12v, megsa_ff_led, megsb_ff_led, '+$
         'sdoor_pos, exprt_bus_cur, tm_exp_batt_volt, esp_fpga_time, esp_rec_counter, esp1, esp2, esp3, esp4, '+$
         'esp5, esp6, esp7, esp8, esp9, megsp_fpga_time, megsp1, megsp2'

  return
end
