-- logging/init.lua
-- Create logging functions for mods easily
--[[
    logging: Create logging functions for mods easily
    Copyright (C) year  name of author

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

logging = {}
function logging.format_message(mod, msg)
    if type(msg) ~= "string" then
        msg = dump(msg)
    end
    return "[" .. mod .. "] " .. msg
end

local index_table = {}

-- Normal loggings
for _, lvl in ipairs({"none", "error", "warning", "action", "info", "verbose"}) do
    index_table[lvl] = function(self, msg)
        minetest.log(lvl, logging.format_message(self.mod, msg))
    end
end

-- Debug
index_table.debug = function(self, ...)
    self:none(logging.format_message(self.mod, table.concat({...}, "\t")))
end

-- Raise error
index_table.raise = function(self, msg)
    error(logging.format_message(self.mod, msg), 2)
end

-- Create sublogger
index_table.sublogger = function(self, name)
    return logging.logger(self.mod .. "." .. name)
end

local metatable = {}
metatable.__index = index_table
metatable.__newindex = function(self, k, v)
    error("Attempt to set new field in logger " .. self.mod, 2)
end

function logging.logger(mod)
    if not mod then
        mod = minetest.get_current_modname() or "???"
    end
    return setmetatable({
        mod = mod,
    }, metatable)
end

local self_logger = logging.logger("logging")

self_logger:action("Loaded")
