return {
    'goolord/alpha-nvim',
    dependencies = {
        { 'echasnovski/mini.icons', version = "*" },
        'nvim-lua/plenary.nvim'
    },
    opts = function()
        local dashboard = require "alpha.themes.dashboard"
        dashboard.section.header.val = {
          "          |█\\  |█ |█   |█|██ |█\\   //█",
          "          |█\\\\ |█ |█   |█    |█\\\\ //|█",
          "          |█ \\\\|█  \\\\ //  |█ |█ \\\\/ |█",
          "          |█  \\\\█   \\\\/   |█ |█     |█",
          "          _____________________________",
          "       _-'.-..-.-.-.-.-.-._.-..-.-.-.-.`-",
          "    _-'.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-..-.`-_",
          " _-'.-.-.-..--..-----------------..---. .--.`-_",
          ":----------------------------------------------:",
          "'---._.----------------------------------._.---'",
        }
        dashboard.section.header.opts.hl = "DashboardHeader"
        dashboard.section.footer.opts.hl = "DashboardFooter"

        dashboard.config.layout = {
          { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
          dashboard.section.header,
          { type = "padding", val = 5 },
          dashboard.section.buttons,
          { type = "padding", val = 3 },
          dashboard.section.footer,
        }
        dashboard.config.opts.noautocmd = true
        
        -- dashboard.section.buttons.val = {
        --   dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        --   dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        --   dashboard.button("o", "  Recently opened files", ":Telescope oldfiles<CR>"),
        --   dashboard.button("g", "  Find word", ":Telescope live_grep<CR>"),
        --   dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
        --   dashboard.button("q", "  Quit", ":qa<CR>"),
        -- }
        
        return dashboard
    end,
    config = function(_, opts)
      require("alpha").setup(opts.config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        desc = "Add Alpha dashboard footer",
        once = true,
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          opts.section.footer.val = { "Loaded " .. stats.count .. " plugins  in " .. ms .. "ms" }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end
};
