dofile("servo/updater.lua")

function start_servo_server(servo)
	local modem = peripheral.find("modem")
	if modem == nil then error("no modem attached", 2) end
	if not rednet.isOpen(peripheral.getName(modem)) then
		rednet.open(peripheral.getName(modem))
	end

	local f1 = function()
		while true do
			update_servos()
		end
	end

	local f2 = function()
		while true do
			local sender, msg = rednet.receive("servo")
			if sender and msg then
				if msg.cmd == "set_zero" then
					servo.set_zero()
				elseif msg.cmd == "set_angle_in_sec" then
					servo.set_angle_in_sec(msg.angle, msg.time)
				elseif msg.cmd == "set_angle" then
					servo.set_angle(msg.angle)
				elseif msg.cmd == "set_rpm" then
					servo.set_rpm(msg.rpm)
				end
			end
		end
	end

	parallel.waitForAll(
		f1,
		f2
	)
end
