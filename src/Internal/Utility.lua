local Utility = {}

function Utility.GetRandomPointInRadius(Center, Radius)
	local Angle = math.rad(math.random(0, 360))
	local Dist = math.random(0, Radius)
	return Center + Vector3.new(math.cos(Angle) * Dist, 0, math.sin(Angle) * Dist)
end

function Utility.Lerp(a, b, t)
	return a + (b - a) * t
end

return Utility
