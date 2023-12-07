-- lualine.nvim
-- A blazing fast and easy to configure Neovim statusline written in Lua.
return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {},
    config = function()
        require("lualine").setup({
            theme = "tokyonight"
        });
    end,
}

