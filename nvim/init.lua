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
vim.opt.guicursor = 'i:blinkoff100-blinkon50'
vim.o.termguicolors = true
vim.o.expandtab = true
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
    vim.opt.number = false
    vim.opt.relativenumber = false
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

local gh = function(x)
  return 'https://github.com/' .. x
end

-- vim.pack.add {
--   gh 'tpope/vim-sleuth',
--   gh 'lewis6991/gitsigns.nvim',
--   gh 'nvim-telescope/telescope.nvim',
-- }
--
-- require('gitsigns').setup {
--   signs = {
--     add = { text = '+' },
--     change = { text = '~' },
--     delete = { text = '_' },
--     topdelete = { text = '‾' },
--     changedelete = { text = '~' },
--   },
--   on_attach = function(bufnr)
--     local gitsigns = require 'gitsigns'
--
--     local function map(mode, l, r, opts)
--       opts = opts or {}
--       opts.buffer = bufnr
--       vim.keymap.set(mode, l, r, opts)
--     end
--
--     -- Navigation
--     map('n', ']c', function()
--       if vim.wo.diff then
--         vim.cmd.normal { ']c', bang = true }
--       else
--         gitsigns.nav_hunk 'next'
--       end
--     end, { desc = 'Jump to next git [c]hange' })
--
--     map('n', '[c', function()
--       if vim.wo.diff then
--         vim.cmd.normal { '[c', bang = true }
--       else
--         gitsigns.nav_hunk 'prev'
--       end
--     end, { desc = 'Jump to previous git [c]hange' })
--
--     -- Actions
--     -- visual mode
--     map('v', '<leader>hs', function()
--       gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
--     end, { desc = 'git [s]tage hunk' })
--     map('v', '<leader>hr', function()
--       gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
--     end, { desc = 'git [r]eset hunk' })
--     -- normal mode
--     map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
--     map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
--     map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
--     map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
--     map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
--     map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
--     map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
--     map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
--     map('n', '<leader>hD', function()
--       gitsigns.diffthis '@'
--     end, { desc = 'git [D]iff against last commit' })
--     -- Toggles
--     map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
--     map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
--   end,
-- }
--
require('luasnip.loaders.from_lua').load {
  paths = { './lua/LuaSnip/' },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>rr', '<cmd>make<CR>')
vim.keymap.set('n', '<leader>rc', '<cmd>make clean<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<leader>Trn', require('neotest').run.run, { desc = 'Neo[t]est: [r]un [n]earest test' })
vim.keymap.set('n', '<leader>Tdn', function()
  require('neotest').run.run { strategy = 'dap' }
end, { desc = 'Neo[t]est: [d]ebug [n]earest test' })
vim.keymap.set('n', '<leader>Tdd', function()
  require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' }
end, { desc = 'Neo[t]est: [d]ebug current file' })
vim.keymap.set('n', '<leader>Trr', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Neo[T]est: [r]un current file' })
vim.keymap.set('n', '<leader>To', require('neotest').output_panel.toggle, { desc = 'Neo[T]est: toggle [o]utput panel' })
vim.keymap.set('n', '<leader>Ts', require('neotest').summary.toggle, { desc = 'Neo[T]est: toggle [s]ummary window' })

vim.cmd ':hi statusline guibg=NONE'

vim.filetype.add {
  pattern = {
    ['.*%.py3'] = 'python',
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
