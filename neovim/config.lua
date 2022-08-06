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
  local default = "%#StatusLineNC# %f%m"
  return default
end

-- These are just hard-coded colors from iceberg
vim.cmd "hi StatusLeftLspError guifg=#161821 guibg=#e27878"
vim.cmd "hi StatusLeftLspWarn guifg=#161821 guibg=#e2a478"
vim.cmd "hi StatusLeftLspInfo guifg=#161821 guibg=#89b8c2"
vim.cmd "hi StatusLeftLspHint guifg=#161821 guibg=#6b7089"
vim.cmd "hi StatusLeftLspOk guifg=#161821 guibg=#b4be82"

vim.cmd "hi StatusLeftFile guifg=#6b7089 guibg=#2e313f"
vim.cmd "hi StatusBase guifg=#3e445e guibg=#0f1117"

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

