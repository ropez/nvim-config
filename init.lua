local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("plugins")

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false

-- Load file changes
vim.o.autoread = true


vim.cmd([[
" Show filename in the window title
set title
set noignorecase

" Switch between the last two files
nnoremap ,, <c-^>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map ,e :edit %%
map ,v :view %%
map ,s :saveas %%

" Go to the logical side after split
noremap <C-w>s :rightbelow split<cr>
noremap <C-w>v :rightbelow vsplit<cr>

" Normal commenting
nmap <Space>/ gcc
vmap <Space>/ gc
nmap <C-_> gcc
vmap <C-_> gc
nmap <C-/> gcc
vmap <C-/> gc

" Habits die hard
imap <C-v> <C-r>+

" Map ,/ to grep for last search
map ,/ :Ggrep '/'

" Get out of terminal
tnoremap <Esc> <C-\><C-n>

" Alt-hjkl in eny mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Alt-n toggle window
tnoremap <A-n> <C-\><C-N><C-w>w
inoremap <A-n> <C-\><C-N><C-w>w
nnoremap <A-n> <C-w>w

nmap <C-j> :FormatWrite<cr>

" :bash command
cnoreabbrev bash terminal "C:\Users\robin\scoop\apps\git\current\bin\bash.exe"

au VimResume * :silent! !
]])

