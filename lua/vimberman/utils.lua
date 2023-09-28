-- S/o to @seandewar for the utils

local api = vim.api
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

function M.nnoremap(buf, lhs, rhs, desc)
  if type(lhs) == "string" then
    lhs = { lhs }
  end

  for _, value in ipairs(lhs) do
    local callback = type(rhs) == "function" and rhs or nil
    api.nvim_buf_set_keymap(
      buf,
      "n",
      value,
      callback and "" or rhs,
      { noremap = true, silent = true, callback = callback, desc = desc }
    )
  end
end

function M.rand_init()
  math.randomseed(os.time())
end

function M.rand_bool()
    local rnd = math.random()
    if rnd > 0.5 then
        return true
    end
    return false
end

return M