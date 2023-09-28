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
        M.set_chunk_random(i)
        -- M.set_chunk(i+1, M.tree_branches.NONE)
    end
    M.tree[#M.tree] = tree_sprite[M.tree_branches.NONE]
end

function M.set_chunk_random(idx)
    local isBranch = utils.rand_bool()
        if isBranch == true then
            local isLeftBranch = utils.rand_bool()
            if isLeftBranch == true then
                M.tree[idx] = tree_sprite[M.tree_branches.LEFT]
            else
                M.tree[idx] = tree_sprite[M.tree_branches.RIGHT]
        end
        else M.tree[idx] = tree_sprite[M.tree_branches.NONE]
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

function M.is_chop_valid(dir --[[tree_branches]])
    if M.get_chunk(#M.tree) == tree_sprite[dir]
    -- or M.get_chunk(#M.tree-1) == tree_sprite[dir]
    then
        return false
    else
        return true
    end
end

function M.move_tree()
    table.remove( M.tree, #M.tree)
    table.insert(M.tree, 1, nil)
    M.set_chunk_random(1)
end

return M
