return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local todo = require("todo-comments")
    todo.setup({})

    -- Search TODOs via Telescope
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })

    -- Jump between TODO comments
    vim.keymap.set("n", "]td", function()
      todo.jump_next()
    end, { desc = "Next TODO comment" })

    vim.keymap.set("n", "[td", function()
      todo.jump_prev()
    end, { desc = "Previous TODO comment" })
  end,
}
