local NeuroService = {}
NeuroService.Registry = {}

local RunService = game:GetService("RunService")
local Settings = require(script.Settings)

function NeuroService:Init()
	RunService.Heartbeat:Connect(function(dt)
		self:ProcessEntities(dt)
	end)
end

function NeuroService:Register(Instance, BrainModule, Config)
	local Entity = {
		Instance = Instance,
		Brain = require(BrainModule),
		Config = Config or {},
		Blackboard = {
			State = "Idle",
			StartTime = os.clock(),
			Memory = {},
			Entity = Instance
		},
		LastUpdate = 0
	}
	
	table.insert(self.Registry, Entity)
	return Entity
end

function NeuroService:ProcessEntities(dt)
	local TasksProcessed = 0
	local Clock = os.clock()

	for _, Entity in self.Registry do
		if TasksProcessed >= Settings.MAX_TASKS_PER_FRAME then break end

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
	end
end

return NeuroService
