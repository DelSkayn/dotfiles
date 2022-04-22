-- module to easier create keybinds

-- global table to hold our functions
_bindfuncs = {}
-- current bindfunc index
local bindfunc_i = 0

local M = {}

M.bind = function(mode, lhs, rhs, ...)
  -- for every optional argument we make a field in the opts table
  -- the field will be set to true
  -- we do this because the neovim api wants {thing1: true, thing2: true, ...}
  local opt = {}
  for _, a in ipairs({...}) do opt[a] = true end

  -- if we pass in a lua function
  if type(rhs) == 'function' then
      opt.callback = rhs
      rhs = ""
  end

  return vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

return M
