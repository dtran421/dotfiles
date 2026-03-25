return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
        sh = { "shfmt" },
        toml = { "taplo" },
      },
    },
  },
}
