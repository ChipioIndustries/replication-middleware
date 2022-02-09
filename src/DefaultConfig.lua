local Replication = require(script.Parent.Replication)

export type Config = {
	defaultReplication: string?;
}

local defaultConfig: Config = {
	defaultReplication = Replication.All;
}

return defaultConfig