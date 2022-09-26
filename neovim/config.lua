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

function WinBar()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
  local diagnostics = get_lsp_diagnostics(bufnr)
  local filename = "%#WinBar# %f"
  if diagnostics.errors > 0 then
    return "%#StatusLeftLspError# " .. diagnostics.errors .. " " .. filename
  elseif diagnostics.warnings > 0 then
    return "%#StatusLeftLspWarn# " .. diagnostics.warnings .. " " .. filename
  elseif diagnostics.info > 0 then
    return "%#StatusLeftLspInfo# " .. diagnostics.info .. " " .. filename
  elseif diagnostics.hints > 0 then
    return "%#StatusLeftLspHint# " .. diagnostics.hints .. " " .. filename
  elseif #vim.lsp.get_active_clients({ bufnr = bufnr }) > 0 then
    return "%#StatusLeftLspOk# ✓ " .. filename
  else
    return filename
  end
end

function StatusBar()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
  local diagnostics = get_lsp_diagnostics(bufnr)
  local projectName = vim.fs.basename(vim.fn.getcwd())
  local default = "%#StatusLeftFile# " .. projectName .. " %#StatusBase#"
  local filePath = "%#WinBar# %t%m %y "
  if diagnostics.errors > 0 then
    return default .. filePath .. "%#StatusLeftLspError# LSP: " .. diagnostics.errors .. " %#StatusBase#"
  elseif diagnostics.warnings > 0 then
    return default .. filePath .. "%#StatusLeftLspWarn# LSP: " .. diagnostics.warnings .. " %#StatusBase#"
  elseif diagnostics.info > 0 then
    return default .. filePath .. "%#StatusLeftLspInfo# LSP: " .. diagnostics.info .. " %#StatusBase#"
  elseif diagnostics.hints > 0 then
    return default .. filePath .. "%#StatusLeftLspHint# LSP: " .. diagnostics.hints .. " %#StatusBase#"
  elseif #vim.lsp.get_active_clients() > 0 then
    return default .. filePath .. "%#StatusLeftLspOk# LSP: ✓ " .. "%#StatusBase#"
  else
    return default .. filePath .. "%#StatusBase#"
  end
end

vim.api.nvim_exec([[
  augroup StatusBar
  au!
  au WinEnter,BufEnter * setlocal statusline=%!luaeval('StatusBar()')
  augroup END
]], false)

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
vim.opt.number = true
vim.opt.numberwidth = 1
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
vim.opt.laststatus = 2
-- vim.opt.winbar = "%!luaeval('WinBar()')"

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

vim.keymap.set('x', '<leader>c', require('osc52').copy_visual)

local telescope = require('telescope.builtin')

vim.api.nvim_set_keymap('n', '<C-t>', '', {
  noremap = true,
  callback = function ()
    telescope.find_files()
  end
})

vim.keymap.set('i', '<C-n>', function ()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-n><C-n>'
end, {
    expr = true,
    noremap = true,
    desc = "Select the first completion automatically to prevent hitting <C-n> twice to get an autocompletion"
})

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

require('nvim-autopairs').setup()
require('nvim-surround').setup()
require('nvim-web-devicons').setup()
-- require('colorizer').setup()
