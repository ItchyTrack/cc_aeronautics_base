local motor = require("servo/motor")
local this = {}
this.new = function(speed_controller, rpm_multiplier)
function speed_controller.setSpeed(rpm)
speed_controller.setTargetSpeed(rpm)
end
return motor.new(speed_controller, rpm_multiplier)
end
return this
