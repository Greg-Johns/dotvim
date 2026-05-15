local M = {}

-- Strip JSONC comments (// and /* */) so vim.json.decode can parse tsconfig
local function strip_jsonc_comments(text)
  -- Remove block comments
  text = text:gsub("/%*.-%*/", "")
  -- Remove line comments (but not inside strings)
  text = text:gsub("\n%s*//[^\n]*", "\n")
  -- Remove line comments at start of file
  text = text:gsub("^%s*//[^\n]*", "")
  return text
end

-- Cache tsconfig results per project root to avoid re-parsing on every gf
local tsconfig_cache = {}

-- Find and parse the nearest tsconfig.json, returning compilerOptions.paths
local function get_tsconfig_paths(bufdir)
  local tsconfig_names = { "tsconfig.json", "tsconfig.app.json" }
  local found = vim.fs.find(tsconfig_names, {
    upward = true,
    path = bufdir,
    limit = 1,
  })

  if #found == 0 then
    return nil, nil
  end

  local tsconfig_path = found[1]

  -- Return cached result if available
  if tsconfig_cache[tsconfig_path] then
    return tsconfig_cache[tsconfig_path].paths,
      tsconfig_cache[tsconfig_path].base_url,
      tsconfig_cache[tsconfig_path].root
  end

  local file = io.open(tsconfig_path, "r")
  if not file then
    return nil, nil
  end

  local content = file:read("*a")
  file:close()

  local ok, parsed = pcall(vim.json.decode, strip_jsonc_comments(content))
  if not ok or not parsed then
    return nil, nil
  end

  local compiler_opts = parsed.compilerOptions or {}
  local paths = compiler_opts.paths
  local base_url = compiler_opts.baseUrl or "."
  local root = vim.fn.fnamemodify(tsconfig_path, ":h")

  tsconfig_cache[tsconfig_path] = {
    paths = paths,
    base_url = base_url,
    root = root,
  }

  return paths, base_url, root
end

-- Resolve an @-aliased import to a real relative path
function M.resolve(fname)
  -- If it doesn't look like an alias, return as-is
  if not fname:match("^@") then
    return fname
  end

  local bufdir = vim.fn.expand("%:p:h")
  local paths, base_url, root = get_tsconfig_paths(bufdir)

  if paths and root then
    -- Try each path alias pattern
    for pattern, targets in pairs(paths) do
      -- Convert tsconfig glob pattern to lua pattern
      -- e.g. "@/*" -> "^@/(.*)"
      -- e.g. "@components/*" -> "^@components/(.*)"
      local lua_pattern = "^" .. pattern:gsub("%*", "(.*)")
      -- Escape special lua pattern chars except the capture we just added
      lua_pattern = lua_pattern:gsub("%-", "%%-")

      local match = fname:match(lua_pattern)
      if match then
        -- Use the first target mapping (most common)
        local target = targets[1]
        -- Replace the wildcard in the target with the matched portion
        local resolved = target:gsub("%*", match)
        -- Resolve relative to baseUrl and tsconfig root
        local full = root .. "/" .. base_url .. "/" .. resolved
        -- Normalize the path
        full = vim.fn.simplify(full)
        return full
      end
    end
  end

  -- Fallback: replace @/ with src/
  if fname:match("^@/") then
    return fname:gsub("^@/", "src/")
  end

  -- Last resort: strip @ prefix entirely
  return fname:gsub("^@", "")
end

return M
