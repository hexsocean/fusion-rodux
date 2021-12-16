local Fusion: Fusion = require(script.Parent.Fusion)

local function DefaultMapStoreToState(storeState)
    return storeState
end

local function NewStoreStateConnection<T>(store: Rodux.Store, fusionState: Fusion.State<T>, mapStoreToState: (any) -> any)
    if not mapStoreToState and typeof(mapStoreToState) ~= "function" then
        error("Must pass in a function to map the store to the fusion state", 2)
        return
    end
    fusionState:set(mapStoreToState(store:getState()))
    return store.changed:connect(function(newState)
        fusionState:set(mapStoreToState(newState))
    end)
end

-- Creates a function to provide a store for creating fusion states.
local function ProvideStore(store: Rodux.Store)
    -- Takes in a function to map the store state to a fusion state.
    -- Returns the fusion state in a tuple with a function to disconnect the store from the state.
    return function <T>(mapStoreToState: ((any) -> T)?): (Fusion.State<T>, () -> nil)
        mapStoreToState = mapStoreToState or DefaultMapStoreToState
        local boundState = Fusion.State()
        local bind = NewStoreStateConnection(store, boundState, mapStoreToState)
        return boundState, bind.disconnect
    end
end

return ProvideStore
