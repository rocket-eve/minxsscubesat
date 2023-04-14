pro write_raw_tm2_binary, data

  common write_raw_tm2_binary, filename, file_lun

  if size(filename,/type) eq 0 then begin
    filename = getenv('HOME') + '/Dropbox/minxss_dropbox/data/reve_36_389/tm2_files/rocket_tm2_bin_' + strjoin(strsplit(jpmsystime(), ' :', /EXTRACT), '_')+'.bin'
    openw, file_lun, filename,/GET_LUN
  endif

  writeu, file_lun, data
  
return
end
