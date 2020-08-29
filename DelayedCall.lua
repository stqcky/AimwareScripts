-- Delayed Call by stacky#6580

local delayedCalls = {}

DelayedCall = function(time, func)
    table.insert(delayedCalls, {reqTime = common.Time() + time, thread = coroutine.create(func)})
end

callbacks.Register( "Draw", function() 
    local curTime = common.Time()
    for i, v in ipairs(delayedCalls) do
        if curTime >= v.reqTime then
            coroutine.resume(v.thread)
            table.remove(delayedCalls, i)
        end
    end
end)