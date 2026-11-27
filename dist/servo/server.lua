this = {}
this.init_server = function(spawn, servo, id)
local modem = peripheral.find("modem")
if modem == nil then error("no modem attached", 2) end
if not rednet.isOpen(peripheral.getName(modem)) then
rednet.open(peripheral.getName(modem))
end
spawn(function()
while true do
local sender, msg = rednet.receive("servo")
if sender and msg then
print(msg.id)
if id ~= msg.id then goto continue end
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
::continue::
end
end)
end
return this
