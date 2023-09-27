local player = require "vimberman.player"
local tree = require "vimberman.tree"

local api = vim.api
local win, buf


local win_conf = {
  WIN_WIDTH = 32,
  WIN_HEIGHT = (tree.TREE_HEIGHT * tree.TREE_SPRITE_HEIGHT) + player.PLAYER_HEIGHT,
}

local M = {
  buf
}

function M.print_center(str)
  local width = api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
  return string.rep(' ', shift) .. str
end

function M.setup_buf()
  M.buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(M.buf, "bufhidden", "wipe")
end

function M.open_window()
  
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  
  local row = math.ceil((height - win_conf.WIN_HEIGHT) / 2 - 1)
  local col = math.ceil((width - win_conf.WIN_WIDTH) / 2)
  
  local window_opts = {
    style = "minimal",
    relative = "editor",
    width = win_conf.WIN_WIDTH,
    height = win_conf.WIN_HEIGHT,
    row = row,
    col = col,
  }
  
  win = api.nvim_open_win(M.buf, true, window_opts)
end

function M.render_tree()
  for i=0, tree.TREE_HEIGHT do
    M.buf_set_lines_sprite(i*tree.TREE_SPRITE_HEIGHT, i*tree.TREE_SPRITE_HEIGHT, false, true, tree.tree[i+1])
  end
end

function M.buf_set_lines_sprite(pos_start, pos_end, strict_indexing, center, arr)
  local sprite = {}
  if center then
    for i, _ in ipairs(arr) do
      sprite[i] = M.print_center(arr[i])
    end
    api.nvim_buf_set_lines(M.buf, pos_start, pos_end, strict_indexing, sprite)
  else
    api.nvim_buf_set_lines(M.buf, pos_start, pos_end, strict_indexing, arr)
  end
end

function M.set_input(bool)
  api.nvim_buf_set_option(M.buf, "modifiable", bool)
end

function M.close_window()
    api.nvim_win_close(win, true)
end

return M