local game_ui = require "vimberman.ui"
local state = require "vimberman.state"
local player = require "vimberman.player"
local tree = require "vimberman.tree"
local utils = require "vimberman.utils"

local M = {
    STATE = state.GAME_RUNNING,
    SCORE = 0,
}

local keybinds = {
    chop_left = {"h", "<Left>"},
    chop_right = {"l", "<Right>"},
}

local chop_dir

function M.new_game()
    utils.rand_init()
    tree.init()
    player.init()
    game_ui.setup_buf()
    game_ui.open_window()
    M.setup_keybinds()
    M.update_game()
end

function M.end_game()
    M.STATE = state.GAME_OVER
end

function M.update_game()
    if M.STATE == state.GAME_RUNNING then
        game_ui.set_input(true)
        game_ui.render_tree()
        game_ui.render_player()
        game_ui.set_input(false)
        print("Root: ", tree.tree[#tree.tree][2], "Above -1: ", tree.tree[#tree.tree-1][2])
        -- print("Score: ", M.SCORE)
    else
        -- print("GAME OVER. Score: ", M.SCORE)
        -- game_ui.close_window()
    end
end

function M.setup_keybinds()
    utils.nnoremap(game_ui.buf, keybinds.chop_left, function() chop_dir = tree.tree_branches.LEFT M.chop() end, "Chop chop chop")
    utils.nnoremap(game_ui.buf, keybinds.chop_right, function() chop_dir = tree.tree_branches.RIGHT M.chop() end, "Chop chop chop")
end

function M.chop()
    -- local valid_p_level = tree.is_chop_valid(#tree.tree, chop_dir)
    -- local valid_p_above = tree.is_chop_valid(#tree.tree-1, chop_dir)
    -- print("P level: ", valid_p_level, "Above: ", valid_p_above)
    -- print("P level: ", tree.tree[#tree.tree][2], "Above: ", tree.tree[#tree.tree-1][2])
    tree.move_tree()
    M.update_game()
    -- print("LOWEST ", tree.tree[#tree.tree][2], "ABOVE ", tree.tree[#tree.tree-1][2], "VALID___ ", valid)
    -- if valid then
    --     M.SCORE = M.SCORE + 1
    -- else
    --     M.STATE = state.GAME_OVER
    -- end
end

return M