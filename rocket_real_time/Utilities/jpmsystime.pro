;+
; NAME:
;   JPMsystime
;
; PURPOSE:
;   IDL's default systime() function has no options for formatting to human time (yyyy-mm-dd hh:mm:ss). This code does that. 
;
; INPUTS:
;   None
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   ISO: Set this to return time with the T and timezone correction at the end e.g., 2016-10-26T10:37:25+07:00
;
; OUTPUTS:
;   currentTimeHuman [string]: The current local time in human format: yyyy-mm-dd hh-mm-ss
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   message, /INFO, JPMsystime() + ' Processing complete'
;
; MODIFICATION HISTORY:
;   2016-09-02: James Paul Mason: Wrote script.
;   2016-10-26: James Paul Mason: Added the ISO keyword
;   2017-02-17: James Paul Mason: Made the UTC keyword also return
;   with a Z at the end rather than the pos/neg local timezone offset
;   2023-04-10 Don Woodraska: Use string functions instead of if
;   statements that prepend '0', bug fixes in return statements that
;   were returning assignment statements for iso & utc set, and when
;   just iso was set, removed capitalization of IDL statements
;
;-
function jpmsystime, iso=iso, utc=utc

; Get the current time broken up into components 
jd = systime(/julian, utc=utc)
caldat, jd, month, day, year, hour, minute, second

; Convert to fixed length strings
yyyy = string(year, form='(i04)') ; 4-digits, zero padded
mm = string(month, form='(i02)') ; 2-digits, zero padded
dd = string(day, form='(i02)')
hh = string(hour, form='(i02)')
mmin = string(minute, form='(i02)')
ss = string(second, form='(i02)')

if keyword_set(iso) then timeBreakCharacter = 'T' else timeBreakCharacter = ' '

currentTimeHuman = yyyy + '-' + mm + '-' + dd + timeBreakCharacter + hh + ':' + mmin + ':' + ss

if keyword_set(iso) then begin
  jdUtc = systime(/julian, /utc)
  jdLocal = systime(/julian)
  hourDiff = abs(jdUtc - jdLocal) * 24.

  if hourDiff eq 0 then return, currentTimeHuman + 'Z'

  hhDiff = string(hourDiff, form='(i02)')
  if jdLocal gt jdUtc then posOrNeg = '+' else posOrNeg = '-'

  if keyword_set(UTC) then begin
    return, currentTimeHuman + 'Z'
  endif

  return, currentTimeHuman + posOrNeg + hhDiff + ':00' ; Not dealing with timezones that have a minute difference
endif

return, currentTimeHuman

end
