return {
  { import = "lazyvim.plugins.extras.lang.java" },

  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Use a custom Eclipse formatter profile so the formatter wraps at 120
      -- columns (code + comments) instead of the default 80.
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/formatter/eclipse-formatter.xml",
            },
          },
        },
      })
    end,
  },
}
