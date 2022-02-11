---
sidebar_position: 2
---

# Usage

To use this middleware, call the constructor and pass the result through as middleware to a store on both the server and the client. Actions dispatched to the server will be replicated to the client. A copy of the server state is stored and sent to the client to be used as an initial state when the client connects.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicationMiddleware = require(ReplicatedStorage.Packages.ReplicationMiddleware)
local Rodux = require(ReplicatedStorage.Packages.Rodux)

local replicationMiddleware = ReplicationMiddleware.new()

local store = Rodux.Store.new(reducer, nil, {
	replicationMiddleware;
})
```

## Replicating Actions

To set an action's replication behavior, use `Replication.All` or `Replication.None` as a key to a truthy value in the action.

```lua
local myAction = {
	[ReplicationMiddleware.Replication.All] = true;
}
```
