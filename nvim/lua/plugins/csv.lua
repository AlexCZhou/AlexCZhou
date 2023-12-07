-- csv.vim
-- make csv easy to read and edit
return {
    "chrisbra/csv.vim",
    lazy = false,
    opts = {},
    config = function()
        vim.g.csv_delim=",";
    end,
}

