return {
  {
    "nickjvandyke/opencode.nvim",
    branch = "main", -- OpenCode v2 support (v1.x releases still use `--port`)
    dependencies = { "folke/snacks.nvim" }, -- configured in snacks.lua
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      local oc = require("opencode")
      local modes = { "n", "x" }

      -- Group label for which-key
      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({ { "<leader>o", group = "OpenCode", mode = modes } })
      end

      -- Ask / select
      vim.keymap.set(modes, "<leader>oa", function() oc.ask("@this: ") end, { desc = "Ask OpenCode about selection" })
      vim.keymap.set("n", "<leader>ob", function() oc.ask("@buffer: ") end, { desc = "Ask OpenCode about buffer" })
      vim.keymap.set(modes, "<leader>os", function() oc.select() end, { desc = "Select OpenCode action" })

      -- Send range / line (operator)
      vim.keymap.set(modes, "<leader>og", function() return oc.operator("@this ") end,
        { desc = "Send range to OpenCode", expr = true })
      vim.keymap.set("n", "<leader>ol", function() return oc.operator("@this ") .. "_" end,
        { desc = "Send line to OpenCode", expr = true })

      -- Canned prompts
      vim.keymap.set(modes, "<leader>oe", function() oc.prompt("Explain @this and its context") end,
        { desc = "OpenCode: explain" })
      vim.keymap.set(modes, "<leader>of", function() oc.prompt("Fix @diagnostics") end,
        { desc = "OpenCode: fix diagnostics" })
      vim.keymap.set(modes, "<leader>or", function() oc.prompt("Review @this for correctness and style") end,
        { desc = "OpenCode: review" })
      vim.keymap.set(modes, "<leader>oT", function() oc.prompt("Add tests for @this") end,
        { desc = "OpenCode: add tests" })

      -- Session control
      vim.keymap.set("n", "<leader>on", function() oc.command("session.new") end, { desc = "OpenCode: new session" })
      vim.keymap.set("n", "<leader>oi", function() oc.command("session.interrupt") end,
        { desc = "OpenCode: interrupt session" })

      -- Scroll the OpenCode panel
      vim.keymap.set("n", "<S-C-u>", function() oc.command("session.half.page.up") end,
        { desc = "OpenCode: scroll up" })
      vim.keymap.set("n", "<S-C-d>", function() oc.command("session.half.page.down") end,
        { desc = "OpenCode: scroll down" })
    end,
  }
}
