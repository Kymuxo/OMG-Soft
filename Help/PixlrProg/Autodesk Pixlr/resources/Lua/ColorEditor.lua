local dragBeginX = 0
local dragBeginY = 0
local offsetX = 0
local offsetY = 0

local colorWheelCenterX = convertUnit(160)
local colorWheelCenterY = convertUnit(95)
local wheelRadius = convertUnit(52)

local diamondSize = convertUnit(78)
local slRange = 100

local wheelIndicator
local dimaondIndicator

local bkgdW

local cachedRGB = { 1, 1, 1, 1 }
local cachedHSB = { 1, 1, 1, 1 }

local WheelColorBackground = nil
local WheelOldColorBackground = nil
local GradientDiamondBackground = nil


-- ///////////////////////////////////////////////////
-- call this function to close color editor
-- ///////////////////////////////////////////////////
function closeColorEditor()
    InCanvasUI().colorEditor.visible = false
end


-- ///////////////////////////////////////////////////
-- call this function to open color editor
-- ///////////////////////////////////////////////////
function openColorEditor()
    -- set active color to UI
    local c = ak.getSessionPropertyValue( "ak.color" )
    setColorRGB( c[1], c[2], c[3], c[4] )

    InCanvasUI().colorEditor.visible = true

	ak.closeEyeDropper()
end


-- ///////////////////////////////////////////////////////////////
-- update the color editor whenever it's triggered from C++ code
-- ///////////////////////////////////////////////////////////////
function ColorEditorNotification()
    local c = ak.getSessionPropertyValue( "ak.color" )
    setColorRGB( c[1], c[2], c[3], c[4] )
end

function ColorEditorUpdateOldColorNotification()
	updateOldColor()
end

function ColorEditorIsVisible()
	return InCanvasUI().colorEditor.visible
end


