# NeuroService

A modular AI framework for Roblox NPC systems.

NeuroService separates perception logic from entity behavior so NPCs can share sensors, state logic, and level-of-detail throttling. The project is designed around state-based logic, blackboard memory, and configurable update limits.

## Installation

### Option 1: Rojo

1. Clone this repository to your local machine.
2. Install the Rojo extension in VS Code and the Rojo Plugin in Roblox Studio
3. In VS Code, run `rojo serve`.
4. In Roblox Studio, open the Rojo plugin and click Connect.
5. The framework will sync to ServerScriptService.NeuroService.

### Option 2: Manual Installation

1. Create a folder in `ServerScriptService` named `NeuroService`.
2. Copy the files from the `src` directory into that folder, maintaining the structure:
   - `init.lua` (rename to the `NeuroService` ModuleScript)
   - `Settings.lua`
   - `Sensors/`
   - `Shared/`
   - `Internal/`

## Configuration

The framework is configured in `src/Settings.lua`. You can tune update limits and LOD behavior there:

```lua
local Settings = {
	MAX_TASKS_PER_FRAME = 20, -- Limits how many AI updates happen per frame
	DEFAULT_THROTTLE = 0.1, -- How often (in seconds) an AI updates

	LOD_ENABLED = true, -- Turn on Level of Detail
	DISTANCE_FAR = 300, -- Distance to start slowing down AI updates
	THROTTLE_FAR = 0.25, -- Update interval to use when an entity is far away
}
```

## API

Full API reference: [docs/API.md](docs/API.md).

Build a distributable package:

```bash
rojo build pack.project.json --output build/NeuroService.rbxm
```

## Usage Example

To register an NPC, pass the model and the desired brain module to the service:

```lua
local NeuroService = require(game.ServerScriptService.NeuroService)
local ZombieBrain = require(game.ServerScriptService.NeuroService.Brains.Zombie)

-- Register the entity
NeuroService:Register(workspace.MyNPC, ZombieBrain)

-- Start the engine
NeuroService:Init()
```

## Project Structure

- `Sensors/` - Perception logic such as vision.
- `Shared/` - Modules accessible by both server and client code.
- `Internal/` - Utility math and core engine helper functions.

## Bug Reports & Support

If you encounter any issues, bugs, or performance bottlenecks, please report them immediately through one of the following channels:

* **[Join our Discord Server](https://discord.gg/j2hZhMGb)** for real-time support and community chat.
* **[Email Support](mailto:expressionsqzhl@gmail.com)** for direct inquiries.

