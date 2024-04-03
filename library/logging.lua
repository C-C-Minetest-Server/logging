---@meta
-- logging/library/logging.lua
-- Lua Language Server integration
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.0-or-later

---Create logging functions for mods easily
logging = {}

---Class of logger
---@class (exact) Logger: table
---@field mod string The name of the component using this logger
local Logger = {}

---Format a message with the mod name and the message
---@param mod string
---@param msg string
function logging.format_message(mod, msg) end

---Create a new logger
---@param mod? string Defaults to the current mod name.
---@return Logger logger
function logging.logger(mod) end

---@alias LoggerLogLevels
---|> '"none"'
---|  '"error"'
---|  '"warning"'
---|  '"action"'
---|  '"info"'
---|  '"verbose"'

---Log a message in the given log level
---@param lvl LoggerLogLevels The level of the log.
---@param msg string The message to be logged.
function Logger:log(lvl, msg) end

---Log a message in the "none" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:none(msg) end

---Log a message in the "error" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:error(msg) end

---Log a message in the "warning" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:warning(msg) end

---Log a message in the "action" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:action(msg) end

---Log a message in the "info" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:info(msg) end

---Log a message in the "verbose" log level.
---@param msg string The message to be logged.
---@see minetest.log
function Logger:verbose(msg) end

---Equivalent to `Logger:none(table.concat({...}, "\t"))`
---@vararg any The information to be logged
---@see Logger.none
---@see minetest.debug
function Logger:debug(...) end

---Raise an error with the given message.
---@param msg string The message to be shown
---@see error
function Logger:raise(msg) end

---Raise an error with `msg` if the given `condition` is `false` or `nil`.
---Otherwise, return the `condition`.
---@param condition any
---@param msg? string Defaults to `"Assertion failed!"`
---@see assert
function Logger:assert(condition, msg) end

---Create a sublogger, whose `mod` will be `{mod}.{name}`
---@param name string The appended name
---@return Logger sublogger
---@see logging.logger
function Logger:sublogger(name) end
