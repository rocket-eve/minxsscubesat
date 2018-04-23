;
;	minxss_goes_2temperature_fit.pro
;
;	This procedure will compare plasma temperature dervied from MinXSS L1 spectra and GOES XRS-A/XRS-B ratio
;	This is similar to minxss_goes_temperature_fit except it does 2-Temperature Fit using
;		minxss_fit_2temperature.pro
;
;	INPUT
;		date		Date in format of Year and Day of Year (YYYYDOY) or it can be in YYYYMMDD format too
;		date_end	Optional date for end of time series (if not provided, then just one day)
;		/fm			Option to specify which MinXSS Flight Model (default is 1)
;		/reload		Option to reload L1, GOES XRS, and Orbit Number file
;		/hour_range	Option to define Hour range for a single day plot
;		/eps		Option to make EPS graphics files after doing interactive plotting
;		/list_fit	Option to list 2T fit results over the hour_range
;		/full_mission  Option to process the full mission
;		/debug		Option to debug at the end
;
;	OUTPUT
;		result		Array of time, MinXSS_integrated_XRS-B, GOES_XRS-B, MinXSS_Temperature,
;							GOES_Temperature, and MinXSS_Abundance_Factor
;
;	FILES
;		MinXSS L1		$minxss_data/fm1/level1/minxss1_l0c_all_mission_length.sav
;		GOES XRS		$minxss_data/merged/goes_1mdata_widx_YEAR.sav  (YEAR=2016 for now)
;		Flare Plots		$minxss_data/trends/goes  directory
;		GOES Temperature  $minxss_data/merged/xrs_temp_current.dat
;		X123 Temperature  $minxss_data/merged/x123_ch_ss_sp_2016c.sav
;
;		NOTE that system environment must be set for $minxss_data
;
;	CODE
;		This procedure plus plot routines in
;		$minxss_dir/code/production/convenience_functions_generic/
;
;	HISTORY
;		9/3/2016  Tom Woods   Original Code based on minxss_goes_ts used for Level 1 GOES comparisons
;		9/10/2016 Tom Woods	  Updated to use GOES bands from X123 for temperature estimate
;								NOTE that Version 2 does not work well because X123 XRS-A is very low counts
;		9/12/2016 Tom Woods	  Changed to use minxss_fit_temperature.pro to get Temperature & Abundance
;		9/18/2016 Tom Woods	  Changed to use minxss_fit_2temperature.pro to get Temperature & Abundance
;		9/26/2016 Tom Woods	  Added plot of XRS-B intensity versus Temperature
;		5/12/2017 Tom Woods   Updated for Version 3 of minxss_fit_2temperature.pro
;		5/16/2017 Tom Woods	  Major update so result output is array structure and
;								full mission is not fit every time unless /full_mission option is given
;		9/10/2017 Tom Woods   Updated to use the new Level 1 files updated by Chris Moore (use 1-min avg)
;								new Level 1 name is minxsslevel1_x123
;
pro minxss_goes_2temperature_fit, date, date_end, result=result, fm=fm, full_mission=full_mission, $
						hour_range=hour_range, eps=eps, debug=debug, list_fit=list_fit

;	common variable to save data between calls
;			goes_data = GOES XRS data (1-min cadence)
;			minxsslevel1_x123 and fm_last = MinXSS Level 1 data for FM=fm_last
;			x123_fits and haveFullMission = X123 2-Temperature & Abundance fits over the full mission
common minxss_data1_2temperature_fit, goes_data, x123_fits, haveFullMission, fm_last, minxsslevel1_x123, $
							index, x123_num
; 	OLD COMMON VARIABLES:  data1, doy1, x123_jd, x123_xrsa, x123_xrsb, $
; 					goes_doy, goes_xrsa, goes_xrsb, $
;					base_year, xrsratio_temp, xrs_logT, x123_logT, x123_logT_2, x123_abundance, $
;					x123_fit_chi, x123_fe_xxv, x123_abundance_fe_xxv, x123_fits

;
;	check input parameters
;
if n_params() lt 1 then begin
	print, ' '
	print, 'USAGE:  minxss_goes_2temperature_fit, date, date_end, result=result, fm=fm, /eps, /debug, '
	print, '                                hour_range=hour_range, /list_fit, /full_mission'
	print, ' '
	date = 20160609L  ; first Science Day in MinXSS-1 mission
	if not keyword_set(full_mission) then read, '>>>>> Enter Date as YYYYDOY or YYYYMMDD format ? ', date
endif
if (date gt 2030000L) then begin
	; input format is assumed to be YYYYMMDD
	year = long(date / 10000.)
	mmdd = long(date - year*10000L)
	mm = long(mmdd / 100.)
	dd = long(mmdd - mm*100L)
	doy = long( julday(mm, dd, year) - julday(1,1,year,0,0,0) + 1. )
endif else begin
	; input format is assumed to be YYYYDOY
	year = long(date / 1000.)
	doy = long(date - year*1000L)
