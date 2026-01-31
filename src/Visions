local Vision = {}

function Vision.CanSee(Entity, Target, FOV, Distance)
	local Origin = Entity.Instance.PrimaryPart.Position
	local TargetPos = Target.Position
	local Direction = (TargetPos - Origin)
	
	if Direction.Magnitude > Distance then return false end
	
	local Forward = Entity.Instance.PrimaryPart.CFrame.LookVector
	local Angle = math.deg(math.acos(Forward:Dot(Direction.Unit)))
	
	if Angle > (FOV / 2) then return false end
	
	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = {Entity.Instance}
	Params.FilterType = Enum.RaycastFilterType.Exclude
	
	local Result = workspace:Raycast(Origin, Direction, Params)
	
	if Result and Result.Instance:IsDescendantOf(Target.Parent) then
		return true
	end
	
	return false
end

return Vision
