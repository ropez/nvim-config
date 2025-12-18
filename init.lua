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

-- HACK Don't know how to put this in the plugin config
vim.g.tmux_navigator_no_mappings = 1

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.o.termguicolors = true

require("lazy").setup("plugins", {
  change_detection = { enabled = true, notify = false },
  dev = {
    path = string.format("%s/nvim", os.getenv("HOME")),
    patterns = {'ropez'},
    fallback = true,
  }
})

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false

-- Load file changes
vim.o.autoread = true

-- Comfortable menu
vim.o.wildmenu = true
vim.o.wildignorecase = true
vim.o.wildmode = 'longest:full,full'

vim.cmd([[
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
map ,/ :Ggrep '\<=expand("<cword>")<cr>\>'

" Git grep for the word under cursor, don't jump to first occurance, but open in telescope
map <C-f> :silent Ggrep! '\<=expand("<cword>")<cr>\>' \| Telescope quickfix<cr>

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
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

" Use <C-p> and <C-n> like arrow keys in command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Alt-n toggle window
tnoremap <A-n> <C-\><C-N><C-w>w
inoremap <A-n> <C-\><C-N><C-w>w
nnoremap <A-n> <C-w>w

au VimResume * :silent! !
]])
