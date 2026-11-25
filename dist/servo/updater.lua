if servos == nil then
servos = {}
end
function clear_servos()
servos = {}
end
function update_servos()
for _, servo in pairs(servos) do
if servo == nil or servo.active ~= true then ::continue:: end
servo.update()
end
sleep(1/20)
end
