-- The init.lua for TypeAlpha(AlexCZhou)

-- Install lazy.nvim
-- Beware of network errors. No error logs will be printed
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

-- Setup plugins
local plugins = {
    -- tokyonight theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function() 
            vim.cmd[[colorscheme tokyonight]]
        end,
    },
    -- coc.nvim
    {
        "neoclide/coc.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }
}
require("lazy").setup(plugins, opts);

-- vimrc
vim.cmd[[
    set nocompatible

    set autoindent
    set expandtab
    set softtabstop =4
    set shiftwidth  =4
    set shiftround

    set laststatus  =2
    set hidden
    set backspace   =indent,eol,start
    set display     =lastline
]]

