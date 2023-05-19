function ColorScheme(color)
	color = color or "duskfox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "#0f1119" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e2234" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e2234" })
end

ColorScheme()
