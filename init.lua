-- logging/init.lua
-- Create logging functions for mods easily
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.0-or-later
local minetest, error, format = minetest, error, string.format
local logging = {}

function logging.format_message(mod, msg, ...)
    if type(msg) ~= "string" then
        msg = dump(msg)
    end

    if #{ ... } > 0 then
        msg = format(msg, ...)
    end

    return "[" .. mod .. "] " .. msg
end

local index_table = {}

-- Any level
index_table.log = function(self, lvl, msg, ...)
    minetest.log(lvl, logging.format_message(self.mod, msg, ...))
end

-- Normal loggings
for _, lvl in ipairs({ "none", "error", "warning", "action", "info", "verbose" }) do
    index_table[lvl] = function(self, msg, ...)
        minetest.log(lvl, logging.format_message(self.mod, msg, ...))
    end
end

-- Debug
index_table.debug = function(self, ...)
    self:none(logging.format_message(self.mod, table.concat({ ... }, "\t")))
end

-- Raise error
index_table.raise = function(self, msg, ...)
    error(logging.format_message(self.mod, msg, ...), 2)
end

-- Assertion
index_table.assert = function(self, condition, msg, ...)
    if not msg then
        msg = "Assertion failed!"
    end
    return assert(condition, logging.format_message(self.mod, msg, ...))
end

-- Create sublogger
index_table.sublogger = function(self, name)
    return logging.logger(self.mod .. "." .. name)
end

local metatable = {}
metatable.__index = index_table
metatable.__newindex = function(self)
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

_G.logging = logging
self_logger:action("Loaded %s", "logging mod")
