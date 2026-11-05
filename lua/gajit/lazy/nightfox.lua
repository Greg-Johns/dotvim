return {
  "EdenEast/nightfox.nvim",
  config = function()
    require('nightfox').setup {
      options = {
        styles = {
          comments = "italic",
          variables = "italic",
          keywords = "bold",
          types = "italic,bold",
        }
      },
    }
    require('nightfox').load()
  end
}