-- ///////////////////////////////////////////////////
-- create color editor
-- ///////////////////////////////////////////////////
function initColorEditor ()
    if( InCanvasUI().colorEditor ~= NULL ) then
        return
    end
    
    local reg = akSupport.ci(akSupport.Registry)
    reg.setKey("ak.ColorEditor.update", ColorEditorNotification )
    reg.setKey("ak.ColorEditor.updateOldColor", ColorEditorUpdateOldColorNotification )
	reg.setKey("ak.ColorEditor.isVisible", ColorEditorIsVisible )
	

    -- ColorEditorNotification
    -- create a backgd button
    -- //////////////////////////////////////////////
    local background = CreateButton{
                            identifier = "ColorEditorBackground",
                            images = {default="ColorEditor//CE_background"},
                            backgroundColor = {0.0,0.0,0.0,0.0}
                       }

    bkgdW = background.imagesWidth
    local bkgdH = background.imagesHeight
	background.width = bkgdW
	background.height = bkgdH
    colorWheelCenterX = bkgdW/2
	

    -- //////////////////////////////////////////////
    -- eye dropper button
    -- //////////////////////////////////////////////
	local eyeDropper = CreateButton{
                        identifier = "ColorEditorEyeDropper",
                        images = { default="ColorEditor//CE_eyedrop", 
								   backgroundHover = "ColorEditor//CE_eyedrop_hover"},
                        onClick = function()
										ak.openEyeDropper()
										closeColorEditor()
                                    end,
                        backgroundColor = {0.0,0.0,0.0,0.0} 
                    }
	eyeDropper.hitTestIgnoresAlpha = true
	eyeDropper.width = eyeDropper.imagesWidth
	eyeDropper.height = eyeDropper.imagesHeight
	eyeDropper.rightTack = {1.0,-3}
	eyeDropper.top = 3


	-- //////////////////////////////////////////////
    -- color wheel background
    -- //////////////////////////////////////////////
    local wheelBackground = CreateButton{
                                identifier = "ColorEditorWheelBackground",
                                images = {default="ColorEditor//CE_palette_ring"},
                                onClick = function(btn, pt)
                                                local viewPt = akHUD.screenToView( background, pt )
                                                local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
                                                local angle = getAngleFromXY( delta )
                                                local hue = getHueFromAngle( angle )
                                                setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
												updateOldColor()
                                            end,
                                backgroundColor = {0.0,0.0,0.0,0.0} 
                            }

	local wheelBackgroundW = wheelBackground.imagesWidth
	local wheelBackgroundH = wheelBackground.imagesHeight
	wheelBackground.width = wheelBackgroundW
	wheelBackground.height = wheelBackgroundH
	colorWheelCenterY = wheelBackgroundH/2 + (bkgdW-wheelBackgroundW)/2
    wheelBackground.left = colorWheelCenterX - (wheelBackgroundW/2)
    wheelBackground.top = colorWheelCenterY - (wheelBackgroundH/2)

	wheelBackground.onDragBegin =	function( btn, pt )
										local viewPt = akHUD.screenToView( background, pt )
										local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
										local angle = getAngleFromXY( delta )
										local hue = getHueFromAngle( angle )
										setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
                                    end
    wheelBackground.onDrag =		function( btn, pt )
										local viewPt = akHUD.screenToView( background, pt )
										local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
										local angle = getAngleFromXY( delta )
										local hue = getHueFromAngle( angle )
										setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
									end
    wheelBackground.onDragEnd =		function( btn, pt )
										updateOldColor()
									end


    -- //////////////////////////////////////////////
    -- color gradient diamond 
    -- //////////////////////////////////////////////
    local gradientDiamond = CreateButton{
                                identifier = "ColorWheelGradientDiamond",
                                images = {default="ColorEditor//CE_palette_diamond"},
                                onClick = function(btn, pt )
                                                local viewPt = akHUD.screenToView( background, pt )
                                                local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
                                                local sl = getSLFromXY( delta )
                                                setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
												updateOldColor()
                                            end,
                                backgroundColor = {0.0,0.0,0.0,0.0} 
                            }

	local gradientDiamondW = gradientDiamond.imagesWidth
	local gradientDiamondH = gradientDiamond.imagesHeight
	gradientDiamond.width = gradientDiamondW
	gradientDiamond.height = gradientDiamondH
    gradientDiamond.left = colorWheelCenterX - (gradientDiamondW/2)
    gradientDiamond.top = colorWheelCenterY - (gradientDiamondH/2)
    gradientDiamond.onDragBegin =	function( btn, pt )
										local viewPt = akHUD.screenToView( background, pt )
										local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
										local sl = getSLFromXY( delta )
										setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
										updateOldColor()
									end
    gradientDiamond.onDrag =		function( btn, pt )
										local viewPt = akHUD.screenToView( background, pt )
										local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
										local sl = getSLFromXY( delta )
										setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
									end
    gradientDiamond.onDragEnd =		function( btn, pt )
										updateOldColor()
									end


    -- //////////////////////////////////////////////
    -- color diamond indicator
    -- //////////////////////////////////////////////
    diamondIndicator = CreateButton{
							identifier = "ColorEditorDiamondIndicator",
							images = {default="ColorEditor//CE_palette_indicator"},
							onClick = function()
											local viewPt = akHUD.screenToView( background, pt )
											local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
											local sl = getSLFromXY( delta )
											setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
											updateOldColor()
										end,
							backgroundColor = {0.0,0.0,0.0,0.0}
						}
    diamondIndicator.onDragBegin = function( btn, pt )
									local viewPt = akHUD.screenToView( background, pt )
									local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
									local sl = getSLFromXY( delta )
									setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
									updateOldColor()
                            end
    diamondIndicator.onDrag = function( btn, pt )
                                local viewPt = akHUD.screenToView( background, pt )
                                local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
                                local sl = getSLFromXY( delta )
                                setColorHSB( cachedHSB[1], sl[1], sl[2], cachedHSB[4] )
                            end
    diamondIndicator.onDragEnd = function( btn, pt )
									updateOldColor()
								end

	diamondIndicator.width = diamondIndicator.imagesWidth
	diamondIndicator.height = diamondIndicator.imagesHeight
    diamondIndicator.left = 0.0
    diamondIndicator.top = 0.0


    -- //////////////////////////////////////////////
    -- color wheel indicator
    -- //////////////////////////////////////////////
    wheelIndicator = CreateButton{
                        identifier = "ColorEditorWheelIndicator",
                        images = {default="ColorEditor//CE_palette_indicator"},
                        onClick = function()	
										local viewPt = akHUD.screenToView( background, pt )
										local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
										local angle = getAngleFromXY( delta )
										local hue = getHueFromAngle( angle )
										setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
										updateOldColor()
                                    end,
                        backgroundColor = {0.0,0.0,0.0,0.0} 
                    }
    wheelIndicator.onDragBegin = function( btn, pt )
									local viewPt = akHUD.screenToView( background, pt )
									local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
									local angle = getAngleFromXY( delta )
									local hue = getHueFromAngle( angle )
									setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
									updateOldColor()
                            end
    wheelIndicator.onDrag = function( btn, pt )
                                local viewPt = akHUD.screenToView( background, pt )
                                local delta = { viewPt[1] - colorWheelCenterX, colorWheelCenterY - viewPt[2] }
                                local angle = getAngleFromXY( delta )
                                local hue = getHueFromAngle( angle )
                                setColorHSB( hue, cachedHSB[2], cachedHSB[3], cachedHSB[4] )
                            end
    wheelIndicator.onDragEnd = function( btn, pt )
									updateOldColor()
								end

	wheelIndicator.width = wheelIndicator.imagesWidth
	wheelIndicator.height = wheelIndicator.imagesHeight
    wheelIndicator.left = 0.0
    wheelIndicator.top = 0.0


    -- //////////////////////////////////////////////
    -- color gradient diamond solid color background
    -- //////////////////////////////////////////////
	GradientDiamondBackground = CreateImageView{
                                    identifier = "GradientDiamondBackground",
                                    image = "ColorEditor//CE_palette_diamond"
                                }
	GradientDiamondBackground.mask = "ColorEditor//CE_palette_diamond_mask"


    -- //////////////////////////////////////////////
    -- current color widget
    -- //////////////////////////////////////////////
	WheelColorBackground = CreateImageView{
                                    identifier = "ColorWheelMask",
                                    image = "ColorEditor//CE_wheel_frame"
                                }
	WheelColorBackground.mask = "ColorEditor//CE_wheel_mask"


    -- //////////////////////////////////////////////
    -- old color widget
    -- //////////////////////////////////////////////
	WheelOldColorBackground = CreateImageView{
                                    identifier = "ColorWheelOldColorMask",
                                    image = "ColorEditor//CE_wheel_frame"
                                }
	WheelOldColorBackground.mask = "ColorEditor//CE_wheel_oldcolor_mask"


    -- //////////////////////////////////////////////
    -- color editor
    -- //////////////////////////////////////////////
    local colorEditor = akHUD.View2d.new()

    colorEditor.identifier = "ColorEditor"
    colorEditor.subviews = { background, 
							 WheelColorBackground,
							 WheelOldColorBackground,
							 GradientDiamondBackground,
                             gradientDiamond, 
							 wheelBackground,
                             wheelIndicator, diamondIndicator, 
							 eyeDropper  }


    -- set editor's position
    offsetX = 0
    offsetY = 0
	colorEditor.width = bkgdW
	colorEditor.height = bkgdH
    colorEditor.leftTack = {0.8, offsetX}
    colorEditor.topTack = {0.1, offsetY}

	-- set widgets' position
	local wheelColorBkgdW = WheelColorBackground.width
	local wheelColorBkgdH = WheelColorBackground.height
	WheelColorBackground.left = colorWheelCenterX - wheelColorBkgdW/2
	WheelColorBackground.top = colorWheelCenterY - wheelColorBkgdH/2

	local wheelOldColorBkgdW = WheelOldColorBackground.width
	local wheelOldColorBkgdH = WheelOldColorBackground.height
	WheelOldColorBackground.left = colorWheelCenterX - wheelOldColorBkgdW/2
	WheelOldColorBackground.top = colorWheelCenterY - wheelOldColorBkgdH/2

	local gradientDiamondBkgdW = GradientDiamondBackground.width
	local gradientDiamondBkgdH = GradientDiamondBackground.height
	GradientDiamondBackground.left = colorWheelCenterX - gradientDiamondBkgdW/2
	GradientDiamondBackground.top = colorWheelCenterY - gradientDiamondBkgdH/2


    -- set the callback function for dragging
    background.onDragBegin = function( btn, pt )
                                dragBeginX = pt[1]
                                dragBeginY = pt[2]
                            end
    background.onDrag =		function( btn, pt )
                                local deltaX = dragBeginX - pt[1]
                                local deltaY = dragBeginY - pt[2]
                                colorEditor.leftTack = {0.8, offsetX - deltaX}
                                colorEditor.topTack = {0.1, offsetY + deltaY}
							end
    background.onDragEnd =	function( btn, pt )
                                offsetX = colorEditor.leftTack[2]
                                offsetY = colorEditor.topTack[2]
                            end


	local mgr = akSupport.ci(akHUD.Manager)
	InCanvasUI().colorEditor = colorEditor
    InCanvasUI().colorEditor.visible = false
    mgr.addView(InCanvasUI().colorEditor)
    
    -- set active color to UI
    local c = ak.getSessionPropertyValue( "ak.color" )
    setColorRGB( c[1], c[2], c[3], c[4] )
	updateOldColor()
