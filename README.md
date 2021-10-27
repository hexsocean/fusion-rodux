# fusion-rodux

Usage is simple, and similar to roact-rodux.
```lua
local ProvideStore = game:GetService("ReplicatedStorage").Packages.FusionRodux

local store: Rodux.Store = -- a Rodux store of your choice
local provideRoduxFusionStore = ProvideStore(store)
local state: Fusion.State = Fusion.State(0)

-- this is where we wrap the store
local sig = provideRoduxFusionStore(state, function(storeState)
    return storeState[1] -- choose where the store maps to for this store.
end)

-- if you want to disconnect
sig.disconnect()
```
