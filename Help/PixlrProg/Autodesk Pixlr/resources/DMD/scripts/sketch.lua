--[[ PixlrCore ]]
function Blur (process, BlurH, BlurV, sigma, k, bufa, bufb, bufc) 
   worg =  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};   
   w = { 0.0, 0.0, 0.0 };  
   o = { 0.0, 0.0, 0.0 };  
   norm = 0.0;      
   sig = sigma*k   
   c =  -1.0/(2.0*sig*sig)   
   for i = 1, 6, 1 do      
      worg[i] = math.exp((i)*(i)*c);      
      norm = norm + worg[i];   
   end      
   norm = 2.0*norm + 1.0;      
   for i = 0, 2, 1 do      
      w[i + 1] = worg[2*i + 1] + worg[2*i + 1 + 1];     
      t = worg[2*i + 1 + 1]/w[i + 1];      
      o[i + 1] = (1.0 + 2.0*i)*(1.0 - t) + 2.0*(i + 1.0)*t;   
   end  
   BlurH:setParameter('o1',o[1])  
   BlurH:setParameter('o2',o[2])   
   BlurH:setParameter('o3',o[3])   
   BlurH:setParameter('w1',w[1])   
   BlurH:setParameter('w2',w[2])   
   BlurH:setParameter('w3',w[3])   
   BlurH:setParameter('dir',{ 1.0, 0.0 })   
   BlurH:setParameter('norm', norm)    
   process:addStage(BlurH, { bufa }, bufb)   
   BlurV:setParameter('o1',o[1])   
   BlurV:setParameter('o2',o[2])  
   BlurV:setParameter('o3',o[3])   
   BlurV:setParameter('w1',w[1])   
   BlurV:setParameter('w2',w[2])   
   BlurV:setParameter('w3',w[3])  
   BlurV:setParameter('dir',{ 0.0, 1.0 })
   BlurV:setParameter('norm', norm)   
   process:addStage(BlurV, { bufb }, bufc)
end 
function 
   GBlur(process, BlurH, BlurV, sigma, bufa, bufb, bufc)  
   c = -1.0/(2.0*sigma*sigma);
   w1 = math.exp(1.0*c);
   w2 = math.exp(4.0*c); 
   norm = 1.0 + 2.0*(w1 + w2); 
   BlurH:setParameter('w1', w1)   
   BlurH:setParameter('w2', w2) 
   BlurH:setParameter('norm', norm)   
   BlurH:setParameter('dir', {1.0, 0.0} )  
   process:addStage(BlurH, { bufa }, bufb)  
   BlurV:setParameter('w1', w1)  
   BlurV:setParameter('w2', w2)  
   BlurV:setParameter('norm', norm)   
   BlurV:setParameter('dir', {0.0, 1.0} )  
   process:addStage(BlurV, { bufb }, bufc)
end 

function render ( process, patternDir, images )  
   process:setSrcTileSize(256)
   process:setDstTileSize(128)

   RGB2Lab = process:getInstance('ConvertRGB2Lab','RGB2Lab')  
   BlurH = process:getInstance('GaussianS5X','Gaussian_Vert') 
   BlurV = process:getInstance('GaussianS5X','Gaussian_Horiz')  
   GBlurH1 = process:getInstance('GaussianSL13X','GaussianSL13XH1')  
   GBlurV1 = process:getInstance('GaussianSL13X','GaussianSL13XV1')
   GBlurH2 = process:getInstance('GaussianSL13X','GaussianSL13XH2')  
   GBlurV2 = process:getInstance('GaussianSL13X','GaussianSL13XV2') 
   Mixer = process:getInstance('XDoGX3M','XDoGX3Mi')  
   lab = process:reserveBuffer()  
   buf1 = process:reserveBuffer()  
   buf2 = process:reserveBuffer() 
   buf3 = process:reserveBuffer()  
   process:addStage(RGB2Lab, { images[1] }, buf1)    
   for i = 0, 2, 1 do 
      GBlur(process, BlurH, BlurV, 1.0, buf1, buf2, buf1)  
   end  
   Blur(process, GBlurH1, GBlurV1, 1.0, 1.0, buf1, buf3, buf2)  
   Blur(process, GBlurH2, GBlurV2, 1.0, 1.6, buf1, buf3, buf1)
   Mixer:setParameter('p', 29.0)  
   Mixer:setParameter('e', 50.0) 
   Mixer:setParameter('phi', 0.7)  
   dd = 128.0/256.0
   dh = dd/2.0
   process:addStage(Mixer, { 0.5 - dh, 0.5 - dh, 0.5 + dh, 0.5 + dh }, { buf2, buf1 }, buf3, {0.0, 0.0, dd, dd} ) 
   process:submit()  
   process:unreserveBuffer(lab) 
   process:unreserveBuffer(buf1) 
   process:unreserveBuffer(buf2)
   process:unreserveBuffer(buf3)
end
