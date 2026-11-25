dofile("servo/updater.lua")
dofile("servo/client.lua")
clear_servos()

servo = make_remote_servo(6)

servo.set_zero()
steps = {0, 90, 0, 45, 90, 0, 30, 60, 90, 0, 15, 30, 45, 60, 75, 90, 0}

step = 0
while true do
	if servo.is_at_angle() then
		if step ~= 0 then
			servo.set_angle_in_sec(steps[step], 0.1)
			update_servos()
		end
		step = step + 1
		if step > #steps then break end
		sleep(0.1)
		servo.set_angle_in_sec(steps[step], 0.1)
	end
	update_servos()
end
