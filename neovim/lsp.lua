local lspconfig = require('lspconfig')

local signs = { "Error", "Warn", "Hint", "Info" }
for i, type in ipairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = " ┃", texthl = hl })
end

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })

-- Tame the UI
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics, {
     underline = false,
     virtual_text = false,
     update_in_insert = false,
   }
)

local on_attach = function (client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
end

lspconfig.tsserver.setup {
  on_attach = on_attach
}

lspconfig.hls.setup {
  on_attach = on_attach
}
