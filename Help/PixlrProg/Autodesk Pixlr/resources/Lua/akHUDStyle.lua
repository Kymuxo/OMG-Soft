local function transferObjects(value)
    local valueType = type(value)
    if valueType == "table" then
        for n,v in pairs(value) do
            transferObjects(n)
            transferObjects(v)
        end
    elseif valueType == "userdata" then
        value.delete("transfer")
    end
end


local function getApplyFunc(selector)
    return
        function( properties )
            -- there should be a 'properties' entry
            if properties == nil then
                error("style table must have a 'properties' entry")
            end

            if type(properties) ~= "table" then
                error("style table must have a 'properties' table entry")
            end

            -- allocate the style
            local style = akHUD.Style.new()
            style.setSelector(selector)

            -- set the properties
            for name, value in pairs(properties) do
                local stack = ak.createLCStack(value)
                style.addProperty(name, stack)
                stack.delete("transfer")
                transferObjects(value)
            end

            -- store it in the HUD manager
            akSupport.ci(akHUD.Manager).addStyle(style)
        end
end


function style(selector)
    -- parse the 'elements' entry
    if selector == nil then
        error("style table must have a 'selector' entry")
    end

    if type(selector) ~= "string" then
        error("style table must have a 'selector' string entry")
    end

    return getApplyFunc(selector)
end
