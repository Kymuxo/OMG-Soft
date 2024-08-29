if (LuaConnect) then

    -- properties

    function createBoolPty(ctx, name, value)
        return akUI.newBoolPty(name, value)
    end
    
    function createColorPty(ctx, name, value)
        return akUI.newColorPty(name, value)
    end

    function createDoublePty(ctx, name, value)
        return akUI.newDoublePty(name, value[1], value[2], value[3])
    end

    function createEnumPty(ctx, name, value)
        return akUI.newEnumPty(name, value)
    end

    function createGenericPty(ctx, name, value)
        return akUI.newGenericPty(name, value)
    end
    
    function createStringPty(ctx, name, value)
        return akUI.newStringPty(name, value)
    end

    function createPropertySet(ctx,
                               boolProps, enumProps, doubleProps,
                               colorProps, stringProps, genericProps)
        
        local result = akUI.newPropertySet(ctx.PropertySet)
        
        local insertItems = function (items)
            for _, item in pairs(items) do
                result.insert(item)
            end
        end
        
        insertItems(boolProps)
        insertItems(enumProps)
        insertItems(doubleProps)
        insertItems(colorProps)
        insertItems(stringProps)
        insertItems(genericProps)
        
        setReadPropertiesResult(result)

        return result
    end


    -- resources
    
    function createCursor(ctx, image, hotspot)
        return akRES.newCursor(ctx.ResourceLibrary, ctx.Cursor, image, hotspot)
    end
    
    function createCursorLibrary( ctx, imageLib, cursors )
        return akRES.newCursorLibrary(ctx.CursorLibrary, imageLib, cursors)
    end

    function createImage(ctx, file, thumbnail)
        return akRES.newImage(ctx.ImageLibrary, ctx.Image, file, thumbnail)
    end
    
    function createImageItem(ctx, type)
        return akRES.newImageItem(type, ctx.ImageItem)
    end
    
    function createImageSet(ctx, items)
        return akRES.newImageSet(ctx.ImageSet, items)
    end

    function createImageLibrary(ctx, imgs)
        return akRES.newImageLibrary(ctx.ImageLibrary, imgs)
    end
    
    function createResourceLibrary(ctx, type, cursorLibs, imageLibs, imageSets, toolBars)
        local result = akRES.newLibrary(ctx.ResourceLibrary, type, cursorLibs, imageLibs, imageSets, toolBars)
        
        setParseLuaFileResult(result)

        return result
    end
end


local function getString( args, owner, fieldName )
   local field = args[fieldName]
   if field == nil then
      error( owner .. ": no field '" .. fieldName .. "'" )
   elseif type(field) ~= "string" then
      error( owner .. ": field '" .. fieldName .. "' should be a string" )
   end
   args[fieldName] = nil
   return field
end


local function getOptString( args, owner, fieldName )
   local field = args[fieldName]
   if field ~= nil then
      getString( args, owner, fieldName )
   end
   return field
end


local function getNumber( args, owner, fieldName )
   local field = args[fieldName]
   if field == nil then
      error( string.format("%s: no field '%s'",owner,fieldName) )
   elseif type(field) ~= "number" then
      error( string.format("%s: field '%s' should be a number",
                           owner,fieldName) )
   end
   args[fieldName] = nil
   return field
end


local function getOptNumber( args, owner, fieldName )
   local field = args[fieldName]
   if field ~= nil then
      getNumber( args, owner, fieldName )
   end
   return field
end


local function getBool( args, owner, fieldName )
   local field = args[fieldName]
   if field == nil then
      error( string.format("%s: no field '%s'",owner,fieldName) )
   elseif type(field) ~= "boolean" then
      error( string.format("%s: field '%s' should be a boolean",
                           owner,fieldName) )
   end
   args[fieldName] = nil
   return field
end
      

local function getOptBool( args, owner, fieldName )
   local field = args[fieldName]
   if field ~= nil then
      getBool( args, owner, fieldName )
   end
   return field
end


local function isArray( tbl )
   -- check that every key is an integer in the right range
   for k in pairs(tbl) do
      if type(k) ~= "number" or k < 1 or k > #tbl or (k % 1) ~= 0 then
         return false
      end
   end
   return true
end


