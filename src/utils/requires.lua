-- Managers
require("src/managers/general_math")
require("src/managers/state")

-- Utils
require("src/utils/utilities")

-- States
require("src/states/game")

stateManager:add("game", Game)
stateManager:active("game")