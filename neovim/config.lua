
local signs = { "Error", "Warn", "Hint", "Info" }
for i, type in ipairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = " ┃", texthl = hl })
end

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics, {
     underline = false,
     virtual_text = false,
     update_in_insert = false,
   }
)

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}
