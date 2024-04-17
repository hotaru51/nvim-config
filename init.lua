-- leaderキー設定
vim.g.mapleader = ' '

-- ##################################################
-- #
-- # dein
-- #
-- ##################################################

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
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.sw = 4
vim.opt.et = true

-- 改行コード、文字コード設定
vim.opt.encoding = 'utf-8'
vim.opt.fileformat = 'unix'

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

-- クリップボード操作

-- Perl providerを使用しないので無効化

-- ウィンドウを下にsplitしてターミナル表示

-- ウィンドウを右にvsplitしてターミナル表示

-- 新規タブを開いてターミナル表示
