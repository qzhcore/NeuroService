local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_bindable = Instance.new("BindableEvent")
	}, Signal)
end

function Signal:Connect(callback)
	return self._bindable.Event:Connect(callback)
end

function Signal:Fire(...)
	self._bindable:Fire(...)
end

function Signal:Destroy()
	self._bindable:Destroy()
end

return Signal