end


-- cached the current active color
function initializeCachedColor()
    cachedRGB = ak.getSessionPropertyValue("ak.color")
    cachedHSB = akSupport.RGBtoHSL( cachedRGB )
end

-- store the color to the active color
function setColorRGB( r, g, b, a )
    local rgb = { r, g, b, a }
    cachedRGB = rgb
    cachedHSB = akSupport.RGBtoHSL( cachedRGB )
    ak.setActiveColor( cachedRGB[1], cachedRGB[2], cachedRGB[3], cachedRGB[4] )
    updateUIItems()
end

-- store the color to the active color
function setColorHSB( h, s, b, a )
    local hsb = { h, s, b }
    cachedHSB = hsb
    cachedRGB = akSupport.HSLtoRGB(hsb)
    ak.setActiveColor( cachedRGB[1], cachedRGB[2], cachedRGB[3], cachedRGB[4] )
    updateUIItems()
end


function updateOldColor()
	if( WheelOldColorBackground ~= nil ) then
		WheelOldColorBackground.backgroundColor = {cachedRGB[1],cachedRGB[2],cachedRGB[3],cachedRGB[4]}
	end
end


function updateUIItems()
    local rgb = cachedRGB
    local hsb = cachedHSB

    -- set color to color editor
	
	if( WheelColorBackground ~= nil ) then
		WheelColorBackground.backgroundColor = {rgb[1],rgb[2],rgb[3],rgb[4]}
	end
	if( GradientDiamondBackground ~= nil ) then
		local hsb = { cachedHSB[1], 1.0, 0.5 }
	    local rgb = akSupport.HSLtoRGB(hsb)
		GradientDiamondBackground.backgroundColor = {rgb[1],rgb[2],rgb[3],rgb[4]}
	end

    -- set color to the slider
    local hsbTmp = { hsb[1], 1.0, 0.5 }
    local rgbTmp = akSupport.HSLtoRGB(hsbTmp)

    -- set wheel indicator position
    setWheelIndicatorPos()
    
    -- set gradient diamond indicator position
    setDiamondIndicatorPos()
