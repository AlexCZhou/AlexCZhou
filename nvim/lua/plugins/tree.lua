-- nvim-tree.lua
return {
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
}

