local Replication = require(script.Parent.Replication)

export type Config = {
	defaultReplication: string?;
	middlewares: table?;
}

local defaultConfig: Config = {
	defaultReplication = Replication.All;
}

return defaultConfig