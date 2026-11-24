dofile("servo/motor.lua")

local deg_per_tick_per_rpm = 0.6
function make_servo_with_speed_controller(speed_controller, rpm_multiplier)
	function speed_controller.setSpeed(rpm)
		speed_controller.setTargetSpeed(rpm)
	end
	return make_servo(speed_controller, rpm_multiplier)
end
