local ok, mason = pcall(require, 'mason')
if not ok then
  return
end

local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

mason.setup {
  install_root_dir = join_paths(vim.call('stdpath', 'data'), 'lsp_servers'),
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}
