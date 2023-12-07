-- dashboard-nvim
-- Fancy and Blazing Fast start screen plugin of Neovim
return {
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
}

