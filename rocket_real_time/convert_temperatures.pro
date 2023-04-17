;+
; :Author:
;    Don Woodraska
;
; :History:
;    Created for 36.389
;-

;+
; This function evaluate the Steinhart-Hart equation for converting thermistor readings into degrees C
; The conversion involves 2 sets of coefficients, one to convert the thermistor into a resistance,
; and another to convert to degrees Celcius
; Reference https://en.wikipedia.org/wiki/Steinhart–Hart_equation
;
; :Params:
;    dn_in: in, required, type=numeric
;      Floats, Doubles, or integers will work. This is the value that is converted into resistance
;      using the r_coef array.
;    r_coef: in, required, type=fltarr or dblarr
;      Array of 3 elements to be used in converting raw values into resistance (ohms).
;    temp_coef: in, required, type=fltarr or dblarr
;      Array of 3 elements to be used for applyint the Steinart-Hart equation for resistance.
;
; :Returns:
;   This function returns the temperature in degrees C.
;
; :Restrictions:
;   This function was created to work on scalars.
;
; DLW 3/10/23 Initial creation, double precision
;-
function steinhart_hart, dn_in, r_coef, temp_coef

  dn = double(dn_in) ; do not allow 0, this creates a div by zero error

  ; R = b/((a/DN) - (b/c)-1) * 1000
  resistance = r_coef[1] * 1000.d / ((r_coef[0] / dn) - (r_coef[1]/r_coef[2]) - 1) ; units are Ohms
  ; prevent infinity
  if finite(resistance) eq 0 then return, -273.15 ; cannot convert infinity
  if resistance lt 1e-45 then return, -273.15 ; resistances close to zero would convert to negative infinity

  Rlog = alog(resistance) ; temperature is a cubic polynomial in logR

  temperature_degc = 1.d / (temp_coef[0] + temp_coef[1]*Rlog + temp_coef[2]*(Rlog^3)) - 273.15
  ; the 273.15 is needed to convert from Kelvin to deg C
  ; the Steinhart-Hart coefficients are usually for Kelvin
  return, temperature_degc
end

