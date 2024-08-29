--[[ PixlrCore ]]
function render ( process, patternDir, images ) 
   process:setSrcTileSize(256)
   process:setDstTileSize(256)

   color = { 75.0/255.0, 75.0/255.0, 75.0/255.0 } 
   pattern = process:getPattern(patternDir, 'hash2') 
   image = process:getImage(images[1])
   pat = process:addImage(pattern, false, (0x1000 + 0x0100))
   scale = 2.0 
   scale_width = scale * image.width/pattern.width 
   scale_height = scale * image.height/pattern.height 
   Mixer = process:getInstance('Mixer3','Mix3') 

   Mixer:setParameter('scale_width', scale_width) 
   Mixer:setParameter('scale_height', scale_height) 
   Mixer:setParameter('threshold', 1.3) 
   Mixer:setParameter('intensity', 0.7) 
   Mixer:setParameter('color', color) 
   buf = process:reserveBuffer()
   process:addStage(Mixer, { images[1], pat }, buf)

   process:submit()

   process:unreserveBuffer(buf)
   process:releaseImage(pat)
   process:freeImageData(pattern)
end 