return {
	main = function(spawn)
		print("I control everything")
		require("util.print")
		local servo_client = require("servo/client")
		base_servo = servo_client.init("base")
		shoulder_servo = servo_client.init("shoulder")
		elbow_servo = servo_client.init("elbow")
		sleep(0.5)
		base_servo.set_rpm(60)
		shoulder_servo.set_rpm(60)
		elbow_servo.set_rpm(60)

		base_servo.set_angle(45)
		shoulder_servo.set_angle(30)
		elbow_servo.set_angle(15)
	end
}
