local utils = require "vimberman.utils"

local M = {
    player = {},
    PLAYER_HEIGHT = 3
}

local player_sprite = {
    {
        " {|   o    ",
        "  |={[V]}  ",
        "    _| |_  ",
    },
    {
        "    o   |} ",
        "  {[V]}=|  ",
        "  _| |_    ",
    },
    {
        "     x     ",
        " ._{[V]}_. ",
    },
}

function M.init()
    M.set_player_frame(1)
end

function M.set_player_frame(idx)
    if player_sprite[idx] == nil or player_sprite[idx] == '' then
        utils.err("Failed to set player sprite (invalid index)")
        return       
    end

    for i = 1, #player_sprite[idx] do
        M.player[i] = player_sprite[idx][i]
    end
end

return M