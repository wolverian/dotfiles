local util = require 'vim.lsp.util'

local M = {}

-- Some path manipulation utilities
local function is_dir(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == 'directory' or false
end

local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"

-- Asumes filepath is a file.
local function dirname(filepath)
  local is_changed = false
  local result = filepath:gsub(path_sep.."([^"..path_sep.."]+)$", function()
    is_changed = true
    return ""
  end)
  return result, is_changed
end

local function path_join(...)
  return table.concat(vim.tbl_flatten {...}, path_sep)
end

-- Ascend the buffer's path until we find the rootdir.
-- is_root_path is a function which returns bool
local function buffer_find_root_dir(bufnr, is_root_path)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if vim.fn.filereadable(bufname) == 0 then
    return nil
  end
  local dir = bufname
  -- Just in case our algo is buggy, don't infinite loop.
  for _ = 1, 100 do
    local did_change
    dir, did_change = dirname(dir)
    if is_root_path(dir, bufname) then
      return dir, bufname
    end
    -- If we can't ascend further, then stop looking.
    if not did_change then
      return nil
    end
  end
end

-- A map from root_dir to client_id
local ts_lsps = {}

local ts_filetypes = {
  ["typescript"]     = true;
  ["typescript.jsx"] = true;
}

function M.check_start_ts_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  if not ts_filetypes[vim.api.nvim_buf_get_option(bufnr, 'filetype')] then
    return
  end

  local root_dir = buffer_find_root_dir(bufnr, function(dir)
    return vim.fn.filereadable(path_join(dir, 'package.json')) == 1
  end)

  if not root_dir then return end

  local lsp_config = {
    name = "typescript";
    cmd = {"typescript-language-server", "--stdio"};
    root_dir = root_dir;
  }

  local client_id = ts_lsps[root_dir]
  if not client_id then
    client_id = vim.lsp.start_client(lsp_config)
    ts_lsps[root_dir] = client_id
  end
  vim.lsp.buf_attach_client(bufnr, client_id)
end

-- Customize so that we populate loclist from diagnostics
function M.publishDiagnostics(_, _, result, client_id)
  if not result then return end

  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)

  if not bufnr then
    err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
    return
  end

  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  util.buf_clear_diagnostics(bufnr)

  for _, diagnostic in ipairs(result.diagnostics) do
    if diagnostic.severity == nil then
      diagnostic.severity = protocol.DiagnosticSeverity.Error
    end

    diagnostic.bufnr = bufnr
    diagnostic.lnum = diagnostic.range.start.line + 1
    diagnostic.col = diagnostic.range.start.character + 1
    diagnostic.text = diagnostic.message
  end


  util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
  util.buf_diagnostics_underline(bufnr, result.diagnostics)

  -- util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)

  util.buf_diagnostics_signs(bufnr, result.diagnostics)

  vim.fn.setloclist(0, {}, ' ', {
    title = 'Language Server';
    items = result.diagnostics;
  })

  vim.api.nvim_command("doautocmd User LspDiagnosticsChanged")
end

function M.register_PublishDiagnostics_callback()
  vim.lsp.callbacks['textDocument/publishDiagnostics'] = M.publishDiagnostics
end

return M
