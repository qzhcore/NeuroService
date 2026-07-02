local Settings = {
	-- Performance & batching
	MAX_TASKS_PER_FRAME = 20,
	DEFAULT_THROTTLE = 0.1,

	-- LOD (Level of Detail)
	LOD_ENABLED = true,
	DISTANCE_FAR = 300,
	THROTTLE_FAR = 0.25,

	-- Debugging
	DEBUG = false,
}

return table.freeze(Settings)
