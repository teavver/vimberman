local tree_sprite = {
    "         |     |         ",
    "======+=<|     |         ",
    "         |     |>===+====",
}

local M = {
    tree = {},
    TREE_HEIGHT = 6
}

function M.init()
    math.randomseed(os.time())
    for i = 1, M.TREE_HEIGHT+1 do
        local isBranch = M.rand_bool()
            if isBranch == true then
                local isLeftBranch = M.rand_bool()
                if isLeftBranch == true then
                    M.tree[i] = tree_sprite[2]
                else
                    M.tree[i] = tree_sprite[3]
            end
        else M.tree[i] = tree_sprite[1]
        end
    end
end

function M.rand_bool()
    local rnd = math.random()
    if rnd > 0.5 then
        return true
    end
    return false
end

function M.move_tree()
    -- Pop last elem [i = 7?],
    -- Generate new elem @ i=1
    -- Move index by one
end

return M
