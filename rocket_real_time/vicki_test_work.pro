


restore,'/Users/rocket/Dropbox/minxss_dropbox/rocket_eve/36.389/minxsscubesat/rocket_real_time/MegsCcdLookupTable.sav'

; APPEND CCD LOOKUP TABLE. THE FOURTH COLUMN IS THE INVERTED ROW CALLOUT DUE TO THE CCD READING FROM THE TOP LEFT INSTEAD OF THE BOTTOM LEFT.
a = make_array(4,1024UL * 2048UL)
a[0:2,*] = MegsCcdLookupTable
a[3,*] = 1023 - MegsCcdLookupTable[2,*]
MegsCcdLookupTable = a

;------------------------------------------------------------------------------------------------

; GENERATE TEST PATTERN
test_pattern = make_array(2048,1024, value = 0)
for i = 0,1024/2 do begin
    test_pattern[*,i] = [0:2047]+i
endfor

test_pattern[*,1024/2:-1] = test_pattern[*,0:1024/2-1]*2
test_pattern = rotate(test_pattern, 2)
test_pattern = reverse(test_pattern)

a = image(rebin(test_pattern mod 256,512,256))



;------------------------------------------------------------------------------------------------

; CREATE AN ARRAY TO HOLD THE FINAL DATA
megsAImageBuffer = test_pattern
megsAImageBuffer[*] = 0



;------------------------------------------------------------------------------------------------

; CALCULATE HOW TO FILL THE BUFFER USING THE WHOLE PACKET AT ONCE


; SET PACKET SIZE
PacketSize = 2048*2

; SET THE BUFFER INDEX TO -1 AT THE START OF THE IMAGE
BufferIndex = -1L

tic
; LOOP FOR THE NUMBER OF PACKETS IT TAKES TO GET A FULL IMAGE
for i = 0,511 do begin; 1048 plus a bit?

  ; BUFFER INDEX IS AN ARRAY DESIGNATING THE INDEX OF ALL THE ITEMS IN OUR PACKET. IT IS A FUNCTION OF HOW MANY PACKETS WE'VE ALREADY READ, FROM 0 TO 2,097,152 (ish)
  BufferIndex = [BufferIndex[-1]+1L : BufferIndex[-1]+PacketSize]       ; this calculates an array of index locations for the packet
  
  bufferindex = bufferindex mod 1024UL * 2048UL
  
  
  ; LOOK UP THE X AND Y LOCATIONS FOR THE PACKET DATA, USING THE MODIFIED Y VALUES FROM ABOVE
  megsACcdColumnRow = make_array(2,PacketSize)
  megsACcdColumnRow[0,*] = MegsCcdLookupTable[1,BufferIndex]
  megsACcdColumnRow[1,*] = MegsCcdLookupTable[3,BufferIndex]
  
  ; GENERATE PACKET FROM TEST DATA (this part is simulating external data flow)
  megsAPixels = test_pattern[megsACcdColumnRow[0,*],megsACcdColumnRow[1,*]] ; this is the input data from the detector

  ; FILL BUFFER WITH PACKET DATA
  megsAImageBuffer[megsACcdColumnRow[0,*], megsACcdColumnRow[1,*]] = megsApixels
  

endfor
toc; 0.078568935
a = image(rebin(megsAImageBuffer mod 256,512,256))


stop


; SET THE BUFFER INDEX TO -1 AT THE START OF THE IMAGE
BufferIndex = -1L

; BUFFER INDEX IS AN ARRAY DESIGNATING THE INDEX OF ALL THE ITEMS IN OUR PACKET. IT IS A FUNCTION OF HOW MANY PACKETS WE'VE ALREADY READ, FROM 0 TO 2,097,152 (ish)
BufferIndex = [BufferIndex[-1]+1L : BufferIndex[-1]+PacketSize]       ; this calculates an array of index locations for the packet

; GENERATE PACKET FROM TEST DATA (this part is simulating external data flow)
megsAPixels = test_pattern[megsACcdColumnRow[0,*],megsACcdColumnRow[1,*]] ; this is the input data from the detector

megsAPixelIndex = 0
megsAImageBuffer2 = megsAImageBuffer

;megsAPixels = ((megsAPacketData + '2000'X) AND '3FFF'X)
tic
FOR packetIndex = 0, PacketSize - 1 DO BEGIN
  IF megsAPixelIndex LT 2048LL * 1024LL THEN BEGIN
    megsACcdColumnRow = megsCcdLookupTable[1:2, megsAPixelIndex]
    ;megsAImageBuffer[megsACcdColumnRow[0], megsACcdColumnRow[1]] = ((megsAPacketData[packetIndex] + '2000'X) AND '3FFF'X) ; The 0x2000 and 0x3FFF mask out the extra 2 bits (14 bits instead of 16)
    megsAImageBuffer2[megsACcdColumnRow[0], megsACcdColumnRow[1]] = megsAPixels[packetIndex] ; The 0x2000 and 0x3FFF mask out the extra 2 bits (14 bits instead of 16)
    megsAPixelIndex++
  ENDIF
ENDFOR
toc



stop
end