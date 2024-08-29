local function curveLinear(t)
    return t
end


local function curveEaseIn(t)
    return 1.0 - math.cos(0.5 * t * math.pi)
end


local function curveEaseInOut(t)
    return 0.5 - 0.5 * math.cos(t * math.pi)
end


local function curveEaseOut(t)
    return math.sin(0.5 * t * math.pi)
end


local animCurves = {
    linear = curveLinear,
    easeIn = curveEaseIn,
    easeInOut = curveEaseInOut,
    easeOut = curveEaseOut
}



Animation = 
{
    -- Table to keep animation watchers alive for their duration
    Watchers = {},

    -- //////////////////////////////////////////////////////////////////
    -- Functions to start an animation
    -- //////////////////////////////////////////////////////////////////

    animate = function(args)
        if args.duration == nil then
            error("Animation.animate(): must specify 'duration'")
        end

        if args.startFunc == nil then
            error("Animation.animate(): must specify 'startFunc'")
        end
        
        -- create the watcher and interval
        local watcher = akANM.newAnimation()
        Animation.Watchers[watcher] = true

        watcher.startWatching(true)
        local interval = akANM.newAnimationInterval(args.duration)
        watcher.stopWatching()

        -- call the start function and collect the properties to animate
        local properties = {}
        ak.setLCPropertyAssignmentHook(
            function(obj, pty, endVal)
                -- get the current value of the property
                local val = obj[pty]

                -- add an entry into the properties table
                local entry = { object = obj,
                                property = pty,
                                startValue = val,
                                endValue = endVal }
                table.insert(properties, entry)
                return false
            end)
        args.startFunc()
        ak.setLCPropertyAssignmentHook(nil)

        -- determine the animation curve
        local curve = curveEaseInOut
        if args.curve ~= nil then
            curve = animCurves[args.curve]
        end
        assert(curve ~= nil)

        local animateEntries = function(t)
            -- iterate through the properties
            for _, entry in pairs(properties) do
                -- compute the current value for the property
                local val = Animation.lerp(entry.startValue, entry.endValue, t)

                -- set the property
                entry.object[entry.property] = val
            end
        end

        -- set the animation function
        watcher.onAnimate = function()
            local t = curve(interval.value)
            animateEntries(t)
        end

        -- set the end function
        watcher.onAnimationEnded = function(watcher)
            -- call the entries one last time
            animateEntries(1.0)

            -- call the end func if specified
            if args.endFunc then
                args.endFunc()
            end

            -- delete the watcher
            Animation.Watchers[watcher] = nil
        end
    end,

    animate2 = function( duration, _onAnimate, _onAnimationEnded )

        local watcher = akANM.newAnimation()
        Animation.Watchers[watcher] = true

        watcher.startWatching(true)
        local interval = akANM.newAnimationInterval( duration )
        watcher.stopWatching()

        local onAnimate = function (watcher)
                            _onAnimate( interval.value )
                        end
        watcher.onAnimate = onAnimate

        local onAnimationEnded = function(watcher)
                                     _onAnimationEnded(watcher)
                                     Animation.Watchers[watcher] = nil
                                 end
        watcher.onAnimationEnded = onAnimationEnded
        
        return watcher
    end,

    -- //////////////////////////////////////////////////////////////////
    -- Functions to lerp value
    -- //////////////////////////////////////////////////////////////////
    lerp = function(startValue, endValue, t)
        local result
        
        assert(type(startValue)==type(endValue))
        
        valueType = type(startValue)

        if valueType  == "number" then
            result = (1-t)*startValue + t*endValue
        elseif valueType == "table" then
            result = {}

            for key, value in pairs(startValue) do
                result[key] = Animation.lerp(startValue[key], endValue[key], t)
            end
        else
            result = endValue
        end

        return result
    end



}
