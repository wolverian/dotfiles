local function get_lsp_diagnostics(bufnr)
  local result = {}
  local levels = {
    errors = vim.diagnostic.severity.ERROR,
    warnings = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hints = vim.diagnostic.severity.HINT,
  }

  for k, level in pairs(levels) do
    result[k] = #vim.diagnostic.get(bufnr, { severity = level })
  end

  return result
end

function StatusLine()
  local bufnr = 0
  local diagnostics = get_lsp_diagnostics(bufnr)
  local default = " %#StatusLeftFile# %f%m %#StatusBase#"
  if diagnostics.errors > 0 then
    return "%#StatusLeftLspError# " .. diagnostics.errors .. default
  elseif diagnostics.warnings > 0 then
    return "%#StatusLeftLspWarn# " .. diagnostics.warnings .. default
  elseif diagnostics.info > 0 then
    return "%#StatusLeftLspInfo# " .. diagnostics.info .. default
  elseif diagnostics.hints > 0 then
    return "%#StatusLeftLspHint# " .. diagnostics.hints .. default
  elseif #vim.lsp.buf_get_clients(bufnr) > 0 then
    return "%#StatusLeftLspOk# ✓" .. default
  else
    return "%#StatusLeftFile# %f%m %#StatusBase#"
  end
end

function StatusLineInactive()
  local default = "%#StatusLeftFile# %f%m %#StatusBase#"
  return default
end

local function set_opts(opts)
  for name, val in pairs(opts) do
    vim.api.nvim_set_option(name, val)
  end
end

local opts = {
  encoding = "utf-8",
  autoread = true,
  autowrite = true,
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  cmdheight = 1,
  showtabline = 1,
  hidden = true,
  hls = true,
  vb = true,
  showmatch = true,
  ignorecase = true,
  smartcase = true,
  number = false,
  numberwidth = 2,
  signcolumn = "yes",
  wrap = false,
  termguicolors = true,
  splitright = true,
  splitbelow = true,
  cursorline = true,
  grepprg = "rg --line-number",
  completeopt = "menuone,noselect",
  clipboard = "unnamedplus",
}

set_opts(opts)

vim.g.mapleader = " "
vim.api.nvim_command("language en_US")
vim.api.nvim_command("colorscheme icecube")
vim.api.nvim_command("syntax enable")

vim.api.nvim_set_keymap('n', '<leader>s', ':w<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><leader>', ':noh<cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><tab>', '<c-^>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })

vim.keymap.set('i', '<C-n>', function ()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-n><C-n>'
end, {
    expr = true,
    noremap = true,
    desc = "Select the first completion automatically to prevent hitting <C-n> twice to get an autocompletion"
})

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!luaeval('StatusLine()')
  au WinLeave,BufLeave * setlocal statusline=%!luaeval('StatusLineInactive()')
  augroup END
]], false)

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