local function getTuple( args, owner, fieldName, arity )
   local field = args[fieldName]
   if field == nil then
      error( string.format("%s: no field '%s'",owner,fieldName) )
   elseif type(field) ~= "table" or not isArray(field) then
      error( string.format("%s: field '%s' should be a %d-tuple",
                           owner,fieldName,arity) )
   else
      for k,v in pairs(field) do
         if type(v) ~= "number" then
            error( string.format("%s: element %d of tuple %s not a number",
                                 owner,k,fieldName) )
         end
      end
   end
   args[fieldName] = nil
   return field
end


local function getOptTuple( args, owner, fieldName, arity )
   local field = args[fieldName]
   if field ~= nil then
        getTuple( args, owner, fieldName, arrity )
   end
   return field
end


local function getAnyData( args, owner, fieldName )
    local field = args[fieldName]
    if field == nil then
        error( string.format("%s: no field '%s'",owner,fieldName) )
    elseif not (type(field) == "boolean" or
                type(field) == "string" or
                type(field) == "number" or
                (type(field) == "table" )) then
        error( string.format("%s: field '%s' is not valid data",
                             owner,fieldName) )
    end
    args[fieldName] = nil
    return field
end


local function getElement( args, owner, typeName, optional )
   local userType = false
   for k,v in pairs(args) do
      if type(v) == "table" and v.type == typeName then
         userType = v
         table.remove( args, k )
         break
      end
   end

   if not optional and not userType then
      error( string.format("%s: required element '%s' not found",
                           owner,typeName) )
   end

   if not userType then
      userType = nil
   end
   
   return userType
end


local function getOptElement( args, owner, typeName )
   return getElement( args, owner, typeName, true )
end


local function checkTypes( args, owner, types )
   -- convert the list 'types' to a map for easy access
   local typeMap = {}
   for _,v in pairs(types) do typeMap[v] = true end
   
   -- make sure that all the elements are tables of the right types
   for k,v in pairs(args) do
      if type(v) ~= "table" or v.type == nil then
         error( string.format("Invalid entry %s in %s",
                              tostring(v), owner) )
      elseif not typeMap[v.type] then
         error( "Invalid entry '" .. v.type .. "' in " .. owner )
      end
   end
end   


local function checkType( args, owner, typeName )
   return checkTypes( args, owner, { typeName } )
end


local function checkEmpty( args, owner )
   if next(args) ~= nil then
      error( "Extra arguments in element " .. owner )
   end
end


function ResourceLibrary( args )
   local owner = "ResourceLibrary"
   local name = getString( args, "ResourceLibrary", "name" )
   local type = getOptString( args, owner, "type" )

   if type == nil then
      type = "resource"
   else
      if type ~= "resource" and type ~= "appSupport" then
         error( string.format("%s: field 'type' must be 'resource' or 'appSupport'",
                              owner) )
      end
   end

   -- all the rest of the args should be typed function arrays
   if not isArray(args) then
      error( "Syntax error for ResourceLibrary arguments" )
   end
      
   local cursorLibs = {}
   local imageLibs = {}
   local imageSets = {}
   local toolBars = {}

   local ctx = {}
   ctx.ResourceLibrary = name
   
   for _,v in pairs( args ) do
      if v.type == "CursorLibrary" then
         table.insert( cursorLibs, v.func(ctx) )
      elseif v.type == "ImageLibrary" then
         table.insert( imageLibs, v.func(ctx) )
      elseif v.type == "ImageSet" then
         if not v.named then
            error( "Top-level image set must have a name" )
         end
         table.insert( imageSets, v.func(ctx) )
      elseif v.type == "ToolBar" then
         table.insert( toolBars, v.func(ctx) )
      else
         error( string.format("Unrecognized element: '%s'",v.type) )
      end
   end

   createResourceLibrary( ctx, type, cursorLibs, imageLibs, imageSets, toolBars )

   ctx.ResourceLibrary = nil
end


function ImageLibrary( args )
   local owner = "ImageLibrary"
   local name = getOptString( args, owner, "name" )

   -- all the remaining arguments should be Image's
   checkType( args, owner, "Image" )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ImageLibrary = name

                 -- instantiate the images
                 local imgs = {}
                 for _,v in pairs(args) do
                    local img = v.func( ctx )
                    table.insert( imgs, img )
                 end
                 
                 local ret = createImageLibrary( ctx, imgs )

                 ctx.ImageLibrary = nil
                 return ret
              end
   return ret
end


