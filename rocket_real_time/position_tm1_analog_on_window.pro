;+
;
; This procedure populates the active window with a collection of string objects.
; The string objects created here are in the argument list and can be used by the
; caller.
;
; Placement is controlled through a set of variable passed into the graphicInfo structure.
;
; DLW 04/12/23 Created
;-
pro position_tm1_analog_on_window, ta23, ta124, ta106, ta82, ta25, ta26, ta13, ta14, ta22, ta29, ta30, $
                                   ta3, ta15, ta19, ta20, ta19b, ta20b, ta31, ta32, ta1, $
                                   monitorsRefreshText, $
                                   graphicInfo=graphicInfo

  ; Left column
t =     text(0.25, 0.95, 'Payload', FONT_SIZE = graphicInfo.fontSize + 6, FONT_COLOR = graphicInfo.blueColor)
t =     text(0.35, graphicInfo.topLinePosition, 'Exp +28V Monitor = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta23 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition, '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

t =     text(0.35, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), 'TM Exp Batt Volt [V] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta124 = text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), 'TM Exp Bus Curr [A] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta106 = text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), 'Shutter Door = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta82 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), 'Vac Valve Position = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta25 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (6 * graphicInfo.textVSpacing), 'HVS Pressure = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta26 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (6 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), 'Solar Section Pressure = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta13 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (9 * graphicInfo.textVSpacing), 'Cryo Cold Finger Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta14 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (9 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), 'Cryo Hot Side Temp [ºC] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta22 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (12 * graphicInfo.textVSpacing), 'FPGA +5V Monitor [V] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta29 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (12 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.35, graphicInfo.topLinePosition - (13 * graphicInfo.textVSpacing), 'Camera Charger [V] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta30 =  text(0.35 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (13 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

; Right column
t =     text(0.75, 0.95, 'MEGS', FONT_SIZE = graphicInfo.fontSize + 6, FONT_COLOR = graphicInfo.blueColor)
t =     text(0.8, graphicInfo.topLinePosition, 'MEGS A Heater = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta3 =   text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition, '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), 'MEGS B Heater = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta15 =  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), 'MEGS A CCD PRT Temp [C] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta19 =  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (3 * graphicInfo.textVSpacing), 'MEGS B CCD PRT Temp [C] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta20 =  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (3 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

t =     text(0.8, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), 'MEGS A CCD Diode Temp [C] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta19b=  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), 'MEGS B CCD Diode Temp [C] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta20b=  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

t =     text(0.8, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), 'MEGS A FF Lamp = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta31 =  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (8 * graphicInfo.textVSpacing), 'MEGS B FF Lamp = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta32 =  text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (8 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
t =     text(0.8, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), 'MEGS-P Temp [C] = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
ta1 =   text(0.8 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

monitorsRefreshText = text(0.5, 0.0, 'Last full refresh: ' + jpmsystime(), COLOR = graphicInfo.blueColor, ALIGNMENT = 0.5,font_size=14)

return
end
