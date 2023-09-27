local ui = vim.ui
local game = require "vimberman.game"

local M = {}

function M.main_menu()
  local menu_opts = {"Play", "Exit"}
  ui.select(menu_opts, {
    prompt = "Welcome to Vimberman",
    format_item = function(item)
      return "=== " .. item .. " ==="
    end,
  }, function(opt)
    if opt then
      if opt == menu_opts[1] then
        game.new_game()
      else end
    else end
  end)
end

return M