function ImageSet( args )
   local owner = "ImageSet"
   local name = getOptString( args, owner, "name" )

   -- all the remaining arguments should be images
   checkType( args, owner, "ImageItem" )

   local ret = {}
   ret.type = owner
   ret.named = name
   ret.func = function( ctx )
                 ctx.ImageSet = name
                 local items = {}
                 for _,v in pairs(args) do
                    table.insert( items, v.func(ctx) )
                 end

                 local ret = createImageSet( ctx, items )

                 ctx.ImageSet = nil
                 return ret
              end
   return ret
end


function ImageItem( args )
   local owner = "ImageItem"
   local name = getString( args, owner, "name" )
   local type = getString( args, owner, "type" )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ImageItem = name
                 local ret = createImageItem( ctx, type )
                 ctx.ImageItem = nil
                 return ret
              end
   return ret
end


function Image( args )
   local owner = "Image"
   local name = getString( args, owner, "name" )
   local file = getString( args, owner, "file" )
   local thumbnail = getOptString( args, owner, "thumbnail" )

   if thumbnail == nil then
      thumbnail = ""
   end

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.Image = name
                 local ret = createImage( ctx, file, thumbnail )
                 ctx.Image = nil
                 return ret
              end
   return ret
end


function CursorLibrary( args )
   local owner = "CursorLibrary"
   local name = getString( args, owner, "name" )
   local imageLib = getString( args, owner, "imageLib" )

   checkType( args, owner, "Cursor" )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.CursorLibrary = name

                 -- create the cursors
                 local cursors = {}
                 for _,v in pairs(args) do
                    table.insert( cursors, v.func(ctx) )
                 end

                 local ret = createCursorLibrary( ctx, imageLib, cursors )
                 
                 ctx.CursorLibrary = nil
                 return ret
              end
   return ret
end


function Cursor( args )
   local owner = "Cursor"
   local name = getString( args, owner, "name" )
   local image = getString( args, owner, "image" )
   local hotspot = getTuple( args, owner, "hotspot", 2 )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.Cursor = name

                 local ret = createCursor( ctx, image, hotspot )

                 ctx.Cursor = nil
                 return ret
              end
   return ret
end


function ToolBar( args )
   local owner = "ToolBar"
   local name = getString( args, owner, "name" )
   local orientation = getString( args, owner, "orientation" )
   local coordinateSystem = getString( args, owner, "coordinateSystem" )
   local position = getTuple( args, owner, "position", 2 )
   local spacing = getNumber( args, owner, "spacing" )
   local imageLib = getString( args, owner, "imageLib" )
   local defaultItem = getOptString( args, owner, "defaultItem" )
   local backgroundImage = getString( args, owner, "backgroundImage" )
   local backgroundOffset = getTuple( args, owner, "backgroundOffset", 2 )

   checkTypes( args, owner, { "ToolBarItem", "ToolBarPulloutItem" } )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ToolBar = name

                 -- create the items
                 local items = {}
                 for _,v in pairs(args) do
                    table.insert( items, v.func(ctx) )
                 end

                 -- build a table of parameters
                 local params = {}
                 params.name = name
                 params.orientation = orientation
                 params.coordinateSystem = coordinateSystem
                 params.position = position
                 params.spacing = spacing
                 params.imageLib = imageLib
                 params.defaultItem = defaultItem
                 params.backgroundImage = backgroundImage
                 params.backgroundOffset = backgroundOffset
                 
                 local ret = createToolBar( ctx, params, items )
                 
                 ctx.ToolBar = nil
                 return ret
              end
   return ret
end


function ToolBarItem( args )
   local owner = "ToolBarItem"
   local name = getString( args, owner, "name" )
   local cmd = getString( args, owner, "cmd" )
   local priority = getOptNumber( args, owner, "priority" )
   local imageSet = getElement( args, owner, "ImageSet" )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ToolBarItem = name

                 -- create the image set
                 imageSet = imageSet.func( ctx )

                 -- build a table of parameters
                 local params = {}
                 params.name = name
                 params.cmd = cmd
                 params.priority = priority
                 params.imageSet = imageSet

                 local ret = createToolBarItem( ctx, params )
                 
                 ctx.ToolBarItem = nil
                 return ret
              end
   return ret
end


