require("util/table")
printOld = printOld or print
formater = {}
local formater = formater
function formater.getFormatedForPrint(val, cfg)
local newCfg = table.copy(cfg)
newCfg.depth = newCfg.depth - 1
newCfg.indentationDepth = newCfg.indentationDepth + 1
if newCfg.depth == -1 and type(val) == "table" then
return "tbl (" .. table.length(val) .. ")"
end
if val == nil then
return "nil"
elseif type(val) == "number" then
val = math.floor(val * 100 + 0.5) / 100
return tostring(val)
elseif type(val) == "table" then
local empty = true
for _, _ in pairs(val) do
empty = false
break
end
if empty then
return "{}"
end
if newCfg.depth == 0 then
return "tbl (" .. table.length(val) .. ")"
end
if table.contains(newCfg.recursedTables, val) then
newCfg.depth = 0
end
table.insert(newCfg.recursedTables, val)
local i = 1
local str = "{"
local count = 0
for key, value in pairs(val) do
if table.contains(newCfg.ignoreTypes, type(value)) then
goto continue
end
if count >= newCfg.maxTableLength then
if newCfg.unrollTables then
str = str .. "\n"
for i = 1, newCfg.indentationDepth do
str = str .. "    "
end
end
str = str .. "... (" .. table.length(val) - newCfg.maxTableLength .. " more)"
break
end
count = count + 1
if (#str > 1) then
str = str .. ","
end
if newCfg.unrollTables then
str = str .. "\n"
for i = 1, newCfg.indentationDepth do
str = str .. "    "
end
elseif (#str > 1) then
str = str .. " "
end
if (key == i) then
i = i + 1
str = str .. formater.getFormatedForPrint(value, newCfg)
else
str = str ..
"[" ..
formater.getFormatedForPrint(key, newCfg) ..
"] = " .. formater.getFormatedForPrint(value, newCfg)
end
::continue::
end
if newCfg.unrollTables then
str = str .. "\n"
for i = 1, newCfg.indentationDepth - 1 do
str = str .. "    "
end
end
return str .. "}"
elseif type(val) == "del" then
return "del"
elseif type(val) == "string" then
return "\""..val.."\""
elseif type(val) == "boolean" then
if val then
return "true"
end
return "false"
elseif type(val) == "Shape" then
return "{<Shape>, id = " .. formater.getFormatedForPrint(val:getId(), newCfg) .. "}"
elseif type(val) == "Vec3" then
return "Vec3 <" ..
formater.getFormatedForPrint(val.x, newCfg) .. ", " ..
formater.getFormatedForPrint(val.y, newCfg) .. ", " ..
formater.getFormatedForPrint(val.z, newCfg) .. ">"
elseif type(val) == "Color" then
local str = "Color <" ..
formater.getFormatedForPrint(val.r, newCfg) .. ", " ..
formater.getFormatedForPrint(val.g, newCfg) .. ", " ..
formater.getFormatedForPrint(val.b, newCfg)
if val.a ~= 1 then
str = str .. ", " .. formater.getFormatedForPrint(val.a, newCfg) .. ">"
else
str = str .. ">"
end
return str
else
local status, result = pcall(tostring, val)
if status ~= true or result == nil or result == type(val) then -- if the tostring function failed or provides no useful information
return type(val)
end
if result:sub(1, #type(val)) == type(val) then
return result
end
return type(val) .. " <" .. result .. ">"
end
end
local function fFormat(val, config)
local cfg = {
depth = 5,
maxTableLength = 100,
unrollTables = true,
indentationDepth = 0,
recursedTables = {},
ignoreTypes = {}
}
if config then
for k, v in pairs(config) do
cfg[k] = v
end
end
return formater.getFormatedForPrint(val, cfg)
end
function print(...)
local strings = {}
for i = 1, select("#", ...) do
local val = select(i, ...)
strings[#strings + 1] = fFormat(val)
end
printOld(table.concat(strings, " "))
end
function fPrint(val, config)
printOld(fFormat(val, config))
end
fprint = fPrint
