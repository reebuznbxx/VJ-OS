if vim.loader then
	vim.loader.enable()
end

_G.Config = {
    use_nvim_treesitter = true,
}
require('core')
