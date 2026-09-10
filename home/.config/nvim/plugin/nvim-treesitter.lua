if Config.use_nvim_treesitter then
    require("lazyload").on_vim_enter(function()
        vim.api.nvim_create_autocmd("PackChanged", {
            callback = function(ev)
                if data.spec.name == "nvim-treesitter" then
                    vim.cmd("TSUpdate")
                end
            end,
        })

        vim.pack.add({
            { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
        })

        local function install_parser(lang)
            local parsers = require("nvim-treesitter.parsers")
            if not parsers[lang] then return false end
            require("nvim-treesitter").install({ lang }):wait(30000)
            return true
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
            callback = function(ev)
                local buf = ev.buf
                local ft = ev.match
                if ft == "" then return end

                local lang = vim.treesitter.language.get_lang(ft)
                if not lang then return end

                local ok = pcall(vim.treesitter.start, buf, lang)
                if ok then return end

                if install_parser(lang) then
                    pcall(vim.treesitter.start, buf, lang)
                end
            end,
        })
    end)
end
