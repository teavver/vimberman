local game_ui = require "vimberman.ui"
local game_state = require "vimberman.state"
local player = require "vimberman.player"
local tree = require "vimberman.tree"

local M = {
    STATE = game_state.GAME_RUNNING,
    SCORE = 0,
}

function M.new_game()
    tree.init()
    player.init()
    game_ui.setup_buf()
    game_ui.open_window()
    game_ui.buf_set_lines_sprite(0, -1, false, true, tree.tree)
    game_ui.buf_set_lines_sprite(tree.TREE_HEIGHT, -1, false, false, player.player)
    game_ui.set_input(false)
end

function M.end_game()
end

function M.update_game()
end

return M