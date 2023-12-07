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
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {},
        config = function() 
            require("tokyonight").setup({
                style = "night",
                transparent = true,
            });
            vim.cmd.colorscheme("tokyonight");
        end,
    },
    -- nvim theme
    {
        "catppuccin/nvim",
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                show_end_of_buffer = true,
            });
            vim.cmd.colorscheme("catppuccin");
        end,
    },
    -- coc.nvim
    {
        "neoclide/coc.nvim",
        enabled = false,
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
        lazy = false,
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
            vim.g.csv_delim=",";
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
        opts = {},
        config = function()
            require("lualine").setup({
                theme = "tokyonight-night"
            });
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
        enabled = true,
        config = function()
            require("mason").setup();
        end,
    },
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        config = function()

            -- Setup language servers.
            local lspconfig = require('lspconfig')
            lspconfig.eslint.setup({
                root_dir = function(fname)
                    return lspconfig.util.root_pattern(".eslintrc.js")(fname) or vim.loop.cwd()
                end,
            })

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

        end,
    },
    -- vim-fugitive
    {
        "tpope/vim-fugitive",
        config = function()
        end,
    },
    -- barbar.nvim
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() 
            vim.g.barbar_auto_setup = true
        end,
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Move to previous/next
            map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
            map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
            -- Re-order to previous/next
            map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
            map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
            -- Pin/unpin buffer
            map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
            -- Close buffer
            map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
        end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    -- Comment.nvim
    {
        "numToStr/Comment.nvim",
        opts = {
        },
        lazy = false
    },
    -- nvim.dap 
    -- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
        end,
    }
}
require("lazy").setup(plugins, opts);