endelse
if (year lt 2016) then year = 2016L
if (year gt 2030) then year = 2030L
year_str = strtrim(long(year),2)
if (doy lt 1) then doy=1L
if (doy gt 366) then doy=366L
date_jd = yd2jd(year*1000. + doy)
doy_str = strtrim(long(doy),2)
yyyydoy_str = year_str + '/' + doy_str

; default year2, doy2 values for a single DOY
year2 = year
doy2 = doy + 1
date2_jd = yd2jd(year2*1000. + doy2)
doy2_str = strtrim(long(doy2),2)
doDays = 0
numDays = 1

if (n_params() ge 2) or keyword_set(full_mission) then begin
  doDays = 1
  if keyword_set(full_mission) then date_end = 20170606L  ; last day of MinXSS-1 mission
  if (date_end gt 2030000L) then begin
	; input format is assumed to be YYYYMMDD
	year2 = long(date_end / 10000.)
	mmdd = long(date_end - year2*10000L)
	mm = long(mmdd / 100.)
	dd = long(mmdd - mm*100L)
	doy2 = long( julday(mm, dd, year2) - julday(1,1,year2,0,0,0) + 1. )
  endif else begin
	; input format is assumed to be YYYYDOY
	year2 = long(date_end / 1000.)
	doy2 = long(date_end - year2*1000L)
  endelse
  if (year2 lt 2016) then year2 = 2016L
  if (year2 gt 2030) then year2 = 2030L
  year2_str = strtrim(long(year2),2)
  if (doy2 lt 1) then doy2=1L
  if (doy2 gt 366) then doy2=366L
  if (doy2 le doy) and (year2 eq year) then doy2 = doy + 2
  date2_jd = yd2jd(year2*1000. + doy2)
  numDays = long(date2_jd - date_jd)
  if (numDays lt 1) then begin
  	doDays = 0
  	numDays = 1
  	year2 = year
	doy2 = doy + 1
  endif
  doy2_str = strtrim(long(doy2),2)
  yyyydoy2_str = year2_str + '/' + doy2_str
  if (doDays ne 0) then yyyydoy_str += ' to ' + yyyydoy2_str
endif

;  option for Flight Model, default is 1
if not keyword_set(fm) then fm=1
fm=long(fm)
if (fm lt 1) then fm=1
if (fm gt 2) then fm=2
fm_str = strtrim(long(fm),2)

; option to process the Full mission
if size(haveFullMission,/type) eq 0 then haveFullMission = 0

;  slash for Mac = '/', PC = '\'
if !version.os_family eq 'Windows' then begin
    slash = '\'
    file_copy = 'copy '
    file_delete = 'del /F '
endif else begin
    slash = '/'
    file_copy = 'cp '
    file_delete = 'rm -f '
endelse

