pro draw_test

p = plot(/test)
p.title = 'bla title' 
p.xtitle='bla xtitle'

t=text(/norm, 0.5, 0.25, 'Text')
tfont_size=16

x=systime(1)
for i = 0, 500 do begin
  ;p.title = strtrim(i, 2) + 'efgh'
  t.string=strtrim(i,2)
  ;p.xtitle = strtrim(i, 2) + 'abcd'
endfor
print, systime(1) - x,' sec to change text ' + strtrim(i,2)+' loops'
ups = strtrim(float(i)/(systime(1)-x),2) + ' text updates per second'
print, ups

;print, 'new graphics'
;p = plot(findgen(10))
;x=systime(1)
;for i = 0, 500 do begin
;  p.setData, findgen(10)
;endfor
;print, systime(1) - x
;print, float(i)/(systime(1)-x)
;
;
;plot, findgen(10)
;print, 'old graphics'
;plot, findgen(10)
;x=systime(1)
;for i = 0, 500 do begin
;  plot, findgen(10)
;endfor
;print, systime(1) - x
;print, float(i)/(systime(1)-x)

end