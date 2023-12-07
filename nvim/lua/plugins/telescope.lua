-- telescope.nvim
-- a highly extendable fuzzy finder over lists
return {
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
}

