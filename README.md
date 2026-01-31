# NeuroService
A high-performance, modular AI framework for Roblox.

NeuroService is designed to handle hundreds of NPCs by utilizing State-Based logic, Blackboard memory, and LOD (Level of Detail) throttling. It decouples "Senses" (Sensors) from "Logic" (Brains), making it adaptable for any game genere.

# Installation

Option: 1 Rojo
1. Clone this repository to your local machine/device
2. Install the Rojo extension in VS Code and the Rojo Plugin in Roblox Studio
3. In VS Code, run "rojo serve"
4. In Roblox Studio, open the Rojo plugin and click Connect.
5. The framework will sync to ServerScriptService.NeuroService.

Option 2: Manual Installation
1. Create a Folder in ServerScriptService named NeuroService
2. Copy the files from the src directory into that folder, maintaing the structure:
  - init.lua (Rename to NeuroService ModuleScript)
  - Settings.lua
  - Sensors/
  - Brains/
  - Shared/
  - Internal/

  # Configuration
  The framework is turned in src/Settings. You can optimize performance here:
  local Settings = {
	MAX_TASKS_PER_FRAME = 20,    -- Limits how many AI updates happen per frame
	DEFAULT_THROTTLE = 0.1,      -- How often (in seconds) an AI updates
	
	LOD_ENABLED = true,          -- Turn on Level of Detail
	DISTANCE_FAR = 300,          -- Distance to start slowing down AI updates
	DISTANCE_CULL = 1000,        -- Distance to stop AI updates entirely
}

# Usage Example
To register an NPC, simple pass the model and the desired Brain module to the service:
local NeuroService = require(game.ServerScriptService.NeuroService)
local ZombieBrain = require(game.ServerScriptService.NeuroService.Brains.Zombie)

-- Register the entity
NeuroService:Register(workspace.MyNPC, ZombieBrain)

-- Start the engine
NeuroService:Init()

# Project Structure
- Sensors/ - Pure perception logic (Vision, Hearing, etc)
- Brains/ - State-machine logic for different NPC types.
- Shared/ - Modules accessibile by both Server and Client.
- Internal/ - Utility math and core engine helper functions.

# Bug Reports & Support
If you encounter any issues, bugs, or performance bottlenecks, please report them immediately through one of the following channels:
* **[Join our Discord Server](https://discord.gg/j2hZhMGb)** for real-time support and community chat.
* **[Email Support](mailto:expressionsqzhl@gmail.com)** for direct inquiries.

