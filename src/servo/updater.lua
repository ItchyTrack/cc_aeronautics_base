local this = {}

this.servos = {}
this.is_running = false

this.init = function(spawn)
	if this.is_running then return end
	this.is_running = true
	spawn(function()
		while true do
			for _, servo in pairs(this.servos) do
				if servo == nil or servo.active ~= true then goto continue end
				servo.update()
				::continue::
			end
			sleep(1/20)
		end
	end)
end

return this