end


function setWheelIndicatorPos()
    local angle = getAngleFromHue( cachedHSB[1] )
    local x = colorWheelCenterX - (wheelIndicator.width/2) + (math.cos(angle) * wheelRadius) 
    local y = colorWheelCenterY - (wheelIndicator.height/2) - (math.sin(angle) * wheelRadius)
    wheelIndicator.left = round(x)
    wheelIndicator.top = round(y)
end



function setDiamondIndicatorPos()
    local xy = getXYFromSL( cachedHSB[2], cachedHSB[3] )
	local x = colorWheelCenterX - (diamondIndicator.width/2) + xy[1]
	local y = colorWheelCenterY - (diamondIndicator.height/2) + xy[2]
    diamondIndicator.left = round(x)
    diamondIndicator.top = round(y)
end



-- //////////////////////////////////////////////////////////////////
-- Functions to convert between xy and Sat&Lum
-- //////////////////////////////////////////////////////////////////
function getXYFromSL( s, l )
    s = s * 100
    l = l * 100

    local xy = { 0, 0 }
    xy[2] = (l - slRange / 2) / slRange * diamondSize
    local range = diamondSize / 2 - math.abs(xy[2])
	xy[1] = (s - slRange / 2) * 2 * range / slRange
    xy[2] = xy[2] * -1
    return xy
