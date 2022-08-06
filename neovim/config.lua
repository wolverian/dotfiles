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
  local diagnostics = get_lsp_diagnostics(0)
  local default = " %#StatusLine# %f"
  if diagnostics.errors > 0 then
    return "%#StatusLeftLspError# " .. diagnostics.errors .. default
  elseif diagnostics.warnings > 0 then
    return "%#StatusLeftLspWarn# " .. diagnostics.warnings .. default
  elseif diagnostics.info > 0 then
    return "%#StatusLeftLspInfo# " .. diagnostics.info .. default
  elseif diagnostics.hints > 0 then
    return "%#StatusLeftLspHint# " .. diagnostics.hints .. default
  elseif vim.lsp.buf.server_ready() then
    return "%#StatusLeftLspOk# OK" .. default
  else
    return default
  end
end

function StatusLineInactive()
  local default = "%#StatusLineNC# %f"
  return default
end

-- These are just hard-coded colors from iceberg
vim.cmd "hi StatusLeftLspError guifg=black guibg=#e27878"
vim.cmd "hi StatusLeftLspWarn guifg=black guibg=#e2a478"
vim.cmd "hi StatusLeftLspInfo guifg=black guibg=#89b8c2"
vim.cmd "hi StatusLeftLspHint guifg=black guibg=#6b7089"
vim.cmd "hi StatusLeftLspOk guifg=black guibg=#668e3d"

vim.o.statusline = "%!luaeval('status_line()')"

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

