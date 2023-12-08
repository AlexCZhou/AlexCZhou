return {
    -- github copilot.vim. AI code generation
    -- use zbirenbaum/copilot.lua with it's cmp
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false }
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua"
        },
        config = function ()
            require("copilot_cmp").setup()
        end
    }
}