end

function getSLFromXY( delta )
    if( delta[2] > diamondSize/2 ) then
        delta[2] = diamondSize/2
    elseif( delta[2] < diamondSize/-2 ) then
        delta[2] = diamondSize/-2
    end
    
    if( delta[1] > diamondSize/2 - math.abs(delta[2])) then
        delta[1] = diamondSize/2 - math.abs(delta[2])
    elseif( delta[1] < (diamondSize/-2) + math.abs(delta[2])) then
        delta[1] = (diamondSize/-2) + math.abs(delta[2])
    end

    local sl = { 0, 0 }

    sl[2] = (delta[2] + (diamondSize/2)) / diamondSize
    local range = diamondSize / 2 - math.abs(delta[2]);
    if (range == 0) then
        sl[1] = slRange / 2;
    else
        sl[1] = slRange / 2 + delta[1] / range * slRange / 2;
    end

    sl[1] = sl[1]/100
    return sl
end


-- //////////////////////////////////////////////////////////////////
-- Functions to convert between angle and hue
-- //////////////////////////////////////////////////////////////////
local Hues = { 0, 23, 34, 47, 60, 78, 117, 191, 208, 235, 277, 323, 360 };
local HueMap = nil

function setupHueMap()
    if (HueMap == nil) then
        HueMap = {}
        local i
        for i = 1,table.getn(Hues) do
            HueMap[i] = ((i-1) * math.pi / 6);
        end
    end
end


function getHueFromAngle(angle)
    setupHueMap()

    local it1 = 1
    local it2 = 2
    while it2 <= table.getn(Hues) do
        if (angle >= HueMap[it1] and angle < HueMap[it2]) then
            return ((Hues[it2] - Hues[it1]) / (math.pi / 6) * (angle - HueMap[it1]) + Hues[it1])
        end
        it1 = it1 + 1
        it2 = it2 + 1
    end    
    return (angle / math.pi * 180.0);
end


function getAngleFromHue(hue)
    setupHueMap()

    local it1 = 1
    local it2 = 2
    while it2<=table.getn(Hues) do
        if (hue >= Hues[it1] and hue < Hues[it2]) then
            return (HueMap[it2] - HueMap[it1]) / (Hues[it2] - Hues[it1]) * (hue - Hues[it1]) + HueMap[it1];
        end
        it1 = it1 + 1
        it2 = it2 + 1
    end
    return (hue / math.pi * 180.0)
end


function getAngleFromXY( delta )
    local angle

    if( delta[2] > 0 ) then
        angle = math.pi / 2
    else
        angle = math.pi * 3 / 2
    end

    if (math.abs(delta[1]) > 0.00001 ) then
        angle = math.atan(delta[2]/delta[1])
    end

    if ( delta[1] < 0) then
        angle = math.pi + angle
    end
    
    if (angle < 0) then
        angle = angle + math.pi * 2
    end

--[[
    // +
    // 90
    // |
    // |
    // 180 ------- 0 +
    // |
    // |
    // 270
]]

--    local d = angle * 180 / math.pi
--    print( "getAngleFromXY ", d )

    return angle;
end

