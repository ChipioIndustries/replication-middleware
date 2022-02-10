return function()
	describe("ReplicationMiddleware.lua", function()
		local ReplicationMiddleware = require(script.Parent)
		local Rodux = require(script.Parent.Parent.Rodux)

		it("should construct a middleware object", function()
			local middleware = ReplicationMiddleware.new()

			expect(middleware).to.be.a("function")
		end)

		it("should replicate actions", function()
			local myReducer = function(state, action)
				if action.type == "yeehaw" then
					return action.value
				end
				return state
			end

			local store = Rodux.Store.new(myReducer, nil, {
				ReplicationMiddleware.new()
			})

			expect(store).to.be.ok()
		end)
	end)
end