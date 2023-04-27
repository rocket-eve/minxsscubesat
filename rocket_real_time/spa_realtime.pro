pro spa_realtime
  ;forward_function dualsps_read_file
  ;forward_function dualsps_plot
  dirX55=file_search("C:\Users\rocket\Documents\Hydra_2021_XRS_X55\Rundirs\2023_*")
  dirX55=dirX55[-1]
  firstx55=0
  firstsps=0
  while 1 do begin
    fileX55=file_search(dirX55+'\tlm*')
    fileX55=fileX55[-1]
    if fileX55 then begin
      dualsps_plot,fileX55,'X55',win=1,xpos=150, ypos=300,xsize=600,ysize=300,inst='X55 Spectrum',/realtime,firstx55=firstx55
      dualsps_plot,fileX55,'SPS1',win=2,xpos=150, ypos=625,xsize=600,ysize=300,inst='XRS-C SPS Quad',/realtime,firstsps=firstsps
    endif else begin
      print, 'Waiting for X55 data'
    endelse
  endwhile
end