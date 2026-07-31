return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = {
      commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        hover = {
          silent = nil,
        },
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Starting Supermaven" },
              { find = "Supermaven Free Tier" },
            },
          },
        },
      })
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        show_buffer_close_icons = false,
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
      ---@type string
      local logo = [[
        ██████   █████ ██████████    ███████    █████   █████ █████ ██████   ██████
       ▒▒██████ ▒▒███ ▒▒███▒▒▒▒▒█  ███▒▒▒▒▒███ ▒▒███   ▒▒███ ▒▒███ ▒▒██████ ██████
        ▒███▒███ ▒███  ▒███  █ ▒  ███     ▒▒███ ▒███    ▒███  ▒███  ▒███▒█████▒███
        ▒███▒▒███▒███  ▒██████   ▒███      ▒███ ▒███    ▒███  ▒███  ▒███▒▒███ ▒███
        ▒███ ▒▒██████  ▒███▒▒█   ▒███      ▒███ ▒▒███   ███   ▒███  ▒███ ▒▒▒  ▒███
        ▒███  ▒▒█████  ▒███ ▒   █▒▒███     ███   ▒▒▒█████▒    ▒███  ▒███      ▒███
        █████  ▒▒█████ ██████████ ▒▒▒███████▒      ▒▒███      █████ █████     █████
       ▒▒▒▒▒    ▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒         ▒▒▒      ▒▒▒▒▒ ▒▒▒▒▒     ▒▒▒▒▒
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      return {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),

          center = {
            {
              action = "lua LazyVim.pick()()",
              desc = " Find File",
              icon = " ",
              key = "f",
            },
            {
              action = "ene | startinsert",
              desc = " New File",
              icon = " ",
              key = "n",
            },
            {
              action = 'lua LazyVim.pick("oldfiles")()',
              desc = " Recent Files",
              icon = " ",
              key = "r",
            },
            {
              action = 'lua LazyVim.pick("live_grep")()',
              desc = " Find Text",
              icon = " ",
              key = "g",
            },
            {
              action = "lua LazyVim.pick.config_files()()",
              desc = " Config",
              icon = " ",
              key = "c",
            },
            {
              action = 'lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = "LazyExtras",
              desc = " Lazy Extras",
              icon = " ",
              key = "x",
            },
            {
              action = "Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
    end,
    config = function(_, opts)
      require("dashboard").setup(opts)

      -- Apply catppuccin gradient to dashboard header lines
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function(ev)
          local gradient_hls = {
            "DashboardHeader1",
            "DashboardHeader2",
            "DashboardHeader3",
            "DashboardHeader4",
            "DashboardHeader5",
            "DashboardHeader6",
            "DashboardHeader7",
            "DashboardHeader8",
            "DashboardHeader9",
            "DashboardHeader10",
          }

          vim.schedule(function()
            local buf = ev.buf
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            -- Find header lines (non-empty lines before the center section)
            local header_start, header_end
            for i, line in ipairs(lines) do
              if not header_start and line:match("[▓|\\]") then
                header_start = i
              end
              if header_start and not line:match("[▓|\\]") and line:match("^%s*$") then
                header_end = i - 1
                break
              end
            end

            if header_start and header_end then
              local header_lines = header_end - header_start + 1
              local ns = vim.api.nvim_create_namespace("dashboard_gradient")
              vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

              for i = header_start, header_end do
                local idx = math.floor((i - header_start) / header_lines * #gradient_hls) + 1
                idx = math.min(idx, #gradient_hls)
                vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
                  line_hl_group = gradient_hls[idx],
                  priority = 200,
                })
              end
            end
          end)
        end,
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      window = {
        position = "right",
        width = 30,
        auto_expand_width = false,
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "❩", right = "❨" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        -- Tracking issue with bubble background transparency here: https://github.com/nvim-lualine/lualine.nvim/issues/1363
        lualine_a = { { "mode", separator = { left = "", right = "" } } },
        lualine_b = { "none" },
        lualine_x = {
          {
            function()
              return require("noice").status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").status and require("noice").status.mode.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Constant") }
            end,
          },
        },
        lualine_y = { "searchcount" },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", separator = { right = "" }, padding = { left = 0, right = 1 } },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("supermaven"))
    end,
  },

  -- LazyGit integration with Telescope
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
