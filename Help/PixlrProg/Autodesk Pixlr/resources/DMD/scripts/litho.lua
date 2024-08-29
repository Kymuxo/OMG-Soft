--[[ PixlrCore ]]
function render ( process, patternDirectory, images ) 
   process:setSrcTileSize(256)
   process:setDstTileSize(256)

   resources = { }
   image = process:getImage(images[1])
   pattern = process:getPattern( patternDirectory, 'bayer1')
   
   pat = process:addImage(pattern,false, (0x1000 + 0x0100))
   scale = 0.5 
   scale_width = scale * image.width/pattern.width 
   scale_height = scale * image.height/pattern.height 
   buf = process:reserveBuffer()
   Mixer = process:getInstance('Mixer2','Mix2')
   Mixer:setParameter('scale_width',  scale_width) 
   Mixer:setParameter('scale_height', scale_height)
   Mixer:setParameter('intensity', 0.65) 
   process:addStage(Mixer, { images[1], pat }, buf)

   process:submit()

   process:unreserveBuffer(buf)
   process:releaseImage(pat)
   process:freeImageData(pattern)
end