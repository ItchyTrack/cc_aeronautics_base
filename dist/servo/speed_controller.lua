require("servo/motor")
this = {}
this.new = function(speed_controller, rpm_multiplier)
function speed_controller.setSpeed(rpm)
speed_controller.setTargetSpeed(rpm)
end
return make_servo(speed_controller, rpm_multiplier)
end
return this
