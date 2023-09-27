local api = vim.api
local buf, win

local M = {}

function M.print_center(str)
  local width = api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
  return string.rep(' ', shift) .. str
end

function M.open_window()

  buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  local win_width = 24
  local win_height = 8

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local window_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
  }

  win = api.nvim_open_win(buf, true, window_opts)
end

function M.render_tree(tree)
  local padding_tree = {}
  for i, _ in ipairs(tree) do
    padding_tree[i] = M.print_center(tree[i])
  end
  padding_tree[#padding_tree+1] = M.print_center("<Vimberman>")
  api.nvim_buf_set_lines(buf, 0, -1, false, padding_tree)
end

function M.close_window()
    api.nvim_win_close(win, true)
end

return M