return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    picker = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true, indent = { char = "┊" }, animate = { enabled = false } },
    lazygit = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
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
        }, "\n"),
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "o", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "g", desc = "Find text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "c", desc = "Configuration", action = ":e $MYVIMRC" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 3 },
        { section = "startup" },
      },
    },
  },
  keys = {
    -- Find (picker)
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<C-f>", function() Snacks.picker.git_files() end, desc = "Find git files" },
    { "<leader>fh", function() Snacks.picker.recent() end, desc = "Recently opened files" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Find word under cursor" },
    {
      "<leader>ffw",
      function() Snacks.picker.grep({ search = vim.fn.expand("<cWORD>"), regex = false, live = false }) end,
      desc = "Find WORD under cursor",
    },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find by grep" },

    -- File explorer
    { "<leader>ee", function() Snacks.explorer() end, desc = "Toggle file explorer" },
    { "<leader>ef", function() Snacks.explorer.reveal() end, desc = "Reveal current file in explorer" },

    -- Git
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Open lazygit" },
  },
}
