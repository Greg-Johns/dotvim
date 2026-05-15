return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current file)" },
    { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
  },
  config = function()
    require("diffview").setup({})
  end,
}
