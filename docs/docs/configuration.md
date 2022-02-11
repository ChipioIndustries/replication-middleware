---
sidebar_position: 3
---

# Configuration

The constructor function accepts an optional dictionary of configuration options.

## defaultReplication

The replication mode to use if a dispatched action has no replication setting.

```lua
{
	defaultReplication = ReplicationMiddleware.Replication.All;
}
```

## middlewares

Middlewares to be used for the internal dummy store used to hold the initial state to send to the client.
