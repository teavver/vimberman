local ui = require "vimberman.ui"
local game_state = require "vimberman.state"
local tree = require "vimberman.tree"

local M = {
    STATE = game_state.GAME_RUNNING,
    SCORE = 0,
}

function M.start_game()
    tree.init()
    ui.open_window()
    ui.render_tree(tree.tree)
end

function M.end_game()
end

function M.update_game()
end

return M