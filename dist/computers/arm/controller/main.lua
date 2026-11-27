return {
main = function(spawn)
print("I control everything")
servo = require("servo/client").init("base")
servo.set_rpm(60)
servo.set_angle(90)
end
}
