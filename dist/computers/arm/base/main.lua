return {
main = function(spawn)
require("util/print")
require("servo/updater").init(spawn)
local servo = require("servo/speed_controller").new(peripheral.wrap("right"), 4)
require("servo/server").init_server(spawn, servo, "base")
end
}
