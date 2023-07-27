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
        -- the "master" branch need to build from source with yarn, use "release".
        -- see https://github.com/neoclide/coc.nvim/issues/3258#issuecomment-900014514
        branch = "release",
        opts = {},
    },
    -- vim-godot
    {
        "habamax/vim-godot",
        lazy = false,
        opts = {},
        config = function()
            vim.cmd[[let g:godot_executable = "path/to/godot_executable"]]
        end,
    },
    -- github copilot.vim
    -- AI code generation, buggy for now.
    {
        "github/copilot.vim",
        lazy = true,
        opts = {},
        config = function()

        end,
    },
    -- csv.vim
    -- make csv easy to read and edit
    {
        "chrisbra/csv.vim",
        lazy = false,
        opts = {},
        config = function()

        end,
    },
    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
        end
    },
    -- telescope.nvim
    -- a highly extendable fuzzy finder over lists
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local builtin = require("telescope.builtin");
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {});
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {});
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {});
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {});
        end,
    },
    -- markdown-preview.nvim
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        lazy = true,
        config = function()
            vim.g.mkdp_auto_start = 1;
            vim.g.mkdp_open_ip = "127.0.0.1";
            vim.g.mkdp_port = 8599;
            vim.g.mkdp_browser = "";
            vim.g.mkdp_echo_preview_url = 1;
        end,
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
    set statusline  =

    set number
]]


