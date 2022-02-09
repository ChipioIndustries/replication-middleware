local Llama = require(script.Parent.Llama)

local DefaultConfig = require(script.DefaultConfig)
local Replication = require(script.Replication)

local ReplicationMiddleware = {
	Replication = Replication
}

function ReplicationMiddleware.new(config: DefaultConfig.Config?)
	config = Llama.Dictionary.join(DefaultConfig, config or {})

	local function middleware(nextDispatch, store)
		local function dispatch(action)
			nextDispatch(action)
		end

		return dispatch
	end

	return middleware
end

return ReplicationMiddleware