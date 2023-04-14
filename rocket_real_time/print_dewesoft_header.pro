pro print_dewesoft_header, data

  ; byte0-7 are "start packet string" 0x0,1,2,3,4,5,6,7
  ; byte 8-11 are 32-bit in packet size, size in bytes without stop and start strings
  ; byte 12-15 are 32-bit int packet type, always 0 for data packets
  ; byte 16-19 are 32-bit int, samples in packet, number of synchronous samples per ch
  ; byte 20-27 are 64-bit int samples acquired so far !!!!
  ; byte 28-35 are 64-bit float (double) absolute/relative time, number of days since 12/30/1899 or days since start of acq.

  print,'start',data[0:7];, ulong([data[0:3]],0), ulong([data[4:7]],0)
  print,'pktsize',data[8:11];, ulong([data[8:11]],0)
  print,'pkttype(0)',data[12:15];, ulong([data[12:15]],0)
  print,'samplesperpkt',data[16:19];, ulong([data[16:19]],0)
  print,'samplessofar',data[20:27];, long64([data[20:27]],0)
  print,'timestamp',data[28:35];,double([data[28:35]],0)



;stop
return
end