;
;	read the MinXSS L1 merged file and GOES XRS data
;
dir_fm = getenv('minxss_data')+slash+'fm'+fm_str+slash
dir_merged = getenv('minxss_data')+slash+'merged'+slash
if (n_elements(minxsslevel1_x123) lt 2) or (n_elements(goes_data) lt 2) then doLoad = 1 else doLoad = 0
if (doLoad eq 0) then if (fm ne fm_last) then doLoad = 1
if (doLoad ne 0) then begin
  fm_last = fm  ; save for next call
  print, '*****  Reading MinXSS Level 1 and GOES data ...'
  ; file1 = 'minxss1_l1_mission_length.sav'
  file1 = 'minxss'+fm_str+'_l1_mission_length.sav'
  restore, dir_fm + 'level1' + slash + file1   ; restores minxsslevel1_x123 and minxsslevel1_x123_meta

  ;
  ;	load GOES XRS data from $minxss_data/ancillary/goes/ IDL save set (file per year)
  ;
  fm_years = [2016, 2017]
  if (fm eq 2) then fm_years = [2017]
  num_fm_years = n_elements(fm_years)
  goes_num = num_fm_years * 366L * (24L*60L)   ; one-minute cadence
  goes_len = 0L
  goes1 = { jd: 0.0D0, yd: 0.0D0, xrsb: 0.0, xrsa: 0.0, logTemp: 0.0 }
  goes_data = replicate( goes1, goes_num )
  for k=0,num_fm_years-1 do begin
    xrs_file = 'goes_1mdata_widx_'+strtrim(fm_years[k],2)+'.sav'
    xrs_dir = getenv('minxss_data')+slash+'ancillary'+slash+'goes'+slash
    restore, xrs_dir + xrs_file   ; goes data structure
    num_new = n_elements(goes)
    goes_jd = gps2jd(goes.time)
    goes_data[goes_len:goes_len+num_new-1].jd = goes_jd
    goes_data[goes_len:goes_len+num_new-1].yd = jd2yd(goes_jd)
    goes_data[goes_len:goes_len+num_new-1].xrsb = goes.long
    goes_data[goes_len:goes_len+num_new-1].xrsa = goes.short
    goes_len += num_new
    goes=0L
    goes_jd = 0.
  endfor
  goes_data = goes_data[0:goes_len-1]  ; truncate to what is actually used

  ; apply "calibration" to GOES XRS (just done once)
  acal = 1. / 0.85	; XRS-A / 0.85 for "true" irradiance level
  goes_data.xrsa *= acal
  bcal = 1. / 0.70   ; XRS-B / 0.70  for "true" irradiance level
  goes_data.xrsb *= bcal
  ;
  ;	load temperature model for GOES ratio of XRS-A / XRS-B
  ;
  gtdir = dir_merged
  dtfile = 'xrs_temp_current.dat'
  xrsratio = read_dat(gtdir + dtfile)
  xrsratio[0,*] = alog10(xrsratio[0,*] * 1E6)		; convert T_MK to alog10(T_K)
  ;  place A/B ratio into Current_C column
  xrsratio[3,*] = 0.0
  wgd1 = where((xrsratio[2,*] gt 0) and (xrsratio[1,*] gt 0))
  xrsratio[3,wgd1] = xrsratio[1,wgd1] / xrsratio[2,wgd1]
  xrs_temp_valid = [5.3, 7.9]
  wgd = where( (xrsratio[0,*] ge xrs_temp_valid[0]) and (xrsratio[0,*] le xrs_temp_valid[1]) $
  		and (xrsratio[2,*] gt 0) and (xrsratio[1,*] gt 0) )
  ;  truncate to valid ratio range
  xrsratio_temp = xrsratio[*,wgd]
  ;
  ;	calculate GOES XRS temperature for all of the GOES data points
  ;
  ratio_xrs = goes_data.xrsa / (goes_data.xrsb > 1E-10)
  goes_data.logTemp = interpol( reform(xrsratio_temp[0,*]), reform(xrsratio_temp[3,*]), ratio_xrs )
  wlow = where( ratio_xrs lt min(xrsratio_temp[3,*], ilow), numlow )
  if (numlow gt 0) then goes_data[wlow].logTemp = xrsratio_temp[0,ilow]
  whigh = where( ratio_xrs gt max(xrsratio_temp[3,*], ihigh), numhigh )
  if (numhigh gt 0) then goes_data[whigh].logTemp = xrsratio_temp[0,ihigh]
endif

