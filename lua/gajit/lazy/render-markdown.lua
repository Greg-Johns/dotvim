return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "vimwiki" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("render-markdown").setup({
      file_types = { "markdown", "vimwiki" },
    })
  end,
}
