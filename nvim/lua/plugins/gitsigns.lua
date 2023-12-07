-- gitsigns.nvim
-- Super fast git decorations implemented purely in Lua.
return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
        require("gitsigns").setup();
    end,
}

