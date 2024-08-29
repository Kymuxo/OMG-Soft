--[[ PixlrCore ]]
function render ( process, patternDir, images )
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   RGB2Lab = process:getInstance('ConvertRGB2Lab','RGB2Lab') 
   Lab2RGB = process:getInstance('ConvertLab2RGB','Lab2RGB') 
   
   lab = process:reserveBuffer()
   rgb = process:reserveBuffer()
   buf = process:reserveBuffer()
   
   process:addStage(RGB2Lab, { images[1] }, lab)

   Bilateral0 = process:getInstance('BilateralSTX','BilaterialSTXH')
   Bilateral0:setParameter('threshold', 0.01) 
   Bilateral0:setParameter('spread', { 5.4, 0.0 }) 

   Bilateral1 = process:getInstance('BilateralSTX','BilateralSTXV')
   Bilateral1:setParameter('threshold', 0.01) 
   Bilateral1:setParameter('spread', { 0.0, 5.4 }) 
   
   for i = 0, 1, 5 do
      process:addStage(Bilateral0, { lab }, buf)
      process:addStage(Bilateral1, { buf }, lab)
   end
   dd = 128.0/256.0
   dh = dd/2.0
   process:addStage(Lab2RGB, { 0.5 - dh, 0.5 - dh, 0.5 + dh, 0.5 + dh }, { lab }, rgb, { 0.0, 0.0, dd, dd })

   process:submit()

   process:unreserveBuffer(lab)
   process:unreserveBuffer(rgb)
   process:unreserveBuffer(buf)
end 