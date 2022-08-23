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

vim.opt.encoding = "utf-8"
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.cmdheight = 1
vim.opt.showtabline = 1
vim.opt.hidden = true
vim.opt.hls = true
vim.opt.vb = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = false
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.grepprg = "rg --line-number"
vim.opt.completeopt = "menuone,noselect"
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "nv"

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

