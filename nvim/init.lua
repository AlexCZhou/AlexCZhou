-- The init.lua for TypeAlpha(AlexCZhou)
-- this config first used on Neovim v0.9.1 with LuaJIT 2.1.0-beta3
-- some plugins need Node gcc clang and etc... `:checkhealth` for more info.

-- vimrc
vim.cmd.set("nocompatible");

vim.cmd.set("autoindent");
vim.cmd.set("expandtab");
vim.cmd.set("softtabstop =4");
vim.cmd.set("shiftwidth  =4");
vim.cmd.set("shiftround");

vim.cmd.set("laststatus  =2");
vim.cmd.set("hidden");
vim.cmd.set("backspace   =indent,eol,start");
vim.cmd.set("display     =lastline");
vim.cmd.set("statusline  =");

vim.cmd.set("number");

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
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {},
        config = function() 
            vim.cmd.colorscheme("tokyonight");
        end,
    },
    -- nvim theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd.colorscheme("catppuccin");
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
            local configs = require("nvim-treesitter.configs");

            configs.setup({
                ensure_installed = {"c", "cpp", "vim", "vimdoc", "javascript", "lua", "gdscript"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            });
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
    -- telescope-project extension
    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("telescope").load_extension("project");
            local project = require("telescope").extensions.project;

            vim.keymap.set("n", "<leader>fp", project.project, {});
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
    },
    -- nvim-tree.lua
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            -- disable netrw at the very start of your init.lua
            vim.g.loaded_netrw = 1;
            vim.g.loaded_netrwPlugin = 1;

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true;

            local api = require("nvim-tree.api");

            -- custom mapping
            vim.keymap.set("n", "<leader>tt", api.tree.toggle, {});

            require("nvim-tree").setup();
        end,
    },
    -- akinsho/toggleterm.nvim
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({});
            
            -- lazygit
            local terminal = require("toggleterm.terminal").Terminal;
            local lazygit = terminal:new({ cmd = "lazygit", hidden = true, direction = "float" });

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.keymap.set("n", "<leader>lg", _lazygit_toggle, {});
        end,
    },
    -- gitsigns.nvim
    -- Super fast git decorations implemented purely in Lua.
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function()
            require("gitsigns").setup();
        end,
    },
    -- lualine.nvim
    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require("lualine").setup();
        end,
    },
    -- dashboard-nvim
    -- Fancy and Blazing Fast start screen plugin of Neovim
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    header = { 
                        "TypeAlpha's                                            ",
                        "                                                       ",
                        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                        "                                                       ",
                    },
                    shortcut = {
                        { 
                            desc = "󰒲 Lazy", 
                            group = "@property",
                            action = require("lazy").home,
                            key = "l"
                        }
                    },
                    packages = {
                        enable = false,
                    },
                    project = {
                        enable = false,
                        limit = 6,
                        action = function(path)
                            vim.cmd("e "..path); -- nvim-tree.lua will take over.
                        end,
                    },
                    mru = { limit = 9 },
                    footer = {},
                },
            });
        end
    },
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "williamboman/mason.nvim",
        enabled = false,
        config = function()
            require("mason").setup();
        end,
    },
    {
        "neovim/nvim-lspconfig",
        enabled = false,
        config = function()
            require"lspconfig".clangd.setup{};
        end,
    }
}
require("lazy").setup(plugins, opts);

