local lspconfig = require('lspconfig')

local signs = { "Error", "Warn", "Hint", "Info" }
for _, type in ipairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = " ┃", texthl = hl })
end

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { noremap=true, silent=true })
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { noremap=true, silent=true })

-- Tame the UI
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics, {
     underline = false,
     virtual_text = false,
     update_in_insert = false,
   }
)

local on_attach = function (_, bufnr)
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

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}
