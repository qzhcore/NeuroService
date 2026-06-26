# Welcome to NeuroService API

NeuroService is a high-performance AI framework built for the modern Roblox environment. 

### Core Modules
- **[NeuroService](api/NeuroService)**: The main engine controller.
- **[Vision](api/Vision)**: Raycast-based perception.
- **[Utility](api/Utility)**: Shared math and logic helpers.

### Getting Started
To begin, register an entity using `NeuroService:Register(Instance, BrainModule)`. The engine will automatically handle state switching and LOD throttling.

### Development Notes
- `default.project.json` maps the `src` directory into `ServerScriptService.NeuroService` for Rojo workflows.
- Runtime behavior is configured in `src/Settings.lua`.
- Shared modules live under `src/Shared`, while internal helpers live under `src/Internal`.
