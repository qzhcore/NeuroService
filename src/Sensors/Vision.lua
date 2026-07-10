local Vision = {}

local function getPosition(target: Instance): Vector3?
	if target:IsA("BasePart") then
		return target.Position
	end

	if target:IsA("Model") then
		local primaryPart = target.PrimaryPart
		return if primaryPart ~= nil then primaryPart.Position else target:GetPivot().Position
	end

	return nil
end

function Vision.CanSee(Entity, Target: Instance, FOV, Distance)
	local entityModel = Entity.Instance
	local primaryPart = entityModel.PrimaryPart
	if primaryPart == nil then
		return false
	end

	local Origin = primaryPart.Position
	local TargetPos = getPosition(Target)
	if TargetPos == nil then
		return false
	end

	local Direction = TargetPos - Origin
	local Magnitude = Direction.Magnitude
	if Magnitude <= 0 or Magnitude > Distance then
		return false
	end

	local Forward = primaryPart.CFrame.LookVector
	local Dot = math.clamp(Forward:Dot(Direction.Unit), -1, 1)
	local Angle = math.deg(math.acos(Dot))

	if Angle > (FOV / 2) then
		return false
	end

	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = { entityModel }
	Params.FilterType = Enum.RaycastFilterType.Exclude

	local Result = workspace:Raycast(Origin, Direction, Params)

	if Result == nil then
		return true
	end

	if Result.Instance == Target or Result.Instance:IsDescendantOf(Target) then
		return true
	end

	return false
end

return Vision
