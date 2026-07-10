# NeuroService API

`NeuroService` is a server-side Roblox NPC framework for registering model-backed entities, running brain state functions on a throttled update loop, and sharing perception helpers such as vision checks.

## Import

```lua
local NeuroService = require(game.ServerScriptService.NeuroService)
```

## Lifecycle

### `NeuroService:Init(): ()`

Starts the Heartbeat processing loop. Calling `Init` more than once is safe; only one loop is connected.

```lua
NeuroService:Init()
```

### `NeuroService:Destroy(): ()`

Disconnects the Heartbeat loop and clears the entity registry.

```lua
NeuroService:Destroy()
```

## Entity Registration

### `NeuroService:Register(instance: Model, brainModule, config?): Entity`

Registers an NPC model with a brain module or brain table.

```lua
local ZombieBrain = require(script.ZombieBrain)

local entity = NeuroService:Register(workspace.Zombie, ZombieBrain, {
	Team = "Undead",
})
```

Brain modules are tables keyed by blackboard state:

```lua
return {
	Idle = function(blackboard, dt)
		blackboard.State = "Patrol"
	end,

	Patrol = function(blackboard, dt)
		-- Move or scan here.
	end,
}
```

Registered entities expose:

| Field | Description |
| --- | --- |
| `Instance` | The registered NPC `Model`. |
| `Brain` | The required brain table. |
| `Config` | Per-entity configuration table. |
| `Blackboard` | Mutable state passed to brain functions. |
| `LastUpdate` | Last processed `os.clock()` timestamp. |

### `NeuroService:Unregister(entityOrModel): boolean`

Removes an entity by entity record or by model.

```lua
NeuroService:Unregister(entity)
NeuroService:Unregister(workspace.Zombie)
```

## Processing

### `NeuroService:ProcessEntities(dt: number): ()`

Processes registered entities until `Settings.MAX_TASKS_PER_FRAME` is reached.

The service automatically removes entities whose models have been destroyed. Each active entity runs the function matching `entity.Blackboard.State` when its throttle interval has elapsed.

## Settings

Settings live in `src/Settings.lua`.

| Setting | Description |
| --- | --- |
| `MAX_TASKS_PER_FRAME` | Maximum brain updates processed each Heartbeat. |
| `DEFAULT_THROTTLE` | Baseline seconds between updates per entity. |
| `LOD_ENABLED` | Enables distance-based throttling. |
| `DISTANCE_FAR` | Distance where far throttling begins. |
| `THROTTLE_FAR` | Seconds between far-entity updates. |
| `DEBUG` | Reserved debug flag. |

## Vision Sensor

### `Vision.CanSee(entity, target: Instance, fov: number, distance: number): boolean`

Returns whether the entity can see a target `BasePart` or `Model`.

```lua
local Vision = require(game.ServerScriptService.NeuroService.Sensors.Vision)

if Vision.CanSee(entity, workspace.PlayerCharacter, 90, 120) then
	entity.Blackboard.State = "Chase"
end
```

`CanSee` returns `false` when:

- the entity has no `PrimaryPart`
- the target has no resolvable position
- the target is out of range
- the target is outside the field of view
- raycast line of sight is blocked

## Build

Use Rojo to build either a full test place mapping or a distributable package model:

```bash
rojo build default.project.json --output build/NeuroService.rbxlx
rojo build pack.project.json --output build/NeuroService.rbxm
```
