return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

    require("fidget").setup({
      notification = {
        window = {
          avoid = { "NvimTree" },
        },
      },
    })
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "vtsls",
        "graphql",
        "lua_ls",
        "rust_analyzer",
        "gopls",
      },

      handlers = {
        function(server_name)         -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["vtsls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.vtsls.setup {
            capabilities = capabilities,
          }
        end,
      }
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      virtual_text = true,
      signs = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Buffer-local LSP keybindings, attached only when an LSP client attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("gajit-lsp-attach", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
        map("n", "gy", vim.lsp.buf.type_definition, "LSP: Go to type definition")
        map("n", "gr", function()
          require("trouble").open("lsp_references")
        end, "LSP: References (Trouble)")

        -- Info
        map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")

        -- Actions
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")

        -- Diagnostics
        map("n", "]d", function()
          require("gajit.lsp_util").navigate_loclist("next")
        end, "Diagnostic: Next (popup)")
        map("n", "[d", function()
          require("gajit.lsp_util").navigate_loclist("prev")
        end, "Diagnostic: Prev (popup)")
        map("n", "<leader>de", vim.diagnostic.open_float, "Diagnostic: Open float")
        map("n", "<leader>dq", vim.diagnostic.setloclist, "Diagnostic: Set loclist")

        -- Workspace folders
        map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "LSP: Add workspace folder")
        map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "LSP: Remove workspace folder")
        map("n", "<leader>lwl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "LSP: List workspace folders")
      end,
    })
  end
}
