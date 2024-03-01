# Logging API

This mod provides an easy way to construct a logger for mods. All messages are formatted like `[name] <message>` in the console and `debug.txt`.

## Usage

```lua
-- Let's say your mod's name is "mymod".
local logger = logging.logger("mymod")

-- This logs a message in the WARNING level.
-- These levels are avaliable: none, error, warning, action, info, verbose
logger:warning("Test warning")
--- Output: WARNING[Main]: [mymod] Test warning


-- This creates a sublogger named mycomponent
-- The resulting name will be mymod.mycomponent
local sublogger = logger:sublogger("mycomponent")

-- Log with the sublogger
sublogger:action("Test action")
--- Output: ACTION[Main]: [mymod.mycomponent] Test action

-- Assert if an condition is true
sublogger:assert(true, "lol")
--- Output: nothing (assertion succeed)

-- Raise an error with the given message
sublogger:raise("Test crash")
--- Result: Crashes with "[mymod.mycomponent] Test crash"
```
