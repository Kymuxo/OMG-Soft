--[[ PixlrCore ]]
function render (process, patternDir, images)
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   RGB2Lab = process:getInstance('ConvertRGB2Lab','RGB2Lab') 
   Lab2RGB = process:getInstance('ConvertLab2RGB','Lab2RGB') 
   Canvas2 = process:getInstance('Canvas2','Can2') 

   pattern = process:getPattern(patternDir, 'oil2') 
   hpat = process:addImage(pattern, false,  (0x1000 + 0x0100))
   lab = process:reserveBuffer()
   rgb = process:reserveBuffer()
   buf = process:reserveBuffer()
   
   process:addStage(RGB2Lab, { images[1] }, lab)

   Bilateral0 = process:getInstance('BilateralSTX','BilaterialSTXH')
   Bilateral0:setParameter('threshold', 0.01) 
   Bilateral0:setParameter('spread', { 5.5, 0.0 }) 

   Bilateral1 = process:getInstance('BilateralSTX','BilateralSTXV')
   Bilateral1:setParameter('threshold', 0.01) 
   Bilateral1:setParameter('spread', { 0.0, 5.5 }) 
   
   for i = 0, 4, 1 do
      process:addStage(Bilateral0, { lab }, buf)
      process:addStage(Bilateral1, { buf }, lab)
   end
   process:addStage(Lab2RGB, { lab }, rgb)
   dd = 128.0/256.0
   dh = dd/2.0

   scale = 0.5 
   image = process:getImage(images[1])
   scale_width = image.width/pattern.width 
   scale_height = image.height/pattern.height 
   Canvas2:setParameter('scale_width', scale * scale_width) 
   Canvas2:setParameter('scale_height', scale * scale_height) 
   Canvas2:setParameter('threshold', 0.7) 
   Canvas2:setParameter('strength', 0.54)  
   Canvas2:setParameter('swirl', 0.2) 
   
   process:addStage(Canvas2, { 0.5 - dh, 0.5 - dh, 0.5 + dh, 0.5 + dh }, { rgb, hpat }, buf, {0.0, 0.0, dd, dd } )

   process:submit()

   process:freeImageData(pattern);
   process:releaseImage(hpat)
   process:unreserveBuffer(lab)
   process:unreserveBuffer(rgb)
   process:unreserveBuffer(buf)
end