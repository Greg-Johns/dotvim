return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  config = function()
    local ufo = require("ufo")

    -- Show how many lines are hidden at the end of a closed fold
    local function fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
      local new_virt_text = {}
      local suffix = ("  󰁂 %d lines "):format(end_lnum - lnum)
      local suffix_width = vim.fn.strdisplaywidth(suffix)
      local target_width = width - suffix_width
      local cur_width = 0
      for _, chunk in ipairs(virt_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)
        if target_width > cur_width + chunk_width then
          table.insert(new_virt_text, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - cur_width)
          table.insert(new_virt_text, { chunk_text, chunk[2] })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)
          if cur_width + chunk_width < target_width then
            suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
          end
          break
        end
        cur_width = cur_width + chunk_width
      end
      table.insert(new_virt_text, { suffix, "MoreMsg" })
      return new_virt_text
    end

    ufo.setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = fold_virt_text_handler,
    })

    -- Folding (ufo)
    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
    vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with level" })

    -- Peek folded lines, falling back to LSP hover
    vim.keymap.set("n", "K", function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek fold or hover" })
  end,
}
