;
;	print_dewesoft_data
;
;	Print Dewesoft Data per channel
;
pro print_dewesoft_data, data, ASYNC=ASYNC

  ; HEADER info (printed by print_dewesoft_header.pro)
  ; byte0-7 are "start packet string" 0x0,1,2,3,4,5,6,7
  ; byte 8-11 are 32-bit in packet size, size in bytes without stop and start strings
  ; byte 12-15 are 32-bit int packet type, always 0 for data packets
  ; byte 16-19 are 32-bit int, samples in packet, number of synchronous samples per ch
  ; byte 20-27 are 64-bit int samples acquired so far !!!!
  ; byte 28-35 are 64-bit float (double) absolute/relative time, number of days since 12/30/1899 or days since start of acq.
;  print,'start',data[0:7];, ulong([data[0:3]],0), ulong([data[4:7]],0)
;  print,'pktsize',data[8:11];, ulong([data[8:11]],0)
;  print,'pkttype(0)',data[12:15];, ulong([data[12:15]],0)
;  print,'samplesperpkt',data[16:19];, ulong([data[16:19]],0)
;  print,'samplessofar',data[20:27];, long64([data[20:27]],0)
;  print,'timestamp',data[28:35];,double([data[28:35]],0)

  ; CHECK for PKTTYPE EQ 0
  pkttype = ulong([data[12:15]],0)
  if (pkttype ne 0) then begin
  	print, 'ERROR for dewesoft packet type not being zero !'
  	stop, 'DEBUG  data  for packet content (or just .continue )'
  endif

  ; DATA info for PKTTYPE =  0 (raw data, not scaled)
  ; Each channel has:
  ;		number of samples (ULONG)
  ; 	data for each sample (2 bytes)
  ;		and 8-byte Time values for each sample if ASYNC data

  num_sync = 8L
  num_header = 28L
  offset = num_sync + num_header	; offset to first channel data
  offset_ch = offset	; channel 1 offset

  rawDataSize = 2L
  floatSize = 4L
  sampleSize = rawDataSize
  if keyword_set(ASYNC) then sampleSize += 8L
  num_samples1 = ulong(data[offset_ch:offset_ch+3],0)
  ; estimate max number of channels
  num_data = n_elements(data)
  num_ch = (num_data - 2*num_sync - num_header)/(sampleSize*num_samples1+4L)
  num_samples_all = lonarr(num_ch)
  offsets_all = lonarr(num_ch)

  print, ' '
  print, ' CH #Samples    MIN     MAX     MEAN    MEDIAN '
  print, ' __ ________ ________ ________ _______ ________'
  format = '(I3,I8,4F8.1)'
  for ii=0,num_ch-1 do begin
	num_samples = ulong(data[offset_ch:offset_ch+3],0)
	num_samples_all[ii] = num_samples
	offsets_all[ii] = offset_ch
	; special code for Serial Data for TM1
	if (ii eq 22) then begin
		samples = float(data[offset_ch+4:offset_ch+4+num_samples*floatSize-1],0,num_samples)
	endif else begin
		samples = uint(data[offset_ch+4:offset_ch+4+num_samples*rawDataSize-1],0,num_samples)
	endelse
	; print MIN, MAX, MEAN, MEDIAN
	print, ii, num_samples, min(samples), max(samples), mean(samples), median(samples), format=format
	; increment offset_ch for next channel
	if (ii eq 22) then offset_ch += 4L + num_samples * (sampleSize+2L) $
	else offset_ch += 4L + num_samples * sampleSize
	; BREAK if reached end of data
	if (offset_ch ge (num_data-12)) then BREAK
  endfor

stop, 'DEBUG data, num_samples_all, offsets_all ...'
return
end