;
;	decide if Full Mission requires processing or just a shorter time range
;
if (n_elements(x123_fits) lt 2) then doProcess = 1 else doProcess = 0
if keyword_set(full_mission) and (haveFullMission eq 0) then doProcess = 1
if (doProcess eq 0) and (haveFullMission eq 0) and (not keyword_set(full_mission)) then doProcess = 1
if (doProcess ne 0) then begin
  x123_jd = minxsslevel1_x123.time.jd
  if keyword_set(full_mission) then begin
    haveFullMission = 1
  	x123_num = n_elements(x123_jd)
  	index = indgen(x123_num)
  	print, '***** Processing data for Full Mission ...'
  endif else begin
    index = where( (x123_jd ge date_jd) and (x123_jd lt date2_jd), x123_num )
    if (x123_num lt 2) then begin
    	print, 'ERROR: there are no MinXSS Level 1 data for ', yyyydoy_str
    	if keyword_set(debug) then stop, 'DEBUG this error...'
    	return
    endif
    print, '***** Processing data for ',yyyydoy_str
  endelse
  ; if keyword_set(debug) then stop, 'DEBUG: enter .c to continue for processing data. '
  energy = minxsslevel1_x123[0].energy
  energy_min = 0.15
  energy_max = 12.0
  wenergy = where( (energy ge energy_min) and (energy lt energy_max), energy_num )
  x123_fit1 = { jd: 0.0D0, yd: 0.0D0, x123_xrsa: 0.0, x123_xrsb: 0.0, fe_xxv_flux: 0.0, ca_xix_flux: 0.0, $
  			logT: 0.0, abundance: 0.0, abundance_fe_xxv: 0.0, abundance_ca_xix: 0.0, fit_chi: 0.0, $
  			uncertainty_abund: 0.0, uncertainty_abund_ca: 0.0, uncertainty_abund_fe: 0.0, $
  			logT_2: 0.0, abundance_2: 0.0, fit_chi_2: 0.0, $
  			cor_density: 0.0D0, photo_density: 0.0D0, cor_density_2: 0.0D0, photo_density_2: 0.0D0, $
  			energy: fltarr(energy_num), x123_irradiance: fltarr(energy_num), $
  			model_1: fltarr(energy_num),  model_2: fltarr(energy_num), model_baseline: fltarr(energy_num) }

  x123_fits = replicate( x123_fit1, x123_num )
  x123_fits.jd = x123_jd[index]
  x123_fits.yd = jd2yd(x123_jd[index])
  x123_jd = 0.
  ;
  ;		calculate GOES XRS-B equivalent band using X123 spectra
  ;		NOAA recommends XRS-B / 0.70 and  XRS-A / 0.85 for "true" irradiance level
  ;
  gcs = 1.5
  hc = 6.626D-34 * 2.998D8
  EFang = 12.398
  aband = EFang / [ 0.5, 4 ]	; convert Angstrom to keV for XRS bands
  awidth = aband[0] - aband[1]
  acenter = (aband[0]+aband[1])/2.
  actr_weighted = 4.13   ; 1/E^5 irradiance weighting means low energy more important
  bband = EFang / [ 1, 8 ]
  bwidth = bband[0] - bband[1]
  bcenter = (bband[0]+bband[1])/2.
  bctr_weighted = 2.06  ; 1/E^5 irradiance weighting means low energy more important
  ; get X123 energy values and band steps
  esp = reform(minxsslevel1_x123[0].energy)
  x123_band = esp[20] - esp[19]  ; ~ 0.03 keV/bin
  wgxa = where( (esp ge aband[1]) and (esp lt aband[0]) )
  aphoton2energy = (hc*esp[wgxa]) * 1.D4 / (1.D-10*EFang)
  wgxb = where( (esp ge bband[1]) and (esp lt bband[0]) )
  bphoton2energy = (hc*esp[wgxb]) * 1.D4 / (1.D-10*EFang)

  for k=0L, x123_num-1 do begin
  	;
  	;  get X123 integrated irradiance in units of W/m^2 for direct comparison to GOES
  	;
	x123_fits[k].x123_xrsa = total(minxsslevel1_x123[index[k]].irradiance[wgxa]*x123_band*aphoton2energy)
	x123_fits[k].x123_xrsb = total(minxsslevel1_x123[index[k]].irradiance[wgxb]*x123_band*bphoton2energy)
  endfor

  ;
  ;		fit X123 temperature to CHIANTI isothermal models
  ;
  if keyword_set(debug) then print, 'Calculating X123 temperatures for ',strtrim(x123_num,2), ' spectra...'
  ; minxss_fit_2temperature parameters = { logT: 0.0, cor_density: 0.0D0, photo_density: 0.0D0, $
  ;			abundance: 0.0, abundance_fe_xxv: 0.0, fe_xxv_flux: 0.0, abundance_ca_xix: 0.0, ca_xix_flux: 0.0, $
  ;			logT_2: 0.0, cor_density_2: 0.0D0, photo_density_2: 0.0D0, abundance_2: 0.0 }
  ;
  for k=0L,x123_num-1 do begin
  		e_data = minxsslevel1_x123[index[k]].energy
  		f_data = minxsslevel1_x123[index[k]].irradiance
  		theDebug = 0
  		if keyword_set(debug) and (x123_fits[k].x123_xrsb gt 4E-6) then theDebug = 1
  		minxss_fit_2temperature, e_data, f_data, fit_flux, parameters=param1, chi=chi, /noplot, debug=theDebug
  		x123_fits[k].logT = param1.logT
  		x123_fits[k].logT_2 = param1.logT_2
  		x123_fits[k].abundance = param1.abundance
  		x123_fits[k].abundance_2 = param1.abundance_2
  		x123_fits[k].fe_xxv_flux = param1.fe_xxv_flux
  		x123_fits[k].abundance_fe_xxv = param1.abundance_fe_xxv
  		x123_fits[k].ca_xix_flux = param1.ca_xix_flux
  		x123_fits[k].abundance_ca_xix = param1.abundance_ca_xix
  		x123_fits[k].cor_density = param1.cor_density
  		x123_fits[k].photo_density = param1.photo_density
  		x123_fits[k].cor_density_2 = param1.cor_density_2
  		x123_fits[k].photo_density_2 = param1.photo_density_2
  		x123_fits[k].fit_chi = chi[0]
  		x123_fits[k].fit_chi_2 = chi[1]
  		x123_fits[k].uncertainty_abund = param1.uncertainty_abund
  		x123_fits[k].uncertainty_abund_ca = param1.uncertainty_abund_ca
  		x123_fits[k].uncertainty_abund_fe = param1.uncertainty_abund_fe
  		energy = e_data[wenergy]
  		x123_fits[k].energy = energy
  		x123_fits[k].x123_irradiance = f_data[wenergy]
  		if (fit_flux[0] ne -1L) then begin
  		  x123_fits[k].model_1 = interpol( reform(fit_flux[2,*]), reform(fit_flux[0,*]), energy )
  		  x123_fits[k].model_2 = interpol( reform(fit_flux[3,*]), reform(fit_flux[0,*]), energy )
  		  x123_fits[k].model_baseline = interpol( reform(fit_flux[4,*]), reform(fit_flux[0,*]), energy )
  		endif
  		if (theDebug ne 0) then stop, 'DEBUG fit for larger flares...'
  endfor

  ans = ' '
  read, 'Do you want to save the model fit results ? ', ans
  if (strupcase(strmid(ans,0,1)) eq 'Y') then begin
    sfile = 'minxss'+strtrim(fm,2)+'_L1_2temp_fits'
    if (haveFullMission eq 0) then sfile = sfile+'_'+year_str+doy_str
    sfile += '.sav'
    print, 'Saving model fit results in ', dir_merged+sfile

    goes_units = [ 'JD = Julian Date', 'YD = YYYYDOY', 'XRSA & XRSB = W/m^2', $
    		'logTemp = log(K)', 'GOES XRS flux is corrected to standard NOAA calibration' ]
    x123_units = [ 'JD = Julian Date', 'YD = YYYYDOY', 'X123_XRSA = W/m^2', 'X123_XRSB = W/m^2', $
    		'logT & logT_2 = log(K)', 'ABUNDANCE values are relative to photosphere', $
    		'Fe_XXV & Ca_XIX_FLUX = ph/s/cm^2/keV', 'FIT_CHI & FIT_CHI_2 are model fit chi-squared values', $
    		'DENSITY parameters are Emission Measure (cm^5)', 'ENERGY = keV', $
    		'X123_IRRADIANCE & MODEL values have units of ph/s/cm^2/keV', $
    		'Uncertainty of Temperature is 0.1 log(K)', 'Uncertainty of Abundance is relative uncertainty' ]

     save, goes_data, x123_fits, goes_units, x123_units, file=dir_merged+sfile
  endif
