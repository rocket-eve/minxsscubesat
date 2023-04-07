;+
; This function combines the excel spreadsheet description and label
; with the existing info in the result structure that was populated
; from read_altair_ch_description.
;
; Users need to save the Excel file and edit the top to make it look
; like this:
; Channel,Description,User,Label,Word,Wd_Int,Frame,Fr_Int
; A1,Z Axis Accelerometer,TM,Z_ACC,8,,,
; A2,X Axis Accelerometer,TM,X_ACC,9,,,
; A3,Y Axis Accelerometer,TM,Y_ACC,9,,,
; A4,Z Axis Magnetometer,TM,Z_MAG,36,,,
; ...
;
; Note that the first line is skipped using record_start keyword.
;
; All decks are together in the definitions, but might not all be
; available.
;
; DLW 04/06/2023 for 36.389
;
;-
function merge_with_altair_csv_file, altairfile, result
  
  ; read the altair csv file, skip first line
  d = read_csv(altairfile, record_start=1) ; i.e. 'altair_36.389_all_tm1.csv'
  ; d.field1 is Channel
  ; d.field2 is Description (put in tmdescription)
  ; d.field3 is User
  ; d.field4 is Label (put in tmlabel)

  for i=0, n_elements(result)-1 do begin
     gd=where(d.field1 eq result[i].ach, n_gd)
     if n_gd eq 1 then begin
        result[i].tmdescription = d.field2[gd] ; tmdescription
        result[i].tmlabel = d.field4[gd] ; tmlabel
     endif
  endfor

  return, result
end


;+
; The function read_altair_ch_descriptions reads the Altair telemetry
; channel definition file and returns a structure containing the
; altair ch, description, and the description broken out into the two
; components of the "achannel" and the variable name.
;
; The text file of channels is from the Dewesoft computer.
; This is the result of running connecting to the Dewesoft computer
; and issuing the command "listusedchs" and capturing the output to a
; text file. All lines that do not start with "CH" are ignored.
;
; This info is merged with the csv file from the telemetry
; definitions that allow tlm rate calculations. These are mapped
; together using the channel "A107" - convention.
;
; :Returns:
;   An array of structures is returned.
;
; The location of the file needs to be in the same directory.
;
; DLW 04/05/2023 for 36.389
;
;-
function read_altair_ch_descriptions, filename

  ; get the directory of this function
  dir = file_dirname((routine_info('read_altair_ch_descriptions',/function,/source)).path) + path_sep()

  ; altair dump from interactive session
  filename = dir + '36.389 Woods TM TCP-IP Altair Channel Descriptions.txt' 

  ; csv is from Excel sheet 36.389_2.5Mbps_Woods_TM1_Measurement List_2-28-23.xlsx
  altairfile = dir + 'altair_36.389_all_tm1.csv' 
  
  ; the file looks like this
  ;+CONNECTED DEWESoft TCP/IP server
  ;listusedchs
  ;+STX listing channels
  ;CH      100000  0       Port0/Main stream/FLOCK Main stream     -       Async   3125    10      0       31250   1       0       1       0       PCM             0       2       OvlNo   0       3 0       LOS     FFFFFF  1       CHECK   FFFFFF  2       LOCK    FFFFFF  0       0       0
  ;CH      100000  1       Port0/Main stream/SFLOCK        Main stream     -       Async   3125    10      0       31250   1       0       1       0       PCM             0       2       OvlNo   0 3       0       LOS     FFFFFF  1       CHECK   FFFFFF  2       LOCK    FFFFFF  0       0       0
  ;CH      100000  2       Port0/Main stream/SFID  Main stream     -       Async   3125    0       4       31250   1       0       1       0       PCM             0       100     OvlNo   0       0 0       0       0
  ;CH      100000  3       TimeLock        Main stream     -       Async   3125    10      0       31250   1       0       1       0       PCM             0       1       OvlNo   0       2       0 LOS     FFFFFF  1       LOCK    FFFFFF  0       0       0
  ;CH      100000  4       A1_Z_ACC                        Async   1562    0       5       15620   1       0       1       0       PCM             0       1023    OvlNo   0       0

  n_lines = file_lines(filename)

  ; define one structure that has all the fields that are needed
  rec = {ch:-1L, $
         description:'', $
         ach:'', $
         varname:'', $
         tmdescription:'', $
         tmlabel:'', $
         conv_factor:0.0, $
         conv_offset:0.0, $
         raw:0L, $
         floatvalue:0., $
         statevalue:'' $
        }
  
  result = replicate(rec, n_lines)
  ; will need to trim off the extra later
  
  openr,lun,/get,filename
  s=''
  for line=0,n_lines-1 do begin
     readf,lun,s
     ; skip lines that do not start with ch
     if strmid(s,0,2) eq 'CH' then begin
        s_elem = strsplit(s,' ',/extract)
        result[line].ch = long(s_elem[2])
        ; just go until the first space
        ; replace all spaces with underscores
        result[line].description = (strtrim(s_elem[3],2)).replace(' ','_')
        ; description is similar to A97_MEGSP_TEMP__Raw

        ; define ach and varname using description
        ss_elem = strsplit(result[line].description,'_',/extract)
        if n_elements(ss_elem) ge 2 then begin
           result[line].ach = ss_elem[0]
           result[line].varname = strjoin(ss_elem[1:*],'_')
        endif
     endif
  endfor
  free_lun,lun

  ; trim off the unused elements

  good = where(result.ch gt -1 and result.ach ne '', n_good)
  if n_good eq 0 then begin
     print,'ERROR: read_altair_ch_descriptions failed, no data'
     stop
  endif

  result = merge_with_altair_csv_file( altairfile, result )
  
  ; now read the altair csv file
  d = read_csv(dir + 'altair_36.389_all_tm1.csv')
  ; d.field1 is Channel
  ; d.field2 is Description (put in tmdescription)
  ; d.field3 is User
  ; d.field4 is Label (put in tmlabel)
  for i=0, n_elements(result)-1 do begin
     gd=where(d.field1 eq result[i].ach, n_gd)
     if n_gd eq 1 then begin
        result[i].tmdescription = d.field2[gd] ; tmdescription
        result[i].tmlabel = d.field4[gd] ; tmlabel
     endif
  endfor
  
  return, result[good]
end
