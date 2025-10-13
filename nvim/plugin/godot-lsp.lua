local M = {}
M.is_godot_project = false
M.is_server_running = false

local GODOT_NVIM_SERVER_IP = '::1:6010'
local GODOT_LSP_PORT = 6005
local PATHS_TO_CHECK = { '/', '/../' }

function M.setup()
  -- :p gives absolute path, :h gives parent directory of %
  local cwd = vim.fn.expand '%:p:h'

  for _, path in pairs(PATHS_TO_CHECK) do
    if vim.uv.fs_stat(cwd .. path .. 'project.godot') then
      is_godot_project = true
      break
    end
  end

  for _, server in ipairs(vim.fn.serverlist()) do
    if server == GODOT_NVIM_SERVER_IP then
      is_server_running = true
      break
    end
  end

  if is_godot_project and not is_server_running then
    vim.fn.serverstart(GODOT_NVIM_SERVER_IP)
  end

  if is_godot_project then
    vim.lsp.enable('gdscript', {
      name = 'godot',
      cmd = vim.lsp.rpc.connect('127.0.0.1', GODOT_LSP_PORT),
    })
  end
end

M.setup()

return M
