--[[ PixlrCore ]]
function render ( process, patternDir, images )
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   Color1 = process:getInstance('Color1','col1') 
   Canvas2 = process:getInstance('Canvas2','Can2') 
   pattern = process:getPattern(patternDir, 'oil2') 
   image = process:getImage(images[1])
   hpat = process:addImage(pattern, false, (0x1000 + 0x0100))
   buf1 = process:reserveBuffer() 
   buf2 = process:reserveBuffer() 
   buf3 = process:reserveBuffer() 
   color =  { 255, 255, 255 }
   Color1:setParameter('color', color) 
   process:addStage(Color1, { }, buf1 )

   start_t = 0.001 
   end_t = 0.13 
   start_s = 100.0/image.width 
   end_s = 7.0/image.width
   iter = 3  
   step_t = (end_t - start_t) / iter
   step_s = (end_s - start_s) / iter 
   s = start_s 
   
   for i=0, iter do  
      t = start_t + i * step_t 
      name = string.format('Paint1_%d',i)
      Paint1 = process:getInstance('Paint1', name) 
      Paint1:setParameter('threshold', t) 
      Paint1:setParameter('tile_size', s) 
      process:addStage(Paint1, { buf1, images[1] }, buf2)
      tmp = buf1
      buf1 = buf2
      buf2 = tmp
      s = s + step_s  
   end  
   scale = 0.5
   image = process:getImage(images[1]);
   scale_width = image.width / pattern.width 
   scale_height = image.height / pattern.height 
   Canvas2:setParameter('scale_width', scale * scale_width) 
   Canvas2:setParameter('scale_height', scale * scale_height) 
   Canvas2:setParameter('threshold', 0.7) 
   Canvas2:setParameter('strength', 0.254) 
   Canvas2:setParameter('swirl', 0.2)  
   d = 128.0/256.0;
   d2 = d/2.0
   process:addStage(Canvas2, {0.5 - d2, 0.5 - d2, 0.5 + d2, 0.5 + d2 }, { buf1, hpat }, buf2, { 0.0, 0.0, d, d } )

   process:submit()

   process:unreserveBuffer(buf1)
   process:unreserveBuffer(buf2)
   process:unreserveBuffer(buf3)
   process:releaseImage(hpat)
   process:freeImageData(pattern)
end