endif

;
;	set some parameters / flags for the data
;
max_doy = long(max(doy2))

plotdir = getenv('minxss_data')+slash+'trends'+slash+'goes'+slash
ans = ' '

doEPS = 0   ; set to zero for first pass through for interactive plots
loopCnt = 0L

;
;	configure time in hours or in days
;
if (doDays ne 0) then begin
	; time1 is in units of DOY for multiple days (assumes same year)
	time1 = x123_fits.jd - date_jd + doy
	goes_time = goes_data.jd - date_jd + doy
	xtitle='Time (' + year_str + ' DOY)'
	num_days = long(date2_jd - date_jd)
	xrange=[doy,doy+num_days+1]
endif else begin
	; time1 is in units of hours for a single DOY
	time1 = (x123_fits.jd - date_jd)*24.
	goes_time = (goes_data.jd - date_jd)*24.
	xtitle='Time (Hour of ' + yyyydoy_str + ')'
	xrange = [0,24]
	if keyword_set(hour_range) then begin
	  if n_elements(hour_range) gt 1 then xrange=hour_range[0:1] else begin
	    hour1 = 0. & hour2 = 24.
	    read, 'Enter Hour Range : ', hour1, hour2
	    xrange = [hour1, hour2]
	  endelse
	endif
endelse

;
;	prepare science data for day around chosen DOY in case selects outside 24-hour period
;
sps_sum_1au = minxsslevel1_x123[index].sps_sum*(minxsslevel1_x123[index].earth_sun_distance^2.)
SPS_SUM_MIN = 1.98E6
SPS_SUM_MIN = 2.8E5  ; units changed so new level 9/10/2017
; wsci = where( (x123_fits.jd ge date_jd) and (x123_fits.jd lt date2_jd) and (sps_sum_1au gt SPS_SUM_MIN), num_sp )
wsci = where( sps_sum_1au gt SPS_SUM_MIN, num_sp )

if (num_sp le 1) then begin
	print, 'ERROR finding any L1 science data for DOY = ' + doy_str
	if keyword_set(debug) then stop, 'DEBUG FIT ...'
endif

;  limit data for returning "result"
sptime = time1[wsci]
slow_count1 = minxsslevel1_x123[index[wsci]].x123_slow_count
goes_xrsb_cmp = interpol( goes_data.xrsb, goes_time, sptime )
goes_xrsa_cmp = interpol( goes_data.xrsa, goes_time, sptime )

; make X123 version of XRS-B by integrating over GOES XRS-B band width
x123_xrsb_cmp = x123_fits[wsci].x123_xrsb
ratio_xrsb = x123_xrsb_cmp / goes_xrsb_cmp
x123_xrsa_cmp = x123_fits[wsci].x123_xrsa
ratio_xrsa = x123_xrsa_cmp / goes_xrsa_cmp

;
;	calculate X123 temperature and GOES temperature for just the direct comparison to X123
;
x123_temp = x123_fits[wsci].logT
x123_abund = x123_fits[wsci].abundance
x123_temp2 = x123_fits[wsci].logT_2
x123_fe_xxv_flux = x123_fits[wsci].fe_xxv_flux
x123_abund_fe_xxv = x123_fits[wsci].abundance_fe_xxv
x123_ca_xix_flux = x123_fits[wsci].ca_xix_flux
x123_abund_ca_xix = x123_fits[wsci].abundance_ca_xix
goes_temp_cmp = interpol( goes_data.logTemp, goes_time, sptime )

; save "result"
result = dblarr(11,num_sp)
result[0,*] = sptime
result[1,*] = x123_xrsb_cmp
result[2,*] = goes_xrsb_cmp
result[3,*] = x123_temp
result[4,*] = goes_temp_cmp
result[5,*] = x123_abund
result[6,*] = x123_temp2
result[7,*] = x123_fe_xxv_flux
result[8,*] = x123_abund_fe_xxv
result[9,*] = x123_ca_xix_flux
result[10,*] = x123_abund_ca_xix

