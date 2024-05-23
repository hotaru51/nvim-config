-- leaderキー設定
vim.g.mapleader = ' '

-- ##################################################
-- #
-- # lazy.nvim
-- #
-- ##################################################

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
      }
    }
  }
})

-- ##################################################
-- #
-- # vim基本設定
-- #
-- ##################################################

-- 24bit colorを有効化
vim.opt.termguicolors = true

-- インデント設定
vim.opt.cindent = true
vim.opt.autoindent = true

-- 表示設定
vim.cmd 'syntax on'
vim.opt.list = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.laststatus = 2

-- タブ設定
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 改行コード、文字コード設定
vim.opt.fileencodings = {'ucs-bom', 'utf-8', 'cp932', 'default', 'latin1'}
vim.opt.fileformats = {'unix', 'dos'}

-- 不要なファイルの生成抑止
vim.opt.undofile = false
vim.opt.backup = false

-- 自動折り返し無効化
vim.opt.textwidth = 0

-- <C-@>誤爆防止
vim.keymap.set('i', '<C-@>', '<Esc>', {noremap = true})

-- <C-j>で挿入モードから抜ける
vim.keymap.set('i', '<C-j>', '<Esc>', {noremap = true})

-- <C-j>でビジュアルモードから抜ける
vim.keymap.set('v', '<C-j>', '<Esc>', {noremap = true})

-- <C-j>でTerminal-Jobモードから抜ける
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>', {noremap = true})

-- Terminal-Jobモード内にて<S-space>で;2uが入力されてしまうのを防止
vim.keymap.set('t', '<S-Space>', '<Space>', {noremap = true})

-- タブ切り替え
vim.keymap.set('n', '<C-n>', 'gt', {noremap = true})
vim.keymap.set('n', '<C-p>', 'gT', {noremap = true})

-- ウィンドウ移動
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})

vim.keymap.set('n', '<Leader><C-h>', '<C-w>H', {noremap = true})
vim.keymap.set('n', '<Leader><C-j>', '<C-w>J', {noremap = true})
vim.keymap.set('n', '<Leader><C-k>', '<C-w>K', {noremap = true})
vim.keymap.set('n', '<Leader><C-l>', '<C-w>L', {noremap = true})

-- split時の挙動設定
vim.opt.splitright = true
vim.opt.splitbelow = true

-- クリップボード操作
if vim.fn.has('unix') == 1 then
    vim.keymap.set({'n', 'v'}, '<Leader>y', '"+y', {noremap = true})
    vim.keymap.set({'n', 'v'}, '<Leader>d', '"+d', {noremap = true})
    vim.keymap.set({'n', 'v'}, '<Leader>D', '"+D', {noremap = true})
else
    vim.keymap.set({'n', 'v'}, '<Leader>y', '"*y', {noremap = true})
    vim.keymap.set({'n', 'v'}, '<Leader>d', '"*d', {noremap = true})
    vim.keymap.set({'n', 'v'}, '<Leader>D', '"*D', {noremap = true})
end

vim.keymap.set({'n', 'v'}, '<Leader>p', '"*p', {noremap = true})
vim.keymap.set({'n', 'v'}, '<Leader>P', '"*P', {noremap = true})

-- Perl providerを使用しないので無効化
vim.g.loaded_perl_provider = 0

-- ウィンドウを下にsplitしてターミナル表示
local function split_terminal()
    vim.cmd [[
        rightbelow split
        terminal
    ]]
    vim.opt.number = false
    vim.fn.feedkeys('i')
end
vim.api.nvim_create_user_command('Sterminal', split_terminal, {})
vim.keymap.set('n', '<Leader>ts', '<Cmd>Sterminal<CR>')

-- ウィンドウを右にvsplitしてターミナル表示
local function vertical_split_terminal()
    vim.cmd [[
        rightbelow vertical split
        terminal
    ]]
    vim.opt.number = false
    vim.fn.feedkeys('i')
end
vim.api.nvim_create_user_command('Vterminal', vertical_split_terminal, {})
vim.keymap.set('n', '<Leader>tv', '<Cmd>Vterminal<CR>')

-- 新規タブを開いてターミナル表示
local function tab_terminal()
    vim.cmd [[
        tabnew
        terminal
    ]]
    vim.opt.number = false
    vim.fn.feedkeys('i')
end
vim.api.nvim_create_user_command('Tabterminal', tab_terminal, {})
vim.keymap.set('n', '<Leader>tt', '<Cmd>Tabterminal<CR>')