function ToolBarPulloutItem( args )
   local owner = "ToolBarPulloutItem"
   local name = getString( args, owner, "name" )
   local affordanceImageSet = getString( args, owner, "affordanceImageSet" )
   local affordanceOffset = getTuple( args, owner, "affordanceOffset", 2 )
   local radioMode = getOptBool( args, owner, "radioMode" )
   local imageSet = getOptElement( args, owner, "ImageSet" )

   checkType( args, owner, "ToolBarItem" )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ToolBarPulloutItem = name

                 -- create the image set
                 if imageSet then
                    imageSet = imageSet.func( ctx )
                 end

                 -- create the items
                 local items = {}
                 for _,v in pairs(args) do
                    table.insert( items, v.func(ctx) )
                 end

                 -- build a table of parameters
                 local params = {}
                 params.name = name
                 params.affordanceImageSet = affordanceImageSet
                 params.affordanceOffset = affordanceOffset
                 params.radioMode = radioMode
                 params.imageSet = imageSet

                 local ret = createToolBarPulloutItem( ctx, params, items )
                 
                 ctx.ToolBarPulloutItem = nil
                 return ret
              end
   return ret
end


function Container( args )
    local owner = "Container"
    local name = getOptString( args, owner, "name" )
    local orientation = getString( args, owner, "orientation" )
    local xSpacing = getOptNumber( args, owner, "xSpacing" )
    local ySpacing = getOptNumber( args, owner, "ySpacing" )
    local left   = getOptTuple( args, owner, "left", 2 )
    local right  = getOptTuple( args, owner, "right", 2 )
    local top    = getOptTuple( args, owner, "top", 2 )
    local bottom = getOptTuple( args, owner, "bottom", 2 )

    checkTypes( args, owner, { "Divider", "Scroll", "LibraryBar" } )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                ctx.Container = name

                local params = {}
                params.orientation = orientation
                params.xSpacing = xSpacing
                params.ySpacing = ySpacing
                params.left = left
                params.right = right
                params.top = top
                params.bottom = bottom

                local items = {}
                for _,v in pairs(args) do
                    local item = v.func( ctx )
                    table.insert( items, item )
                end
                 
                local ret = createContainer( ctx, params, items )

                ctx.Container = nil
                return ret
               end
    return ret
end


function Scroll( args )
    local owner  = "Scroll"
    local left   = getOptTuple( args, owner, "left", 2 )
    local right  = getOptTuple( args, owner, "right", 2 )
    local top    = getOptTuple( args, owner, "top", 2 )
    local bottom = getOptTuple( args, owner, "bottom", 2 )

    checkType( args, owner, "Container" )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                ctx.Scroll = name

                local params = {}
                params.left = left
                params.right = right
                params.top = top
                params.bottom = bottom

                local items = {}
                for _,v in pairs(args) do
                    local item = v.func( ctx )
                    table.insert( items, item )
                end
                 
                local ret = createScroll( ctx, params, items )

                ctx.Scroll = nil
                return ret
               end
    return ret
end


function Divider( args )
    local owner  = "Divider"
    local separator = getString( args, owner, "separator" )
    local left   = getOptTuple( args, owner, "left", 2 )
    local right  = getOptTuple( args, owner, "right", 2 )
    local top    = getOptTuple( args, owner, "top", 2 )
    local bottom = getOptTuple( args, owner, "bottom", 2 )

    checkType( args, owner, "Container" )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                ctx.Divider = name

                local params = {}
                params.separator = separator
                params.left = left
                params.right = right
                params.top = top
                params.bottom = bottom

                local items = {}
                for _,v in pairs(args) do
                    local item = v.func( ctx )
                    table.insert( items, item )
                end
                 
                local ret = createDivider( ctx, params, items )

                ctx.Divider = nil
                return ret
               end
    return ret
end


function Drawer( args )
    local owner  = "Drawer"
    local name   = getString( args, owner, "name" )
    local label  = getString( args, owner, "label" )
    local bar    = getString( args, owner, "bar" )
    local openClose = getString( args, owner, "openClose" )
    local left   = getOptTuple( args, owner, "left", 2 )
    local right  = getOptTuple( args, owner, "right", 2 )

    checkTypes( args, owner, { "Container", "Divider", "Scroll" } )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                ctx.Drawer = name

                local params = {}
                params.label = label 
                params.bar = bar
                params.openClose = openClose
                params.left = left
                params.right = right

                local items = {}
                for _,v in pairs(args) do
                    local item = v.func( ctx )
                    table.insert( items, item )
                end
                 
                local ret = createDrawer( ctx, params, items )

                ctx.Drawer = nil
                return ret
               end
    return ret
end