LOOP_START:

flare_name = [ 'A', 'B', 'C', 'M', 'X' ]
ytitle='X123 XRS-B Band'
mtitle='MinXSS-'+fm_str

;
;   ****************************************************************
;	Plot results
;   ****************************************************************
;
  ; same plot as done by minxss_goes_ts.pro (so have reference of irradiance levels)
  plot1 = 'minxss'+fm_str+'_goes_ts_'+year_str+'-'+doy_str+'_'+doy2_str+'.eps'
  if doEPS ne 0 then begin
	print, 'Writing EPS plot to ', plot1
	eps2_p,plotdir+plot1
  endif
  setplot
  cc = rainbow(7)

  yrange4 = [1E-8,1E-3]
  ytitle4 = 'Irradiance (W/m!U2!N)'
  cs_goes = 2.0

  plot, result[0,*], result[1,*], psym=10, /nodata, xr=xrange, xs=1, /ylog, $
	yr=yrange4, ys=1, xtitle=xtitle, ytitle=ytitle4, title=mtitle
  oplot, result[0,*], result[1,*], psym=4, color=cc[3]
  oplot, goes_time, goes_data.xrsb, color=cc[0]

  dx = (!x.crange[1] - !x.crange[0])/10.
  xx = !x.crange[0] - dx
  my=2.
  for jj=0L,n_elements(flare_name)-1 do begin
    xyouts, xx, my * 10.^float(!y.crange[0] + jj), flare_name[jj], color=cc[0], charsize=cs_goes
  endfor
  x1 = !x.crange[0] + 2*dx
  y1 = 7E-5 & my1 = 3.
  xyouts, x1, y1, 'GOES XRS-B', charsize=cs_goes, color=cc[0]
  xyouts, x1, y1*my1, 'X123 XRS-B Band', charsize=cs_goes, color=cc[3]

  if doEPS ne 0 then send2 else read, 'Next ? ', ans

  ;
  ;	plot 1 a is like plot 1 but for XRS-A instead
  ;
  plot1a = 'minxss'+fm_str+'_goes-a_ts_'+year_str+'-'+doy_str+'_'+doy2_str+'.eps'
  if doEPS ne 0 then begin
	print, 'Writing EPS plot to ', plot1a
	eps2_p,plotdir+plot1a
  endif
  setplot
  cc = rainbow(7)

  yrange4a = [1E-9,1E-4]

  plot, result[0,*], x123_xrsa_cmp, psym=10, /nodata, xr=xrange, xs=1, /ylog, $
	yr=yrange4a, ys=1, xtitle=xtitle, ytitle=ytitle4, title=mtitle
  oplot, result[0,*], x123_xrsa_cmp, psym=4, color=cc[3]
  oplot, goes_time, goes_data.xrsa, color=cc[0]

  dx = (!x.crange[1] - !x.crange[0])/10.
  x1 = !x.crange[0] + 2*dx
  y1 = 7E-6 & my1 = 3.
  xyouts, x1, y1, 'GOES XRS-A', charsize=cs_goes, color=cc[0]
  xyouts, x1, y1*my1, 'X123 XRS-A Band', charsize=cs_goes, color=cc[3]

  if doEPS ne 0 then send2 else read, 'Next ? ', ans

  ;
  ;   plot 2  is  Temperature plot
  ;
  plot2 = 'minxss'+fm_str+'_goes_ts_'+year_str+'-'+doy_str+'_'+doy2_str+'_temperature.eps'
  if doEPS ne 0 then begin
	print, 'Writing EPS plot to ', plot2
	eps2_p,plotdir+plot2
  endif
  setplot
  cc = rainbow(7)

  yrange2 = [5.5,8.0]
  ytitle2 = 'log10(Temperature) [K]'
  cs_goes = 2.0

  plot, result[0,*], result[4,*], /nodata, xr=xrange, xs=1, $
	yr=yrange2, ys=1, xtitle=xtitle, ytitle=ytitle2, title=mtitle

  oplot, result[0,*], result[3,*], psym=4, color=cc[3]
  oplot, result[0,*], result[6,*], psym=4, color=cc[5]
  oplot, goes_time, goes_data.logTemp, color=cc[0]

  dx = (!x.crange[1] - !x.crange[0])/10.
  x1 = !x.crange[0] + 2.5*dx
  y1 = 5.6 & dy1 = 0.25
  xyouts, x1, y1, 'GOES Temp', charsize=cs_goes, color=cc[0],align=1.0
  xyouts, x1, y1+dy1, 'X123 Temp-1', charsize=cs_goes, color=cc[3], align=1.0
  xyouts, x1, y1+dy1, '  Temp-2', charsize=cs_goes, color=cc[5], align=0.0

  if doEPS ne 0 then send2 else read, 'Next ? ', ans

  ;
  ;   plot 3  is  Abundance plot
  ;
  plot3 = 'minxss'+fm_str+'_goes_ts_'+year_str+'-'+doy_str+'_'+doy2_str+'_abundance.eps'
  if doEPS ne 0 then begin
	print, 'Writing EPS plot to ', plot3
	eps2_p,plotdir+plot3
  endif
  setplot
  cc = rainbow(7)

  yrange3 = [0,4.0]
  ytitle3 = 'Abundance Factor'
  cs_goes = 2.0

  plot, result[0,*], result[5,*], /nodata, xr=xrange, xs=1, $
	yr=yrange3, ys=1, xtitle=xtitle, ytitle=ytitle3, title=mtitle

  xx = !x.crange[0] * 0.95 + !x.crange[1] * 0.05
  oplot, !x.crange, [1,1], line=1
  xyouts, xx, 1.1, 'Photospheric'
  oplot, !x.crange, [2.138,2.138], line=2
  xyouts, xx, 2.238, 'Coronal'

  ; scale log(goes) from 0 to 1.0
  goes_scaled = (alog10(goes_data.xrsb) + 8.0)*0.2
  oplot, goes_time, goes_scaled, color=cc[1]
  xyouts, xx, 0.7, 'GOES Scaled', charsize=cs_goes/1.2, color=cc[1]

  oplot, result[0,*], ((result[5,*] > yrange3[0]) < yrange3[1]), psym=1, color=cc[3]
  xx2 = !x.crange[0] * 0.4 + !x.crange[1] * 0.6
  xyouts, xx2, 3.6, 'Abundance (Si)', charsize=cs, color=cc[3]

  wgd1 = where(result[8,*] gt 0, numgd1)
  if (numgd1 gt 1) then begin
    oplot, result[0,wgd1], ((result[8,wgd1] > yrange3[0]) < yrange3[1]), psym=4, color=cc[6]
    xyouts, xx2, 2.8, 'Abundance Fe', charsize=cs, color=cc[6]
  endif

  wgd2 = where(result[10,*] gt 0, numgd2)
  if (numgd2 gt 1) then begin
    oplot, result[0,wgd2], ((result[10,wgd2] > yrange3[0]) < yrange3[1]), psym=5, color=cc[0]
    xyouts, xx2, 3.2, 'Abundance Ca', charsize=cs, color=cc[0]
  endif

  if doEPS ne 0 then send2 else read, 'Next ? ', ans

  ;
  ;   plot of  GOES XRS-B versus Temperature
  ;	  only plot if number of days is greater than 10
  ;			Add power law fit of Temperature versus GOES XRS-B magnitude
  ;
