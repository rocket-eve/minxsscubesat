;;	IDL 2 version for encapsulated post-script (EPS) files (no printing);	TNW   7/93;PRO EPS2_P, thefilename, _extra=extra_keys	common qmsinfo, delete_f, type, org_type, filename, pcolor, pbackground	; Save the plotting color and background to restore later in send2.pro	pcolor = !P.COLOR	pbackground = !P.BACKGROUND	delete_f = ' '	;save the file !	org_type = !d.name	SET_PLOT, 'PS'	if n_params(0) eq 0 then begin	;nosave           filename="idl.eps"	endif else begin           filename=theFileName	endelse        device, /encapsulated, /color, /portrait, filename=filename,$		preview=1		;_extra=extra_keys, preview=2		; /landscape,   (not needed for eps files)	;tvlct,	[0,  0,255,  0,255,255,  0], $	;	[0,  0,  0,255,255,  0,255], $	;	[0,255,  0,  0,  0,255,255]		type = 'EPS'	returnend