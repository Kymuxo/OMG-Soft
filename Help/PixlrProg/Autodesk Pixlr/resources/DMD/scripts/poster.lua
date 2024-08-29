--[[ PixlrCore ]]
function render ( process, patternDir, images)
   process:setSrcTileSize(256)
   process:setDstTileSize(256)

   col_top = { 251, 224, 196 }
   col_middle = { 220, 118, 16 }
   col_bottom = { 136, 0, 21 }
   int2float(col_top,col_top)
   int2float(col_middle, col_middle)
   int2float(col_bottom, col_bottom)
   buf = process:reserveBuffer()
   QuantizeRGB5 = process:getInstance('QuantizeRGB5','QuantRGB5')
   QuantizeRGB5:setParameter('threshold_top', 0.5)
   QuantizeRGB5:setParameter('threshold_bottom', 0.25) 
   QuantizeRGB5:setParameter('color_top', col_top) 
   QuantizeRGB5:setParameter('color_middle', col_middle)
   QuantizeRGB5:setParameter('color_bottom', col_bottom) 
   process:addStage(QuantizeRGB5, { images[1] }, buf)

   process:submit()

   process:unreserveBuffer(buf)
end