if (doDays ne 0) and (numDays gt 10) then begin
  ;
  ;  power law fit of Temperature versus GOES XRS-B magnitude
  ;		fit only above B2 level and with good X123 temperatures
  ;
  wgd = where( result[3,*] gt 5.7 and result[3,*] lt 7.7 )  ; sort out bad fits
  wgdall = wgd
  wfit = where( (result[2,*] gt 2E-7) and (result[3,*] gt 5.7) and (result[3,*] lt 7.7), numfit )
  if (numfit gt 10) then begin
    xgd = alog10(result[2,wgd])
    ygd = result[3,wgd]
    xfit = alog10(result[2,wfit])
    yfit = result[3,wfit]
    gtcoeff = poly_fit( xfit, yfit, 1, yfit=yfit1 )
    	; exclude 3-sigma bad points
	diff = abs(yfit-yfit1)
	wgood = where( diff lt 3.*stddev(diff), num_good )
	if (num_good gt 10) then begin
	  gtcoeff = poly_fit( xfit[wgood], yfit[wgood], 1, yfit=yfit2 )
	endif
    xfitlog = findgen(400)*0.01 - 8.  ; B2-M1 level
    xfitplot = 10.^xfitlog
    yfitplot = gtcoeff[0] + gtcoeff[1]*xfitlog
    ; exclude X123 temperature data in plot
    xall = alog10(result[2,*])
    yallfit = gtcoeff[0] + gtcoeff[1]*xall
    diffall = abs(result[3,*]-yallfit)
    wgdall = where( (result[3,*] gt 5.7) and (result[3,*] lt 7.7) and (diffall lt 3.*stddev(diff)) )
    print, ' '
    print, 'FIT RESULTS for   T = A * G^N where '
    print, '    A = ', 10.^gtcoeff[0], ' and N = ', gtcoeff[1]
    ;  replace below B2 with constant value
    tlow = median( ygd[where(xgd lt -6.699)] )
    wlow = where( yfitplot lt tlow )
    yfitplot[wlow] = tlow
    print, '    Low  Temperature = ', tlow, (10.^tlow)/1E6, ' MK'
    ; replace above M1 with constant value
    thigh = median( yfit[where(xfit gt -5)] )
    whigh = where( yfitplot gt thigh )
    yfitplot2 = yfitplot
    yfitplot2[whigh] = thigh
    print, '    High Temperature = ', thigh, (10.^thigh)/1E6, ' MK'
    print, ' '
  endif
  plot4 = 'minxss'+fm_str+'_goes_vs_temp_'+year_str+'-'+doy_str+'_'+doy2_str+'.eps'
  if doEPS ne 0 then begin
	print, 'Writing EPS plot to ', plot4
	eps2_p,plotdir+plot4
  endif
  setplot
  cc = rainbow(7)

  xrange4 = [1E-8,1E-4]
  xtitle4 = 'GOES XRS-B (W/m!U2!N)'
  cs_goes = 2.5
  dot

  plot, result[2,*], result[3,*], /nodata, psym=8, xr=xrange4, xs=1, /xlog, $
	yr=yrange2, ys=1, xtitle=xtitle4, ytitle=ytitle2, title=mtitle

  oplot, result[2,wgdall], result[3,wgdall], psym=4   ; X123 hot temperature
  oplot, result[2,*], result[4,*], psym=8, color=cc[0]  ; GOES XRS temperature
  wfull = where( (goes_time ge doy) and (goes_time le doy2) )
  ; oplot, goes_data[wfull].xrsb, goes_data[wfull].logT, psym=8, color=cc[0]

  oplot, 10.^!x.crange, alog10(2.E6)*[1,1], line=2, color=cc[0]  ; GOES 2MK reference

  if (numfit gt 10) then begin
    wlow = where( xfitplot lt 1E-5 )
    whi = where( xfitplot ge 1E-5 )
    oplot, xfitplot[wlow], yfitplot[wlow], thick=3, color=cc[3]
    oplot, xfitplot[whi], yfitplot[whi], thick=3, line=2, color=cc[3]
    oplot, xfitplot[whi], yfitplot2[whi], thick=3, line=2, color=cc[3]
    x3a = 3E-8 & x3b = 1.5E-6 & x3c = 3E-5
    y3 = 5.60
    xyouts, x3a, y3, '1.78 MK', align=0.5, color=cc[3], charsize=cs_goes
    xyouts, x3b, y3, 'T(K)=2.4x10!U9!N * XRS!U0.46!N ', align=0.5, color=cc[3], charsize=cs_goes
    xyouts, x3c, y3, '12.6 MK', align=0.5, color=cc[3], charsize=cs_goes
    ; add legend for the other lines too
    xyouts, x3c, alog10(2.5E6), '2 MK Ref', color=cc[0], align=0.5, charsize=cs_goes
    x4 = 2E-8 & mx = 1.2 & y4 = 7.7 & dy = 0.3 & dytxt = dy/5.
    oplot, x4*[1.,mx,mx^2,mx^3], y4*[1,1,1,1], psym=4
    xyouts, x4*mx^4, y4-dytxt, 'X123', charsize=cs_goes
    oplot, x4*[1.,mx,mx^2,mx^3], (y4-dy)*[1,1,1,1], psym=8, color=cc[0]
    xyouts, x4*mx^4, y4-dy-dytxt, 'GOES', color=cc[0], charsize=cs_goes
 endif

  dy = (!y.crange[1] - !y.crange[0])/10.
  yy = !y.crange[0] - dy
  mx=2.
  for jj=0L,n_elements(flare_name)-2 do begin
    xyouts, mx * 10.^float(!x.crange[0] + jj), yy, flare_name[jj], color=cc[0], charsize=cs_goes
  endfor

  if doEPS ne 0 then send2 else read, 'Next ? ', ans
