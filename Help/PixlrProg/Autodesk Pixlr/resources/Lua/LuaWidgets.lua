
--
-- create image view with full parameters
--
function _CreateImageView( imageName, left, top )
    local iv = akHUD.Image.new()
    iv.image = imageName
    iv.left = left
    iv.top = top

    return iv
end

--
-- create image view with optional parameters
--
function CreateImageView ( options )

    -- check mandatory options
    if type(options.image) ~= "string" then
        error("no image")
    end
    
    -- everything else is optional
    return _CreateImageView(options.image,
                            options.left or 0,      -- default value 
                            options.top or 0        -- default value
                            )
end



--
-- create buttonimage view with full parameters
--

function _CreateButton( identifier, image, bkgdDefault, bkgdHighlighted, bkgdSelected, bkgdHover, onClick, _onHoverOver )

    local button = akHUD.ImageButton.new()

    button.identifier = identifier
    button.images = {default=image, 
                        backgroundDefault=bkgdDefault, 
                        backgroundHighlighted=bkgdHighlighted, 
                        hover=bkgdHover, 
                        backgroundSelected=bkgdSelected}
    if( onClick ~= nil ) then
		button.onRelease = onClick
	end

    if( _onHoverOver ~= nil ) then
        button.onHoverOver = _onHoverOver
        button.onHoverOut = function()
                                hideToolTip()
                            end
    end

    return button
end


--
-- create button with optional parameters
--
function CreateButton ( options )

    -- check mandatory options
    if type(options.identifier) ~= "string" then
        error("Button: no identifier")
    end
    
    -- everything else is optional
    return _CreateButton( options.identifier,
                          options.images.default or nil,                     -- default value
                          options.images.backgroundDefault or nil,           -- default value
                          options.images.backgroundHighlighted or nil,       -- default value
                          options.images.backgroundSelected or nil,          -- default value
                          options.images.backgroundHover or nil,             -- default value
                          options.onClick or nil,
                          options.onHoverOver or nil                        -- default value
                        )
end


--
-- create container with full parameters
--
function CreateContainer( options )

    local paletteContainer = akHUD.Container.new()
    
    if options.identifier ~= nil then
        paletteContainer.identifier = options.identifier
    end
    
    if options.layout ~= nil then
        paletteContainer.layout = options.layout
    end
    
    if options.left ~= nil then
        paletteContainer.left = options.left
    end
    
    if options.top ~= nil then
        paletteContainer.top = options.top
    end
    
    if options.right ~= nil then
        paletteContainer.right = options.right
    end
    
    if options.bottom ~= nil then
        paletteContainer.bottom = options.bottom
    end
    
    return paletteContainer
end


--
-- find view from subview
--
function findSubview( v, id )

    for key, subview in pairs( v.subviews ) do
        if ( subview.identifier == id ) then
            return subview
        end
    end

    return nil
end


--
--  return HUDItem if it is under this view
--
function findItemFromId( v, id )
    if( v.identifier == id ) then
        return v
    else
        for key, subview in pairs( v.subviews ) do
            local rc = findItemFromId( subview, id )
            if( rc ~= nil ) then
                return rc
            end
        end
    end
    
    return nil
end


function round(num) 
	if num >= 0 then return math.floor(num+.5) 
	else return math.ceil(num-.5) end
end
