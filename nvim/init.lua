vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shadafile = 'NONE'
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.confirm = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(_)
    vim.o.number = false
    vim.o.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ { import = 'plugins' } }, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require('luasnip.loaders.from_lua').load {
  paths = { './lua/LuaSnip/' },
}

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- allows vertical line navigation on long wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<leader>Trn', require('neotest').run.run, { desc = 'Neo[t]est: [r]un [n]earest test' })
vim.keymap.set('n', '<leader>Tdn', function()
  require('neotest').run.run { suite = false, strategy = 'dap' }
end, { desc = 'Neo[t]est: [d]ebug [n]earest test' })
vim.keymap.set('n', '<leader>Trr', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Neo[T]est: [r]un current file' })
vim.keymap.set('n', '<leader>To', require('neotest').output_panel.toggle, { desc = 'Neo[T]est: toggle [o]utput panel' })
vim.keymap.set('n', '<leader>Ts', require('neotest').summary.toggle, { desc = 'Neo[T]est: toggle [s]ummary window' })

local GODOT_NVIM_SERVER_IP = '::1:6010'
local GODOT_LSP_PORT = 6005
local paths_to_check = { '/', '/../' }
local is_godot_project = false
local is_server_running = false
-- :p gives absolute path, :h gives parent directory of %
local cwd = vim.fn.expand '%:p:h'

for _, path in pairs(paths_to_check) do
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

local lspconfig = require 'lspconfig'
if is_godot_project then
  lspconfig.gdscript.setup {
    name = 'godot',
    cmd = vim.lsp.rpc.connect('127.0.0.1', GODOT_LSP_PORT),
  }
end

vim.cmd ':hi statusline guibg=NONE'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
