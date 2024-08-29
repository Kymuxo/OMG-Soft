local theUI = {}
local resolutionFactor = 1.0


function InCanvasUI()
    return theUI
end

function initializeUI()

	-- initialize resolution factor
	ak.updateResolutionFactor()

	-- init resolution factor
	local r = ak.getSessionPropertyValue( "ak.resolution.factor" )
	resolutionFactor = r[1] / 100

    require( "Animation" )
    require( "LuaWidgets" )
    require( "ColorEditor" )
    
    -- create color editor
    initColorEditor()
    
end


function convertUnit( i )
	return i * resolutionFactor
end

-- let's collect garbage to make sure that we're not expecting the persistence of any data that's marked for collection
--collectgarbage()

initializeUI()
