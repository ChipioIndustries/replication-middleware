local RunService = game:GetService("RunService")

local Llama = require(script.Parent.Llama)
local Remotes = require(script.Parent.Remotes)
local Rodux = require(script.Parent.Rodux)

local DefaultConfig = require(script.DefaultConfig)
local Replication = require(script.Replication)

local actionReplicationRemote = Remotes:getEventAsync("ActionReplication")
local initialStateRemote = Remotes:getFunctionAsync("InitialState")

local ReplicationMiddleware = {
	Replication = Replication
}

function ReplicationMiddleware.new(config: DefaultConfig.Config?)
	config = Llama.Dictionary.join(DefaultConfig, config or {})

	local function middleware(nextDispatch, store)
		local dispatch
		if RunService:IsServer() then
			local dummyStore = Rodux.Store.new(store._reducer, store._state, config.middlewares)

			function initialStateRemote.OnServerInvoke(player)
				return dummyStore:getState()
			end

			function dispatch(action)
				local replication = config.defaultReplication
				for _, replicationType in pairs(Replication) do
					if action[replicationType] then
						replication = replicationType
						break
					end
				end
				if replication == Replication.All then
					actionReplicationRemote:FireAllClients(action)
					task.spawn(function()
						dummyStore:dispatch(action)
					end)
				end
				nextDispatch(action)
			end
		else
			local initialState = initialStateRemote:InvokeServer()
			store._state = initialState

			actionReplicationRemote.OnClientEvent:Connect(function(action)
				store:dispatch(action)
			end)

			function dispatch(action)
				nextDispatch(action)
			end
		end

		return dispatch
	end

	return middleware
end

return ReplicationMiddleware