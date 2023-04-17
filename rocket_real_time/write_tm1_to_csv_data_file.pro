pro write_tm1_to_csv_data_file, file_lun, analogMonitors

  printf, file_lun, string(systime(/julian),format='(F32.16)')+', '+jpmprintnumber(analogMonitors.megsp_temp)+', '+jpmprintnumber(analogMonitors.megsa_htr)+', '+jpmprintnumber(analogMonitors.xrs_5v)+$
          ', '+jpmprintnumber(analogMonitors.slr_pressure)+', '+jpmprintnumber(analogMonitors.cryo_cold)+', '+jpmprintnumber(analogMonitors.megsb_htr)+$
          ', '+jpmprintnumber(analogMonitors.xrs_temp)+', '+jpmprintnumber(analogMonitors.megsa_ccd_temp1)+', '+jpmprintnumber(analogMonitors.megsb_ccd_temp1)+', '+jpmprintnumber(analogMonitors.megsa_ccd_temp2)+', '+jpmprintnumber(analogMonitors.megsb_ccd_temp2)+', '+jpmprintnumber(analogMonitors.cryo_hot)+$
          ', '+jpmprintnumber(analogMonitors.exprt_28v)+', '+jpmprintnumber(analogMonitors.vac_valve_pos)+', '+jpmprintnumber(analogMonitors.hvs_pressure)+', '+jpmprintnumber(analogMonitors.exprt_15v)+$
          ', '+jpmprintnumber(analogMonitors.fpga_5v)+', '+jpmprintnumber(analogMonitors.tv_12v)+', '+jpmprintnumber(analogMonitors.megsa_ff_led)+', '+jpmprintnumber(analogMonitors.megsb_ff_led)+', '+jpmprintnumber(analogMonitors.sdoor_pos)+$
          ', '+jpmprintnumber(analogMonitors.exprt_bus_cur)+', '+jpmprintnumber(analogMonitors.tm_exp_batt_volt)+', '+jpmprintnumber(analogMonitors.esp_fpga_time)+', '+jpmprintnumber(analogMonitors.esp_rec_counter)+$
          ', '+jpmprintnumber(analogMonitors.esp1)+', '+jpmprintnumber(analogMonitors.esp2)+', '+jpmprintnumber(analogMonitors.esp3)+', '+jpmprintnumber(analogMonitors.esp4)+$
          ', '+jpmprintnumber(analogMonitors.esp5)+', '+jpmprintnumber(analogMonitors.esp6)+', '+jpmprintnumber(analogMonitors.esp7)+', '+jpmprintnumber(analogMonitors.esp8)+$
          ', '+jpmprintnumber(analogMonitors.esp9)+', '+jpmprintnumber(analogMonitors.megsp_fpga_time)+', '+jpmprintnumber(analogMonitors.megsp1)+', '+jpmprintnumber(analogMonitors.megsp2)

  return
end

