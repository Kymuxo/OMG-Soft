--[[ PixlrCore ]]
function render ( process, patternDir, images )  
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   Pix3 = process:getInstance('Pixelate3','Poly')    
   image = process:getImage(images[1])  
   a = image.width    
   if image.width < image.height then       
      a = image.height   
   end   
   Pix3:setParameter('tile_size', 1.0/186.0 )   
   buf = process:reserveBuffer()   

   process:addStage(Pix3, { 0.25, 0.25, 0.75, 0.75 }, { images[1] } , buf, { 0.0, 0.0, 0.5, 0.5 })

   process:submit()

   process:unreserveBuffer(buf)
end