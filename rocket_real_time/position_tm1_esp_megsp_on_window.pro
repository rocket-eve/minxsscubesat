pro position_tm1_esp_megsp_on_window, s3_time, s3_cnt, s3_esp1, s3_esp2, s3_esp3, s3_esp4, s3_esp5, s3_esp6, s3_esp7, s3_esp8, s3_esp9, $
  s4_time, s4_megsp1, s4_megsp2, $
  monitorSerialRefreshText, graphicInfo=graphicInfo

  t =         text(0.4, 0.95, 'ESP', FONT_SIZE = graphicInfo.fontSize + 6, FONT_COLOR = graphicInfo.blueColor)
  t =         text(0.6, graphicInfo.topLinePosition, 'ESP FPGA Time = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_time =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition, '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), 'Record Counter = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_cnt =    text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (1 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), 'Diode 1 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp1 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (2 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (3 * graphicInfo.textVSpacing), 'Diode 2 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp2 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (3 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), 'Diode 3 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp3 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (4 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), 'Diode 4 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp4 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (5 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (6 * graphicInfo.textVSpacing), 'Diode 5 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp5 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (6 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), 'Diode 6 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp6 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (7 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (8 * graphicInfo.textVSpacing), 'Diode 7 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp7 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (8 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (9 * graphicInfo.textVSpacing), 'Diode 8 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp8 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (9 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), 'Diode 9 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s3_esp9 =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (10 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.4, graphicInfo.topLinePosition - (11 * graphicInfo.textVSpacing), 'MEGS-P', FONT_SIZE = graphicInfo.fontSize + 6, FONT_COLOR = graphicInfo.blueColor)
  t =         text(0.6, graphicInfo.topLinePosition-(12 * graphicInfo.textVSpacing), 'MEGS-P FPGA Time = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

  ; MEGS-P stuff
  s4_time =   text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition-(12 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (13 * graphicInfo.textVSpacing), 'Diode 1 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s4_megsp1 = text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (13 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  t =         text(0.6, graphicInfo.topLinePosition - (14 * graphicInfo.textVSpacing), 'Diode 2 = ', ALIGNMENT = 1.0, FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)
  s4_megsp2 = text(0.6 + graphicInfo.textHSpacing, graphicInfo.topLinePosition - (14 * graphicInfo.textVSpacing), '--', FONT_SIZE = graphicInfo.fontSize, FONT_COLOR = graphicInfo.fontColor)

  monitorsSerialRefreshText = text(0.5, 0.0, 'Last full refresh: ' + JPMsystime(), COLOR = graphicInfo.blueColor, ALIGNMENT = 0.5,font_size=14)

  return
end
