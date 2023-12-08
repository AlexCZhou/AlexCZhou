-- tokyonight theme
return {
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
}

