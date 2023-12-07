-- tokyonight theme
return {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function() 
        print("hello world from tokyonight");
        require("tokyonight").setup({
            style = "night",
            transparent = true,
        });
        vim.cmd.colorscheme("tokyonight");
    end,
}

