require("lazyload").on_vim_enter(function()
    vim.pack.add({
        { src = "https://github.com/mason-org/mason.nvim" },
    })

    require("mason").setup()
end)
