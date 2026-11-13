local function is_process_running(proc_name)
  local handle = io.popen("pgrep -x " .. vim.fn.shellescape(proc_name) .. " >/dev/null 2>&1 && echo 1 || echo 0")
  if not handle then
    return false
  end
  local result = handle:read("*a")
  handle:close()
  return vim.trim(result) == "1"
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Buffer delete",
      mode = "n",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Buffer delete all",
      mode = "n",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Buffer delete other",
      mode = "n",
    },
    {
      "<leader>bz",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
      mode = "n",
    },
    {
      "<leader>ee",
      function()
        Snacks.explorer()
      end,
      desc = "Toggle file explorer",
      mode = "n",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
      mode = "n",
    },
    {
      "<C-f>",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find git files",
      mode = "n",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recently opened files",
      mode = "n",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Find word under cursor",
      mode = { "n", "x" },
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find by grep",
      mode = "n",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
      mode = "n",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.lines()
      end,
      desc = "Find lines in buffer",
      mode = "n",
    },
  },
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        --   header = [[
        --                                                 
        --          ████ ██████           █████      ██
        --         ███████████             █████ 
        --         █████████ ███████████████████ ███   ███████████
        --        █████████  ███    █████████████ █████ ██████████████
        --       █████████ ██████████ █████████ █████ █████ ████ █████
        --     ███████████ ███    ███ █████████ █████ █████ ████ █████
        --    ██████  █████████████████████ ████ █████ █████ ████ ██████
        -- ]],
        header = [[
  █░░█ █▀▀ █░  █░  █▀█    █░ ░█ █▀█ █▀█ █░  █▀▄
  █▀▀█ █▀▀ █░░ █░░ █░█    █░█░█ █░█ █▀▄ █░░ █░█
  ▀░░▀ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀    ▀▀░▀▀ ▀▀▀ ▀░▀ ▀▀▀ ▀▀░
]],
      },
      sections = {
        { section = "header" },
        {
          section = "keys",
          indent = 1,
          padding = 1,
        },
        {
          title = "AI Harness",
          padding = 1,
          {
            icon = "󰚩 ",
            desc = "Launch OpenCode Session",
            key = "o",
            action = function()
              local cwd = vim.fn.getcwd()
              local cmd = string.format("opencode --dir %s", vim.fn.shellescape(cwd))

              Snacks.terminal.open(cmd, {
                win = {
                  position = "right", -- Opens as a vertical side split
                  width = 0.45, -- Takes 45% of screen width
                },
                interactive = true,
                auto_close = false, -- Keeps window open if process exits
              })
            end,
          },
        },
        -- Dynamic Daemon / Harness Status Widget
        {
          title = "Local Services",
          padding = 1,
          function()
            local running = is_process_running("opencode")

            local status_icon = running and " " or " "
            local status_text = running and "Active" or "Stopped"
            local status_hl = running and "DiagnosticOk" or "DiagnosticWarn"

            return {
              {
                text = {
                  { "  OpenCode Daemon: ", hl = "SnacksDashboardDesc" },
                  { status_icon .. status_text, hl = status_hl },
                },
              },
              {
                icon = running and "󰒲 " or " ",
                desc = running and "Attach / Focus Session" or "Start OpenCode",
                key = "o",
                action = function()
                  if running then
                    -- Attach or focus existing terminal
                    Snacks.terminal.open("opencode attach", {
                      win = { position = "right", width = 0.45 },
                    })
                  else
                    -- Spawn daemon / interactive process
                    Snacks.terminal.open("opencode", {
                      win = { position = "right", width = 0.45 },
                    })
                  end
                end,
              },
            }
          end,
        },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
        {
          section = "terminal",
          cmd = "git status -sb 2>/dev/null || echo 'Not a git repo'",
          height = 5,
          padding = 1,
          ttl = 5 * 60, -- Cache for 5 minutes
          indent = 2,
        },
        { section = "startup" },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    rename = { enabled = true },
    zen = {
      enabled = true,
      toggles = {
        ufo = true,
        dim = true,
        git_signs = false,
        diagnostics = false,
        line_number = false,
        relative_number = false,
        signcolumn = "no",
        indent = false,
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Registered so zen.toggles.ufo can disable folds while zen is active
    Snacks.toggle.new({
      id = "ufo",
      name = "Ufo folds",
      get = function()
        return vim.o.foldenable
      end,
      set = function(state)
        local ok, ufo = pcall(require, "ufo")
        if state then
          if ok then
            ufo.enable()
          end
          vim.o.foldenable = true
        else
          if ok then
            ufo.disable()
          end
          vim.o.foldenable = false
        end
      end,
    })
  end,
}
