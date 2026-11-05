return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      go = { "golangcilint" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("gajit-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}
