return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
  },
  keys = {
    {
      "<leader>Db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP: Toggle breakpoint",
    },
    {
      "<leader>DB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "DAP: Conditional breakpoint",
    },
    {
      "<leader>Dc",
      function()
        require("dap").continue()
      end,
      desc = "DAP: Continue",
    },
    {
      "<leader>Di",
      function()
        require("dap").step_into()
      end,
      desc = "DAP: Step into",
    },
    {
      "<leader>Do",
      function()
        require("dap").step_over()
      end,
      desc = "DAP: Step over",
    },
    {
      "<leader>DO",
      function()
        require("dap").step_out()
      end,
      desc = "DAP: Step out",
    },
    {
      "<leader>Dr",
      function()
        require("dap").run_last()
      end,
      desc = "DAP: Run last",
    },
    {
      "<leader>Dt",
      function()
        require("dap").terminate()
      end,
      desc = "DAP: Terminate",
    },
    {
      "<leader>Du",
      function()
        require("dapui").toggle()
      end,
      desc = "DAP: Toggle UI",
    },
    {
      "<leader>De",
      function()
        require("dapui").eval()
      end,
      mode = { "n", "v" },
      desc = "DAP: Eval",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()
    require("dap-go").setup()

    require("mason-nvim-dap").setup({
      ensure_installed = { "delve", "codelldb", "js-debug-adapter" },
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    -- Rust (codelldb)
    dap.configurations.rust = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- JavaScript / TypeScript (js-debug-adapter)
    for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[lang] = {
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- Auto open/close the UI with the debug session
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
