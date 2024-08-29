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

function GBlur(process, BlurH, BlurV, sigma, bufa, bufb, bufc)
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

function render (process, patternDir, images)
   process:setSrcTileSize(256)
   process:setDstTileSize(128)
   dd = 128.0/256.0
   dh = dd/2

   RGB2Lab = process:getInstance('ConvertRGB2Lab','RGB2Lab') 
   Lab2RGB = process:getInstance('ConvertLab2RGB','Lab2RGB') 
   BlurH = process:getInstance('GaussianS5X','GaussianS5XH') 
   BlurV = process:getInstance('GaussianS5X','GaussianS5XV') 
   GBlurH1 = process:getInstance('GaussianSL13X','GaussianSL13XH1') 
   GBlurV1 = process:getInstance('GaussianSL13X','GaussianSL13XV1') 
   GBlurH2 = process:getInstance('GaussianSL13X','GaussianSL13XH2') 
   GBlurV2 = process:getInstance('GaussianSL13X','GaussianSL13XV2') 
   Mix = process:getInstance('XDoGX1M','Mix')

   lab = process:reserveBuffer()
   buf = process:reserveBuffer()
   lab1 = process:reserveBuffer()
   lab2 = process:reserveBuffer()

   process:addStage(RGB2Lab, { images[1] }, lab)

   GBlur(process, BlurH, BlurV, 1.0, lab, buf, lab)
   Blur(process, GBlurH1, GBlurV1, 0.8, 1.0, lab, buf, lab1)
   Blur(process, GBlurH2, GBlurV2, 0.8, 1.6, lab, buf, lab2)

   Mix:setParameter('p', 35.0)
   Mix:setParameter('e', 30.0)
   Mix:setParameter('color', { 0.0, 0.0, 0.0 })
   
   process:addStage(Mix, {0.5 - dh, 0.5 - dh, 0.5 + dh, 0.5 + dh }, { lab1, lab2 }, lab, { 0.0, 0.0, dd, dd })

   process:submit()

   process:unreserveBuffer(lab)
   process:unreserveBuffer(lab1)
   process:unreserveBuffer(lab2)
   process:unreserveBuffer(buf)
end