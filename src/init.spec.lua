local Fusion: Fusion = require(script.Parent.Parent.Fusion)
local Rodux = require(script.Parent.Parent.Rodux)

local ProvideStore = require(script.Parent)

return function()
    describe("fusion-rodux", function()
        local store = Rodux.Store.new(function(state: number | nil)
            state = state or {}
            local firstIndex = state[1] or 0
            return {firstIndex + 1}
        end)

        it("should be able to create a store", function()
            expect(store).to.be.ok()
        end)

        local provideRoduxFusionStore = ProvideStore(store)

        it("should be able to provide form a rodux store", function()
            expect(provideRoduxFusionStore).to.be.ok()
        end)

        local fusionState: Fusion.State<number> = Fusion.State(0)

        local bound: {
            disconnect: () -> nil
        }

        it("should be able to bind a fusion state", function()
            bound = provideRoduxFusionStore(fusionState, function(state: {number})
                return state[1]
            end)
            expect(bound).to.be.ok()
        end)

        it("should be able to disconnect a store", function()
            bound.disconnect()
        end)
    end)
end