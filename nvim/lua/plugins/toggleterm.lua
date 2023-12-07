-- akinsho/toggleterm.nvim
return {
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
}

