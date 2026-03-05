-- LSP utility module for diagnostic navigation
-- Converts LSP diagnostics to location list format for easy navigation

local M = {}

-- Helper: Convert diagnostic severity to qflist type
local function get_severity_type(severity)
  if severity == vim.diagnostic.severity.ERROR then
    return "E"
  elseif severity == vim.diagnostic.severity.WARN then
    return "W"
  elseif severity == vim.diagnostic.severity.INFO then
    return "I"
  elseif severity == vim.diagnostic.severity.HINT then
    return "H"
  end
  return "E"
end

-- Helper: Convert single diagnostic to qflist item
local function diagnostic_to_qfitem(diag, bufnr)
  return {
    bufnr = bufnr,
    lnum = diag.lnum + 1,           -- Convert 0-indexed to 1-indexed
    col = diag.col + 1,             -- Convert 0-indexed to 1-indexed
    type = get_severity_type(diag.severity),
    text = diag.message,
  }
end

-- Populate location list with current buffer's LSP diagnostics
function M.populate_loclist()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  if #diagnostics == 0 then
    return 0
  end

  -- Convert diagnostics to qflist items
  local qflist = {}
  for _, diag in ipairs(diagnostics) do
    table.insert(qflist, diagnostic_to_qfitem(diag, bufnr))
  end

  -- Sort by line number
  table.sort(qflist, function(a, b)
    return a.lnum < b.lnum
  end)

  -- Set location list and position cursor at first item
  vim.fn.setloclist(0, qflist, " ")

  return #qflist
end

-- Safe navigation with automatic location list population
function M.navigate_loclist(direction)
  -- Populate location list with current diagnostics
  local count = M.populate_loclist()

  if count == 0 then
    vim.notify("No diagnostics in current buffer", vim.log.levels.INFO)
    return
  end

  -- Navigate safely using pcall
  local cmd = direction == "next" and "lnext" or "lprev"
  local success, err = pcall(function()
    vim.api.nvim_command(cmd)
    vim.api.nvim_command("normal! zz")  -- Center view on diagnostic
  end)

  if not success then
    vim.notify("Error navigating diagnostics: " .. tostring(err), vim.log.levels.WARN)
  end
end

return M
