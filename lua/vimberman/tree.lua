local M = {
    tree = {}
}

local tree_sprite = {
    {"      |      |      "},
    {"=====<|      |      "},
    {"      |      |>====="},
}

function M.init()
    math.randomseed(os.time())
    for i = 1, 7 do
        local isBranch = M.rand_bool()
            if isBranch == true then
                local isLeftBranch = M.rand_bool()
                if isLeftBranch == true then
                    M.tree[i] = tree_sprite[2][1]
                else
                    M.tree[i] = tree_sprite[3][1]
            end
        else M.tree[i] = tree_sprite[1][1]
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
