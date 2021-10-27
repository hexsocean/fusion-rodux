local Fusion: Fusion = require(script.Parent.Fusion)
local Rodux: Rodux = require(script.Parent.Rodux)

local function NewStoreStateConnection<T>(store: Rodux.Store, fusionState: Fusion.State<T>, mapStoreToState: (any) -> any)
    if not mapStoreToState and typeof(mapStoreToState) ~= "function" then
        error("Must pass in a function to map the store to the fusion state", 2)
        return
    end
    fusionState:set(mapStoreToState(store:getState()))
    return store.changed:connect(function(newState, oldState)
        fusionState:set(mapStoreToState(newState))
    end)
end

local function ProvideStore(store: Rodux.Store)
    return function <T>(fusionState: Fusion.State<T>, mapStoreToState: (any) -> any)
        return NewStoreStateConnection(store, fusionState, mapStoreToState)
    end
end

return ProvideStore