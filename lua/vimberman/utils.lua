local M = {}

function M.reload()
    package.loaded["vimberman"] = nil
    package.loaded["vimberman.ui"] = nil
    package.loaded["vimberman.utils"] = nil
    return require "vimberman"
end

function M.err(msg)
    error("[vimberman]" .. msg)
end

return M