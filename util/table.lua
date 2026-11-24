function values(t)
    local valuesT = {}
    for i, v in ipairs(t) do
        valuesT[i] = v
    end
    local i = 0
    return function()
        i = i + 1; return valuesT[i]
    end
end

function table.contains(tbl, value)
    for _, v in ipairs(tbl) do
        if (v == value) then
            return true
        end
    end
    return false
end

function table.containsWithOut(tbl, value, out)
    for k, v in pairs(tbl) do
        if (v == value) then
            out[0] = k
            return true
        end
    end
    return false
end

function table.find(tbl, value)
    for k, v in ipairs(tbl) do
        if (v == value) then
            return k
        end
    end
    return nil
end

function table.afind(tbl, value) -- arbitrary find
    for k, v in pairs(tbl) do
        if (v == value) then
            return k
        end
    end
    return nil
end

function table.toString(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result .. "[\"" .. k .. "\"]" .. "="
        end
        -- Check the value type
        if type(v) == "table" then
            result = result .. table.toString(v)
        elseif type(v) == "boolean" then
            result = result .. tostring(v)
        else
            result = result .. "\"" .. v .. "\""
        end
        result = result .. ","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len() - 1)
    end
    return result .. "}"
end

function table.removeValue(tbl, value)
    local index = table.find(tbl, value)
    if index == nil then return nil end
    return table.remove(tbl, index)
end

function table.length(tbl)
    local count = 0
    for _, _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function table.getKeys(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

function table.lengthSumOfContainedElements(tbl)
    local total = 0
    for k, v in pairs(tbl) do
        total = total + table.length(v)
    end
    return total
end

function table.sumOfContainedElements(tbl)
    local sum = 0
    for k, v in pairs(tbl) do
        sum = sum + v
    end
    return sum
end

function table.copy(tbl)
    local newTable = {}
    for key, value in pairs(tbl) do
        newTable[key] = value
    end
    return newTable
end

function table.deepCopy(tbl)
    local newTable = {}
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            value = table.deepCopy(value)
        end
        newTable[key] = value
    end
    return newTable
end

function table.copyTo(tbl, newTable)
    for key, value in pairs(tbl) do
        newTable[key] = value
    end
    return newTable
end

function table.deepCopyTo(tbl, newTable)
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            value = table.deepCopy(value)
        end
        newTable[key] = value
    end
    return newTable
end

function table.appendTable(tbl, tblToAppend)
    for i = 1, #tblToAppend do
        tbl[#tbl + 1] = tblToAppend[i]
    end
    return tbl
end

function table.getKeysSortedByValue(tbl, sortFunction, validationFunction)
    if validationFunction == nil then validationFunction = function(val) return true end end
    local keys = {}
    for key, _ in pairs(tbl) do
        if (validationFunction(tbl[key])) then
            table.insert(keys, key)
        end
    end

    table.sort(keys, function(a, b)
        return sortFunction(tbl[a], tbl[b])
    end)

    return keys
end