;+
; This function performs different conversions based on the keyword provided.
; One and only one keyword is required for each call.
;
;  :Params:
;     raw: in, required, type=numeric
;       This represents the native value that will be converted to degrees C.
;       Integers or floats are OK.
;
;  :Keywords:
;     megsp_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the MEGS-P thermistor.
;       This conversion uses the Steinhart-Hart equation.
;     xrs_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the XRS thermistor.
;       This conversion uses the Steinhart-Hart equation.
;     cryo_hot: in, option, type=boolean
;       Set this keyword to choose the conversion for the cryo_hot thermistor.
;       This conversion uses the Steinhart-Hart equation.
;     cryo_cold: in, option, type=boolean
;       Set this keyword to choose the conversion for the cryo_cold thermistor.
;       This conversion is a 2nd order polynomial as an argument to a line.
;     megsa_ccd_prt_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the
;       megsa_ccd_prt_temp thermistor. (assume board 003 platinum)
;       This conversion is linear.
;     megsb_ccd_prt_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the
;       megsb_ccd_prt_temp thermistor. (assume board 004 platinum)
;       This conversion is linear.
;     megsa_ccd_diode_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the
;       megsa_ccd_diode_temp thermistor. (assume board 003 diode)
;       This conversion is linear.
;     megsb_ccd_diode_temp: in, option, type=boolean
;       Set this keyword to choose the conversion for the
;       megsb_ccd_diode_temp thermistor. (assume board 004 diode)
;       This conversion is linear.
;
; DLW 4/5/23 Added megsa/b_ccd_prt/diode_temp keywords and Bennet's initial conversion
;-
function convert_temperatures, $
   raw, $
   megsp_temp=megsp_temp, xrs_temp=xrs_temp, cryo_hot=cryo_hot, $
   cryo_cold=cryo_cold, $ ; megsa_ccd_temp=megsa_ccd_temp, megsb_ccd_temp=megsb_ccd_temp,  ; MEGS-A/B CCD TEMP were replaced
   megsa_ccd_prt_temp=megsa_ccd_prt_temp, megsb_ccd_prt_temp=megsb_ccd_prt_temp, $
   megsa_ccd_diode_temp=megsa_ccd_diode_temp, megsb_ccd_diode_temp=megsb_ccd_diode_temp

  woods5 = [0.00147408,0.00023701459,1.0839894e-7]
  woods6 = [0.0014051,0.0002369,1.019e-7]
  woods7 = [0.001288,0.0002356,9.557e-8]
  woods8 = [0.077,0.1037,0.0256]
  woods11 = [15.0,11.75,5.797]

  woods14 = [15.0,12.22,5.881]
  woods15 = [15.0,11.71,5.816]
  woods17 = [257.122,-257.199]

  ; conversions provided by Bennet Schwab 3/31/23
  board3_prt = [51.678364, -159.89857 - 16.]   ; MA (noise offset needed, 22C in lab, 16C at WSMR)
  board4_prt = [51.956196, -160.56519 - 16.] ; MB (noise offset needed, 22C in lab, 16C at WSMR)
  board3_diode = [-67.323044, 211.56467] ; MA
  board4_diode = [-67.629051, 212.42528] ; MB

  if keyword_set(megsp_temp) then begin
     ;R_therm_MEGSP = woods14[1]/((woods14[0]/(raw))-(woods14[1]/woods14[2])-1)*1000
     ;t_MEGSP = 1/(woods7[0]+woods7[1]*alog(R_therm_MEGSP)+woods7[2]*((alog(R_therm_MEGSP))^3))-273.15
     t_MEGSP = steinhart_hart( raw, woods14, woods7 )
     return, t_MEGSP
  endif

  if keyword_set(xrs_temp) then begin
     ;R_therm_XRS1 = woods15[1]/((woods15[0]/(raw))-(woods15[1]/woods15[2])-1)*1000
     ;t_XRS1 = 1/(woods6[0]+woods6[1]*alog(R_therm_XRS1)+woods6[2]*((alog(R_therm_XRS1))^3))-273.15
     t_XRS1 = steinhart_hart( raw, woods15, woods6 )
     return, t_XRS1
  endif

  if keyword_set(cryo_hot) then begin
     ;R_therm_Cryo_Hotside = woods11[1]/((woods11[0]/(raw))-(woods11[1]/woods11[2])-1)*1000
     ;t_Cryo_Hotside = 1/(woods5[0]+woods5[1]*alog(R_therm_Cryo_Hotside)+woods5[2]*((alog(R_therm_Cryo_Hotside))^3))-273.15
     t_Cryo_Hotside = steinhart_hart( raw, woods11, woods5 )
     return, t_Cryo_Hotside
  endif

  if keyword_set(cryo_cold) then begin
     ;v_convert = woods8[2]*(raw)^2 + woods8[1]*(raw) + woods8[0]
     v_convert = poly( raw, woods8 )
     t_Cold_Finger = woods17[0] * v_convert + woods17[1] ; woods17 coeffs are backwards from what poly needs
     return,t_Cold_Finger
  endif

  ; no longer used
  ;if keyword_set( megsa_ccd_temp ) then begin
  ;   return, 34.5*raw - 143.
  ;endif

  ; no longer used
  ;if keyword_set( megsb_ccd_temp ) then begin
  ;   return, 34.45*raw - 156.
  ;endif

  if keyword_set( megsa_ccd_prt_temp ) then begin ; board 003 platinum
     return, board3_prt[0]*raw + board3_prt[1]
  endif

  if keyword_set( megsb_ccd_prt_temp ) then begin ; board 004 platinum
     return, board4_prt[0]*raw + board4_prt[1]
  endif

  if keyword_set( megsa_ccd_diode_temp ) then begin ; board 003 diode
     return, board3_diode[0]*raw + board3_diode[1]
  endif

  if keyword_set( megsb_ccd_diode_temp ) then begin ; board 004 diode
     return, board4_diode[0]*raw + board4_diode[1]
  endif

  ; should have found something by now
  print,'ERROR: convert_temperatures - no keyword found, one must be selected to choose the conversion'
  stop
  return,-1
end

