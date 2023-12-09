-- nvim.dap 
-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
-- see https://github.com/ecosse3/nvim/blob/master/lua/plugins/dap.lua
local M = {
    "mfussenegger/nvim-dap",
}

function M.config()
    local dap = require("dap")

    dap_keymaps()
end

-- dap keymaps
function dap_keymaps()
    local dap = require("dap")
    local keymap = vim.keymap.set
    local opts = {noremap = true, silent = true}

    keymap("n", "<leader>dc", dap.continue, opts);
    keymap("n", "<leader>db", dap.toggle_breakpoint, opts);
    keymap("n", "<leader>di", dap.step_into, opts);
    keymap("n", "<leader>dO", dap.step_out, opts);
    keymap("n", "<leader>do", dap.step_over, opts);
    keymap("n", "<leader>dt", dap.terminate, opts);

end

return M;

