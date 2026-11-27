local updater = require("servo/updater")
local deg_per_tick_per_rpm = 0.6
local this = {}
this.new = function(motor, rpm_multiplier)
motor.setSpeed(0)
local current_angle = 0;
local wanted_rpm = 0;
local wanted_angle = 0;
servo = {
active = true,
motor = motor,
set_zero = function() current_angle = 0 end,
set_angle = function(angle) wanted_angle = angle end,
set_rpm = function(rpm) wanted_rpm = rpm end,
set_angle_in_sec = function(angle, time)
wanted_angle = angle
wanted_rpm = math.abs(current_angle-angle) / deg_per_tick_per_rpm / (time * 20)
end,
get_rpm = function() return wanted_rpm end,
get_wanted_angle = function() return wanted_angle end,
get_angle = function() return current_angle end,
is_at_angle = function() return math.abs(current_angle - wanted_angle) < 0.01 end,
update = function()
if math.abs(current_angle - wanted_angle) < 0.01 or wanted_rpm <= 0 then
motor.setSpeed(0)
return
end
rpm = math.min(wanted_rpm, 60)
wanted_delta = wanted_angle - current_angle
delta = deg_per_tick_per_rpm * rpm
if delta > math.abs(wanted_delta) then
current_angle = wanted_angle
rpm = wanted_delta / deg_per_tick_per_rpm
else
if wanted_delta < 0 then rpm = -rpm end
current_angle = current_angle + deg_per_tick_per_rpm * rpm
end
motor.setSpeed(rpm * rpm_multiplier)
end,
}
updater.servos[#updater.servos + 1] = servo
return servo
end
return this