endif  ;  end for if (doDays ne 0) for Plot #4

;  END OF LOOP
LOOP_END:
loopcnt += 1
if (loopcnt eq 1) and keyword_set(eps) then begin
	; make EPS files now
	print, ' '
	print, 'MAKING EPS FILES ...'
   doEPS = 1
   goto, LOOP_START
endif

if keyword_set(list_fit) and keyword_set(hour_range) then begin
  fit_hour = (doy1 - doy)*24.
  wsci2 = where( (fit_hour ge xrange[0]) and (fit_hour lt xrange[1]) and $
  				(sps_sum_1au gt SPS_SUM_MIN), num_sp2 )
  print, ' '
  print, 'X123 Fit Results for date = ', yyyydoy_str
  print, '  Hour  Temp1    EM1    Abund1     Temp2     EM2    Abund2'
  format='(F6.3,F6.2,E10.2,F8.3,F10.2,E10.2,F8.3)'
  for i=0L,num_sp2-1 do begin
    ii = wsci2[i]
	print, fit_hour[ii], x123_fits[ii].logt, x123_fits[ii].cor_density, x123_fits[ii].abundance, $
			x123_fits[ii].logt_2, x123_fits[ii].cor_density_2, x123_fits[ii].abundance_2, format=format
  endfor
  print, ' '
endif

if keyword_set(debug) then stop, 'DEBUG at end of minxss_goes_2temperature_fit ...'

end
