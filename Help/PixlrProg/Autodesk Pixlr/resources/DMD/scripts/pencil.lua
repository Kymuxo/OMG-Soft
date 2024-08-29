--[[ PixlrCore ]]
function render (process, patternDir, images) 
   process:setSrcTileSize(256)
   process:setDstTileSize(256)
   h3 = process:reserveBuffer()
   h1 = process:reserveBuffer() 
   h2 = process:reserveBuffer()
   pattern = process:getPattern(patternDir, 'pencil2')
   image = process:getImage(images[1])
   print('pattern:', pattern.width,'x' ,pattern.height)
   pat = process:addImage(pattern, false, (0x1000 + 0x0100))
   scale_width = image.width/pattern.width 
   scale_height = image.height/pattern.height  
   scale = 1.0  
   Mixer4a = process:getInstance('Mixer4', 'Mixer4a') 
   Mixer4a:setParameter('scale_width', scale*scale_width) 
   Mixer4a:setParameter('scale_height', scale*scale_height) 
   Mixer4a:setParameter('image_brightness', 1.1)
   Mixer4a:setParameter('pattern_brightness', 0.8) 
   Mixer4a:setParameter('pattern_rotation', 0.0)
   process:addStage(Mixer4a, { images[1] , pat }, h1) 

   scale = 0.7  
   Mixer4b = process:getInstance('Mixer4','Mixer4b')
   Mixer4b:setParameter('scale_width', scale*scale_width) 
   Mixer4b:setParameter('scale_height', scale*scale_height) 
   Mixer4b:setParameter('image_brightness', 1.1) 
   Mixer4b:setParameter('pattern_brightness', 0.8) 
   Mixer4b:setParameter('pattern_rotation', 1.6)
   process:addStage(Mixer4b, { images[1], pat }, h2);

   Mixer5 = process:getInstance('Mixer5','Mixer5a')  
   process:addStage(Mixer5, { h1, h2 }, h3 )

   process:submit()
   
   process:unreserveBuffer(h1)
   process:unreserveBuffer(h2)
   process:unreserveBuffer(h3)
   process:releaseImage(pat)
   process:freeImageData(pattern)
end