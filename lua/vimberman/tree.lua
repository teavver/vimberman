local utils = require "vimberman.utils"

local M = {
    tree = {},
    TREE_SPRITE_HEIGHT = 3,
    TREE_HEIGHT = 10,
}

M.tree_branches = {
    NONE = 1,
    LEFT = 2,
    RIGHT = 3,
}

local tree_sprite = {
    {
        "          |``  |          ",
        "          |  ` |          ",
        "          |`  `|          ",
    },
    {
        "   +&+    |  ``|          ",
        "=+&&&&&+==| `  |          ",
        " +&&+     |  ` |          ",
    },
    {
        "          |  ` |  +&&+    ",
        "          | `` |==&&&&&&+=",
        "          | `  |   +&&+   ",
    },
}

function M.init()
    for i = 1, M.TREE_HEIGHT do
        if i % 2 == 0 then
            M.set_chunk(i, M.tree_branches.NONE)
        else
            M.set_chunk_rand_branch(i)
        end
    end
end

function M.set_chunk_rand_branch(idx)
    local isLeftBranch = utils.rand_bool()
    if isLeftBranch == true then
        M.tree[idx] = tree_sprite[M.tree_branches.LEFT]
        else
        M.tree[idx] = tree_sprite[M.tree_branches.RIGHT]
    end
end

function M.get_chunk(idx)
    if idx > #M.tree or idx < 1 then
        utils.err("Can't get tree chunk, out of bounds") return
    end
    return M.tree[idx]
end

function M.set_chunk(idx, type)
    M.tree[idx] = tree_sprite[type]
end

function M.is_branch(chunk_idx, side)
    local chunk = M.get_chunk(chunk_idx)
    if chunk == tree_sprite[M.tree_branches.NONE] then
        return false
    end
    if side == M.tree_branches.LEFT then
        return chunk == tree_sprite[M.tree_branches.LEFT]
    else
        return chunk == tree_sprite[M.tree_branches.RIGHT]
    end
end

function M.is_chop_valid(idx, chop_dir)
    if M.get_chunk(idx) == tree_sprite[chop_dir] then return false
    else return true
    end
end

function M.move_tree()
    local top = M.get_chunk(1)
    table.remove( M.tree, #M.tree)
    table.insert(M.tree, 1, nil)
    if top == tree_sprite[M.tree_branches.LEFT] then
        M.set_chunk(1, M.tree_branches.NONE)
    elseif top == tree_sprite[M.tree_branches.RIGHT] then
        M.set_chunk(1, M.tree_branches.NONE)
    else
        M.set_chunk_rand_branch(1)
    end
end

return M
