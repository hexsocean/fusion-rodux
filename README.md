# fusion-rodux

Usage is simple, and similar to roact-rodux.
```lua
local ProvideStore = game:GetService("ReplicatedStorage").Packages.FusionRodux

local store: Rodux.Store = -- a Rodux store of your choice, for example this one would return {10}
local provideRoduxFusionStore = ProvideStore(store)

-- this is where we map the state to the store, the function passed in is optional and if it isn't
-- passed, then the Fusion state will be the same as the Rodux store state.
local state, disconnect = provideRoduxFusionStore(function(storeState)
    return storeState[1] -- choose where the store maps to for this store.
end)

-- You can now use it as a state in fusion, the state would have a value of 10.
local label = New "TextLabel" {
    Text = state
}

-- If you want to disconnect the store from the state
disconnect()
```
