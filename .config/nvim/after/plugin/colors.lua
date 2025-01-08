function ColorScheme(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)

  -- vim.api.nvim_set_hl(0, "Normal", { bg = "#181826" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#313245" })
  -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#313245" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFLoat", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

ColorScheme()
