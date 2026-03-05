-- LSP utility module for diagnostic navigation
-- Converts LSP diagnostics to location list format for easy navigation

local M = {}

-- Define popup highlight colors
vim.api.nvim_set_hl(0, "ErrorPopup", { fg = "#ff0000", bg = "NONE" })      -- Red
vim.api.nvim_set_hl(0, "WarningPopup", { fg = "#ffff00", bg = "NONE" })    -- Yellow
vim.api.nvim_set_hl(0, "InfoPopup", { fg = "#ffffff", bg = "NONE" })       -- White

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
    M.show_error_popup("No diagnostics in current buffer")
    return
  end

  -- Navigate safely using pcall
  local cmd = direction == "next" and "lnext" or "lprev"
  local success, err = pcall(function()
    vim.api.nvim_command(cmd)
    vim.api.nvim_command("normal! zz")  -- Center view on diagnostic
    M.show_diagnostic_popup_above()      -- Show diagnostic details
  end)

  if not success then
    M.show_error_popup("Error navigating diagnostics: " .. tostring(err))
  end
end

-- Helper: Convert severity number to label string
local function get_severity_label(severity)
  if severity == vim.diagnostic.severity.ERROR then
    return "Error"
  elseif severity == vim.diagnostic.severity.WARN then
    return "Warning"
  elseif severity == vim.diagnostic.severity.INFO then
    return "Info"
  elseif severity == vim.diagnostic.severity.HINT then
    return "Hint"
  end
  return "Unknown"
end

-- Helper: Word wrap text to specified width
local function word_wrap_text(text, width)
  local lines = {}
  local current_line = ""

  for word in text:gmatch("%S+") do
    if current_line == "" then
      current_line = word
    elseif #current_line + 1 + #word <= width then
      current_line = current_line .. " " .. word
    else
      table.insert(lines, current_line)
      current_line = word
    end
  end

  if current_line ~= "" then
    table.insert(lines, current_line)
  end

  return lines
end

-- Base notification popup function with color support
function M.show_notification_popup(message, highlight_group)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  -- Word wrap message if needed
  local message_lines = {}
  if type(message) == "string" then
    message_lines = word_wrap_text(message, 60)
  else
    message_lines = message
  end

  -- Calculate popup dimensions
  local popup_width = 0
  for _, line in ipairs(message_lines) do
    popup_width = math.max(popup_width, #line)
  end
  popup_width = popup_width + 4  -- padding

  local popup_height = #message_lines + 2  -- content + borders

  -- Calculate center position
  local col = math.floor((width - popup_width) / 2)
  local row = math.floor((height - popup_height) / 2)

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, message_lines)

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width = popup_width,
    height = popup_height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- Set highlight with specified color
  vim.api.nvim_set_option_value("winhl", "Normal:" .. highlight_group, { win = win })

  -- Auto-close after 2 seconds
  vim.fn.timer_start(2000, function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end)
end

-- Color-specific popup wrappers
function M.show_error_popup(message)
  M.show_notification_popup(message, "ErrorPopup")
end

function M.show_warning_popup(message)
  M.show_notification_popup(message, "WarningPopup")
end

function M.show_info_popup(message)
  M.show_notification_popup(message, "InfoPopup")
end

-- Show diagnostic popup above the diagnostic location with intelligent positioning
function M.show_diagnostic_popup_above()
  local bufnr = vim.api.nvim_get_current_buf()
  local loclist = vim.fn.getloclist(0)
  
  if #loclist == 0 then
    return
  end

  -- Get current location in list
  local current_idx = vim.fn.getloclist(0, { idx = 0 }).idx or 1
  local current_item = loclist[current_idx]

  if not current_item then
    return
  end

  -- Find matching diagnostic
  local diagnostics = vim.diagnostic.get(bufnr)
  local matching_diag = nil

  for _, diag in ipairs(diagnostics) do
    if diag.lnum == current_item.lnum - 1 and diag.col == current_item.col - 1 then
      matching_diag = diag
      break
    end
  end

  if not matching_diag then
    return
  end

  -- Format diagnostic information
  local severity_label = get_severity_label(matching_diag.severity)
  local source = matching_diag.source or "unknown"
  local message = matching_diag.message or ""

  -- Word wrap message to 60 characters
  local message_lines = word_wrap_text(message, 60)

  -- Build popup content
  local popup_lines = {}
  table.insert(popup_lines, severity_label .. " (" .. source .. ")")
  for _, line in ipairs(message_lines) do
    table.insert(popup_lines, line)
  end

  -- Calculate popup dimensions
  local popup_width = 0
  for _, line in ipairs(popup_lines) do
    popup_width = math.max(popup_width, #line)
  end
  popup_width = popup_width + 4  -- padding

  local popup_height = #popup_lines + 2  -- content + borders

  -- Get window dimensions
  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  local current_row = vim.fn.line(".")

  -- Calculate center column position
  local col = math.floor((win_width - popup_width) / 2)
  col = math.max(0, math.min(col, win_width - popup_width))  -- Clamp to window bounds

  -- Intelligently position popup (above by default, below if needed)
  local row = math.max(0, current_row - 5)  -- Try to position 5 rows above cursor

  -- If popup would go off top of screen, position below instead
  if current_row - 5 < 0 then
    row = current_row + 2  -- Position 2 rows below cursor
  end

  -- If popup would go off bottom of screen, adjust to fit
  if row + popup_height > win_height then
    row = math.max(0, win_height - popup_height - 1)
  end

  -- Create buffer with formatted content
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, popup_lines)

  -- Create floating window with cursor-relative positioning
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width = popup_width,
    height = popup_height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- Set red highlight (ErrorMsg)
  vim.api.nvim_set_option_value("winhl", "Normal:ErrorMsg", { win = win })

  -- Auto-close after 2 seconds
  vim.fn.timer_start(2000, function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end)
end

return M
