local utils = require "vimberman.utils"
local tree = require "vimberman.tree"

local M = {
    player = {},
    state = nil,
    PLAYER_HEIGHT = 3,
}

M.player_states = {
    STANDING_LEFT = 1,
    STANDING_LEFT_BRANCH = 2,
    CHOPPING_LEFT = 3,
    CHOPPING_LEFT_BRANCH = 4,
    GAME_OVER_LEFT = 5,
    STANDING_RIGHT = 6,
    STANDING_RIGHT_BRANCH = 7,
    CHOPPING_RIGHT = 8,
    CHOPPING_RIGHT_BRANCH = 9,
    GAME_OVER_RIGHT = 10,
}

local player_sprite = {
    {
        " {|   o   |``  |          ",
        "  |={###} |  ` |          ",
        "    _| |_ |`  `|          ",
    },
    {
        " {|   o   |``  |  +&&+    ",
        "  |={###} |  ` |==&&&&&&+=",
        "    _| |_ |`  `|   +&&+   ",
    },
    {
        "      o   |``  |          ",
        "     ###}-+==- |          ",
        "    _| |_ |`  `|          ",
    },
    {
        "      o   |``  |  +&&+    ",
        "     ###}-+==- |==&&&&&&+=",
        "    _| |_ |`  `|   +&&+   ",
    },
    {
        "  _____   |``  |          ",
        "=| RIP |==|  ` |          ",
        " |     |  |`  `|          ",
    },
    {
        "          |``  |   o   |} ",
        "          |  ` | {###}=|  ",
        "          |`  `| _| |_    ",
    },
    {
        "   +&+    |``  |   o   |} ",
        "=+&&&&&+==|  ` | {###}=|  ",
        " +&&+     |`  `| _| |_    ",
    },
    {
        "          |``  |   o      ",
        "          | -==+-{###     ",
        "          |`  `| _| |_    ",
    },
    {
        "    +&+   |``  |   o      ",
        "=+&&&&&+==| -==+-{###     ",
        "  +&&+    |`  `| _| |_    ",
    },
    {
        "          |``  |   _____  ",
        "          |  ` |==| RIP |=",
        "          |`  `|  |     | ",
    },
}

function M.init()
    if utils.rand_bool() == true then
        M.set_player_state(M.player_states.STANDING_LEFT)
    else
        M.set_player_state(M.player_states.STANDING_RIGHT)
    end
end

function M.set_player_state(idx)

    if player_sprite[idx] == nil or player_sprite[idx] == '' then
        utils.err("Failed to set player sprite (invalid index)")
        return
    end

    M.state = M.player_states[idx]

    for i = 1, #player_sprite[idx] do
        M.player[i] = player_sprite[idx][i]
    end
end

-- lord forgive me for this ugly ass function
function M.move_player(dir, valid_root, valid_above)
    if not valid_root then
        if dir == tree.tree_branches.LEFT then
            M.set_player_state(M.player_states.GAME_OVER_LEFT) return
        else
            M.set_player_state(M.player_states.GAME_OVER_RIGHT) return
        end
    end

    if not valid_above then
        if dir == tree.tree_branches.LEFT then
            M.set_player_state(M.player_states.GAME_OVER_LEFT)
        else
            M.set_player_state(M.player_states.GAME_OVER_RIGHT)
        end
    else
        if dir == tree.tree_branches.LEFT then
            if tree.is_branch(#tree.tree-1, tree.tree_branches.RIGHT) then
                M.set_player_state(M.player_states.CHOPPING_LEFT_BRANCH) return
            else
                M.set_player_state(M.player_states.CHOPPING_LEFT)
            end
        else
            if tree.is_branch(#tree.tree-1, tree.tree_branches.LEFT) then
                M.set_player_state(M.player_states.CHOPPING_RIGHT_BRANCH) return
            else
                M.set_player_state(M.player_states.CHOPPING_RIGHT)
            end
        end
    end
end

return M