return {
main = function(spawn)
print("I control everything")
require("util.print")
servo = require("servo/client").init("base")
sleep(0.1)
servo.set_rpm(60)
servo.set_angle(90)
end
}