function LibraryBar( args )
    local owner  = "LibraryBar"
    local name   = getString( args, owner, "name" )
    local label  = getString( args, owner, "label" )
    local editable = getBool( args, owner, "editable" )
    local left   = getOptTuple( args, owner, "left", 2 )
    local right  = getOptTuple( args, owner, "right", 2 )
    local top    = getOptTuple( args, owner, "top", 2 )
    local bottom = getOptTuple( args, owner, "bottom", 2 )

    checkEmpty( args, owner )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                ctx.LibraryBar = name

                local params = {}
                params.label = label
                params.editable = editable
                params.left = left
                params.right = right
                params.top = top
                params.bottom = bottom

                local ret = createLibraryBar( ctx, params )

                ctx.LibraryBar = nil
                return ret
               end
    return ret
end


function HUD( args )
    local owner = "HUD"
    local name = getString( args, owner, "name" )

    checkType( args, owner, "Drawer" )

    local ctx = {}
    ctx.HUD = name

    local items = {}
    for _,v in pairs(args) do
        local item = v.func( ctx )
        table.insert( items, item )
    end

    createHUD( ctx, items )

    ctx.HUD = nil
end


function BoolPty( args )
   local owner = "BoolPty"
   local name = getString( args, owner, "name" )
   local value = getBool( args, owner, "value" )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.BoolPty = name

                 local ret = createBoolPty( ctx, name, value )

                 ctx.BoolPty = nil
                 return ret
              end
   return ret
end


function EnumPty( args )
   local owner = "EnumPty"
   local name = getString( args, owner, "name" )
   local value = getNumber( args, owner, "value" )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.EnumPty = name

                 local ret = createEnumPty( ctx, name, value )

                 ctx.EnumPty = nil
                 return ret
              end
   return ret
end


function DoublePty( args )
   local owner = "DoublePty"
   local name = getString( args, owner, "name" )
   local value = getTuple( args, owner, "value", 3 )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.DoublePty = name

                 local ret = createDoublePty( ctx, name, value )

                 ctx.DoublePty = nil
                 return ret
              end
   return ret
end


function ColorPty( args )
   local owner = "ColorPty"
   local name = getString( args, owner, "name" )
   local value = getTuple( args, owner, "value", 4 )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.ColorPty = name

                 local ret = createColorPty( ctx, name, value )

                 ctx.ColorPty = nil
                 return ret
              end
   return ret
end


function StringPty( args )
   local owner = "StringPty"
   local name = getString( args, owner, "name" )
   local value = getString( args, owner, "value" )

   checkEmpty( args, owner )

   local ret = {}
   ret.type = owner
   ret.func = function( ctx )
                 ctx.StringPty = name

                 local ret = createStringPty( ctx, name, value )

                 ctx.StringPty = nil
                 return ret
              end
   return ret
end


-- generic property that can hold any plist item
function Property( args )
    local owner = "GenericPty"
    local name = getString( args, owner, "name" )
    local value = getAnyData( args, owner, "value" )

    checkEmpty( args, owner )

    local ret = {}
    ret.type = owner
    ret.func = function( ctx )
                   ctx.GenericPty = name

                   local ret = createGenericPty( ctx, name, value )

                   ctx.GenericPty = nil
                   return ret
               end
    return ret
end


function PropertySet( args )
   local name = getOptString( args, "PropertySet", "name" )

   checkTypes( args, owner, { "BoolPty", "EnumPty", "DoublePty", "ColorPty",
                              "StringPty", "GenericPty" } )

   local boolProps = {}
   local enumProps = {}
   local doubleProps = {}
   local colorProps = {}
   local stringProps = {}
   local genericProps = {}

   local ctx = {}
   ctx.PropertySet = name

   for _,v in pairs( args ) do
      if v.type == "BoolPty" then
         table.insert( boolProps, v.func(ctx) )
      elseif v.type == "EnumPty" then
         table.insert( enumProps, v.func(ctx) )
      elseif v.type == "DoublePty" then
         table.insert( doubleProps, v.func(ctx) )
      elseif v.type == "ColorPty" then
         table.insert( colorProps, v.func(ctx) )
      elseif v.type == "StringPty" then
         table.insert( stringProps, v.func(ctx) )
      elseif v.type == "GenericPty" then
         table.insert( genericProps, v.func(ctx) )
      else
         error( string.format("Unrecognized element: '%s'",v.type) )
      end
   end

   createPropertySet( ctx, boolProps, enumProps, doubleProps, colorProps,
                      stringProps, genericProps )

   ctx.PropertySet = nil
end

