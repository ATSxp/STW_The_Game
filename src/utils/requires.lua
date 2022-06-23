-- Assets
require("src/utils/resources")

-- Managers
require("src/managers/general_math")
require("src/managers/state")
require("src/managers/anim")
require("src/managers/sprite")
require("src/managers/particles")
require("src/managers/textbox")
require("src/managers/ents")

-- Utils
require("src/utils/utilities")

-- States
require("src/states/game")

-- Actors
require("src/actors/player")

stateManager:add("game", Game)
stateManager:active("game")