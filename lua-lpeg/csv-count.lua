#!/usr/bin/env lua
local lpeg = require "lpeg"

local field = '"' * lpeg.Cs(((lpeg.P(1) - '"') + lpeg.P'""' / '"')^0) * '"' +
lpeg.C((1 - lpeg.S',\n"')^0)

local record = field * (',' * field)^0 * (lpeg.P'\n' + -1)

function csv (s)
    return lpeg.match(record, s)
end

-- Sum field provided by argument fields from stdin
local field = tonumber(arg[1])
local fh,err = io.open(arg[2])
if err then print("Could not open file") ; return ; end

local n = 0
for l in fh:lines() do
    local rec = {csv(l)}
    n = n + tonumber(rec[field])
end
fh:close()
