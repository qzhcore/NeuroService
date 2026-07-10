local NeuroService = {}
NeuroService.Registry = {}

local RunService = game:GetService("RunService")
local Settings = require(script.Settings)

local heartbeatConnection: RBXScriptConnection? = nil

function NeuroService:Init()
	if heartbeatConnection ~= nil then
		return
	end

	heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
		self:ProcessEntities(dt)
	end)
end

function NeuroService:Register(
	instance: Model,
	brainModule: ModuleScript | { [string]: any },
	config: { [string]: any }?
)
	assert(typeof(instance) == "Instance", "NeuroService:Register expects a Roblox Instance")
	assert(instance:IsA("Model"), "NeuroService:Register expects a Model")

	local brain = if typeof(brainModule) == "Instance" then require(brainModule) else brainModule
	assert(type(brain) == "table", "NeuroService:Register expects a brain ModuleScript or table")

	local Entity = {
		Instance = instance,
		Brain = brain,
		Config = config or {},
		Blackboard = {
			State = "Idle",
			StartTime = os.clock(),
			Memory = {},
			Entity = instance,
		},
		LastUpdate = 0,
	}

	table.insert(self.Registry, Entity)
	return Entity
end

function NeuroService:ProcessEntities(dt)
	local TasksProcessed = 0
	local Clock = os.clock()
	local index = 1

	while index <= #self.Registry do
		if TasksProcessed >= Settings.MAX_TASKS_PER_FRAME then
			break
		end

		local Entity = self.Registry[index]
		if Entity.Instance.Parent == nil then
			table.remove(self.Registry, index)
			continue
		end

		local TimeSinceUpdate = Clock - Entity.LastUpdate
		local Throttle = Settings.DEFAULT_THROTTLE

		if Settings.LOD_ENABLED and Entity.Instance.PrimaryPart then
			local Dist = (Entity.Instance.PrimaryPart.Position - Vector3.zero).Magnitude
			if Dist > Settings.DISTANCE_FAR then
				Throttle = Settings.THROTTLE_FAR
			end
		end

		if TimeSinceUpdate >= Throttle then
			local StateLogic = Entity.Brain[Entity.Blackboard.State]
			if StateLogic then
				StateLogic(Entity.Blackboard, dt)
			end
			Entity.LastUpdate = Clock
			TasksProcessed += 1
		end

		index += 1
	end
end

function NeuroService:Unregister(entity)
	for index, registered in self.Registry do
		if registered == entity or registered.Instance == entity then
			table.remove(self.Registry, index)
			return true
		end
	end

	return false
end

function NeuroService:Destroy()
	if heartbeatConnection ~= nil then
		heartbeatConnection:Disconnect()
		heartbeatConnection = nil
	end

	table.clear(self.Registry)
end

return NeuroService
