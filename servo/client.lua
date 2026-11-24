dofile("servo/updater.lua")

function make_servo_client(server_id)
	local modem = peripheral.find("modem")
	if modem == nil then error("no modem attached", 2) end
	if not rednet.isOpen(peripheral.getName(modem)) then
		rednet.open(peripheral.getName(modem))
	end

	local function send(msg) rednet.send(server_id, msg, "servo") end

	local servo = {
		set_zero = function()
			send({ cmd = "set_zero" })
		end,
		set_angle_in_sec = function(angle, time)
			send({ cmd = "set_angle_in_sec", angle = angle, time = time })
		end,
		set_angle = function(angle)
			send({ cmd = "set_angle", angle = angle })
		end,
		set_rpm = function(rpm)
			send({ cmd = "set_rpm", rpm = rpm })
		end,
		update = function()
			send({ cmd = "ping" })
		end,
	}

	servos[#servos + 1] = servo
	return servo
end
