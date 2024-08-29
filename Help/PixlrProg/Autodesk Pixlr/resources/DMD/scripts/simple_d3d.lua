--[[ PixlrCore ]] 
function render(process, patternDir, images) 
	process:setSrcTileSize(256) 
	process:setDstTileSize(256) 
	f = process:getFilter('simple_d3d') 
--	color = { 255, 0, 0 } 
--	f:setParameter('color',color) 
	buf = process:reserveBuffer() 
	process:addStage(f, { images[1] }, buf) 
	process:submit() 
	process:unreserveBuffer(buf) 
end