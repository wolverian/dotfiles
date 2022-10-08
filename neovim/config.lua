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

vim.api.nvim_set_keymap('n', '<leader>b', '', {
  noremap = true,
  callback = function ()
    telescope.buffers()
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
require('lualine').setup({
  options = { theme = "iceberg_dark" },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
})
