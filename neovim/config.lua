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

