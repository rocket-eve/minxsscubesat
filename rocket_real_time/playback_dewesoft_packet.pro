;+
; This program will read and return one DeweSoft packet from a file.
; It it called by rocket_eve_tm2_real_time_display when setting the playback keyword.
; All of the file data is help in memory and each succesive call returns the next "packet".
; A packet is a dewesoft packet defined by a start and end sync marker and it includes those 
; sync markers. The start sync is 0,1,2,3,4,5,6,7 as bytes and the end is the reverse.
; 
; This code assumes the file starts at a sync marker. It does not necessarily end at a sync marker.
;
;-
function playback_dewesoft_packet, tm1=tm1, tm2=tm2

  common playback_dewesoft_packet, tmfile, tmfile_lun, filedata, pktnumber, pktstart, pktend, n_pktend
  
  if keyword_set(tm1) then begin
    tmfile = getenv('HOME')+'/Dropbox/minxss_dropbox/data/reve_36_389/tm1_files/rocket_tm1_bin_2023-04-14_16_48_05.bin'
  endif else begin
    tmfile = getenv('HOME')+'/Dropbox/minxss_dropbox/data/reve_36_389/tm2_files/rocket_tm2_bin_2023-04-14_14_24_19.bin'
  endelse

  if size(filedata,/type) eq 0 then begin
    openr, tmfile_lun, tmfile, /get

    fs = fstat(tmfile_lun)
    filedata = bytarr(fs.size)

    readu, tmfile_lun, filedata ; read the whole file
    free_lun, tmfile_lun

    pktnumber = 0L

    ; find end sync markers
    syncend = [7b, 6b, 5b, 4b, 3b, 2b, 1b, 0b]
    syncstart = reverse(syncend)
    
    if keyword_set(tm2) then begin
      ; find indices of the 0 in the syncend, last value is the end of a packet
      pktend=where($
        shift(filedata,7) eq syncend[0] and $
        shift(filedata,6) eq syncend[1] and $
        shift(filedata,5) eq syncend[2] and $
        shift(filedata,4) eq syncend[3] and $
        shift(filedata,3) eq syncend[4] and $
        shift(filedata,2) eq syncend[5] and $
        shift(filedata,1) eq syncend[6] and $
        filedata eq syncend[7], n_pktend)

      pktstart=[0L, 1L+pktend[0:n_pktend-2]]
      ; n_pktend is the number of packets
    endif else begin
      ; TM1 has NOT END SYNC MARKER
      pktstart=where($
        filedata eq syncstart[0] and $
        shift(filedata,-1) eq syncstart[1] and $
        shift(filedata,-2) eq syncstart[2] and $
        shift(filedata,-3) eq syncstart[3] and $
        shift(filedata,-4) eq syncstart[4] and $
        shift(filedata,-5) eq syncstart[5] and $
        shift(filedata,-6) eq syncstart[6] and $
        shift(filedata,-7) eq syncstart[7])
      pktend=[pktstart[1:*]-1, n_elements(filedata)-1]
    endelse
  endif

  n_pktend = n_elements(pktend)
  packet = filedata[pktstart[pktnumber]:pktend[pktnumber]]
  pktnumber = (pktnumber + 1) mod n_pktend
  return,packet
end
