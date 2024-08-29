--[[ PixlrCore ]]
function render ( process, patternDir, images )   
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   buf = process:reserveBuffer()   
   image = process:getImage(images[1])   
   Stipple = process:getInstance('Stipple1','Stip1')     
   Stipple:setParameter('tile',1.0/256.0)
   Stipple:setParameter('delta',1.0/image.width)    
   Stipple:setParameter('light', 1.5)    
   dd = 128.0/ 256.0
   dh = dd/2.0
   process:addStage(Stipple, { 0.5 - dh, 0.5 - dh, 0.5 + dh, 0.5 + dh}, { images[1] }, buf , { 0.0, 0.0, dd, dd })   
   process:submit()   
   process:unreserveBuffer(buf)
end