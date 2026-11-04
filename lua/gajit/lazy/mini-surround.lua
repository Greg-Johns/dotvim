return {
  "echasnovski/mini.surround",
  version = "*",
  keys = { "gsa", "gsd", "gsr", "gsf", "gsF", "gsh", "gsn" },
  opts = {
    -- "gs" prefix avoids clashing with hop's "s"
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
}
