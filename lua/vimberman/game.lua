local game_ui = require "vimberman.ui"
local game_state = require "vimberman.state"
local player = require "vimberman.player"
local tree = require "vimberman.tree"
local utils = require "vimberman.utils"

local M = {
    STATE = game_state.GAME_RUNNING,
    SCORE = 0,
}

local keybinds = {
    chop_left = {"h", "<Left>"},
    chop_right = {"l", "<Right>"},
}

function M.new_game()
    tree.init()
    player.init()
    game_ui.setup_buf()
    game_ui.open_window()
    M.setup_keybinds()
    M.update_game()
    -- game_ui.set_input(false)
end

function M.end_game()
end

function M.update_game()
    game_ui.render_tree()
    game_ui.render_player()
end

function M.setup_keybinds()
    utils.nnoremap(game_ui.buf, keybinds.chop_left, function() M.chop("left") end, "Chop chop chop")
    utils.nnoremap(game_ui.buf, keybinds.chop_right, function() M.chop("right") end, "Chop chop chop")
end

function M.foo()
    print("Chop")
end

function M.chop(dir)
    if dir == "left" then
        player.set_player_frame(2)
    elseif dir == "right" then
        player.set_player_frame(5)
    else end
    M.update_game()
end

return M