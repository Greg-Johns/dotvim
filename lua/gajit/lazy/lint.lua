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

    -- Only run linters whose executables are installed
    local function run_lint()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if type(linter) == "function" then
          linter = linter()
        end
        local cmd = linter and linter.cmd
        if type(cmd) == "function" then
          cmd = cmd()
        end
        return cmd ~= nil and vim.fn.executable(cmd) == 1
      end, names)
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("gajit-lint", { clear = true }),
      callback = function()
        run_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      run_lint()
    end, { desc = "Lint current file" })
  end,
}
