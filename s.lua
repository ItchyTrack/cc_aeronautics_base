dofile("servo/updater.lua")
dofile("servo/speed_controller.lua")
dofile("servo/server.lua")
clear_servos()

start_servo_server(make_servo_with_speed_controller(peripheral.wrap("right"), 4))
