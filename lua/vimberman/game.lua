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
    game_ui.set_title_content("Vimberman")
    M.setup_keybinds()
    M.update_game()
end

function M.update_game()
    game_ui.set_input(true)
    game_ui.render_tree()
    game_ui.render_player()
    if M.STATE == state.GAME_OVER then
        game_ui.set_title_content("GAME OVER! Your score: " .. M.SCORE)
    end
    game_ui.set_input(false)
end

function M.setup_keybinds()
    utils.nnoremap(game_ui.buf, keybinds.chop_left, function() chop_dir = tree.tree_branches.LEFT M.chop() end, "Chop chop chop")
    utils.nnoremap(game_ui.buf, keybinds.chop_right, function() chop_dir = tree.tree_branches.RIGHT M.chop() end, "Chop chop chop")
end

function M.chop()
    if M.STATE == state.GAME_OVER then
        return
    end

    local valid_root = tree.is_chop_valid(#tree.tree, chop_dir)
    local valid_above = tree.is_chop_valid(#tree.tree-1, chop_dir)
    player.move_player(chop_dir, valid_root, valid_above)
    if valid_root then
        tree.move_tree()
    end
    if not valid_root or not valid_above then
        M.STATE = state.GAME_OVER
    else
        M.SCORE = M.SCORE + 1
    end
    M.update_game()
end

return M