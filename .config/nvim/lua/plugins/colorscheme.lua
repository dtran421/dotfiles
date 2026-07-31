return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          -- Improve line number visibility
          LineNr = { fg = colors.overlay1 },
          LineNrAbove = { fg = colors.overlay0 },
          LineNrBelow = { fg = colors.overlay0 },
          CursorLineNr = { fg = colors.lavender, bold = true },

          -- Dashboard
          DashboardKey = { fg = colors.teal },
          DashboardHeader1 = { fg = colors.blue },
          DashboardHeader2 = { fg = colors.sapphire },
          DashboardHeader3 = { fg = colors.sky },
          DashboardHeader4 = { fg = colors.teal },
          DashboardHeader5 = { fg = colors.green },
          DashboardHeader6 = { fg = colors.yellow },
          DashboardHeader7 = { fg = colors.peach },
          DashboardHeader8 = { fg = colors.maroon },
          DashboardHeader9 = { fg = colors.red },
          DashboardHeader10 = { fg = colors.mauve },
        }
      end,
      integrations = {
        dashboard = true,
        noice = true,
        neo_tree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        mini = { enabled = true },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
