local HttpService = game:GetService("HttpService")

local Replication = {
	All = HttpService:GenerateGUID();
	None = HttpService:GenerateGUID();
}

return Replication