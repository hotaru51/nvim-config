-- leaderキー設定
vim.g.mapleader = ' '

-- ##################################################
-- #
-- # dein
-- #
-- ##################################################

dein_dir = vim.fn.expand('~/.cache/dein')
dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'
dein_toml_dir = vim.env.XDG_CONFIG_HOME .. '/nvim/dein_toml'

if vim.fn.isdirectory(dein_repo_dir) == 0 then
    vim.fn.system({
        'git',
        'clone',
        'https://github.com/Shougo/dein.vim.git',
        dein_repo_dir
    })
end

vim.opt.runtimepath:prepend(dein_repo_dir)

if vim.fn['dein#load_state'](dein_dir) == 1 then
    vim.fn['dein#begin'](dein_dir)

    -- toml読み込み
    vim.fn['dein#load_toml'](dein_toml_dir .. '/dein.toml')
    vim.fn['dein#load_toml'](dein_toml_dir .. '/filer.toml')
    vim.fn['dein#load_toml'](dein_toml_dir .. '/coc.toml')
    vim.fn['dein#load_toml'](dein_toml_dir .. '/coding.toml')

    vim.fn['dein#end']()
    vim.fn['dein#save_state']()
end

vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax enable'

if vim.fn['dein#check_install']() == 1 then
    vim.fn['dein#install']()
end

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
