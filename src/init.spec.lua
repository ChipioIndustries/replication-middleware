return function()
	describe("ReplicationMiddleware.lua", function()
		local ReplicationMiddleware = require(script.Parent)
		local Rodux = require(script.Parent.Parent.Rodux)

		local myReducer = function(state, action)
			return {
				value = 5
			}
		end

		local store = Rodux.Store.new(myReducer, nil, {
			ReplicationMiddleware.new()
		})

		store:dispatch({
			type = "whatever"
		})
	end)
end