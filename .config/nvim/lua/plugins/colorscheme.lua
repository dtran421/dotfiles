return {
  {
    "tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, _)
          hl.LineNrAbove = {
            fg = "#5b7ec9",
          }
          hl.LineNrBelow = {
            fg = "#5b7ec9",
          }
        end,
      })
    end,
  },
}
