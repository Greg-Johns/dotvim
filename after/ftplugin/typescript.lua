-- Resolve @ alias imports for gf command
vim.opt_local.suffixesadd:prepend(".ts,.tsx,.js,.jsx,/index.ts,/index.tsx,/index.js")
vim.opt_local.includeexpr = "v:lua.require('gajit.ts_includeexpr').resolve(v:fname)"
vim.opt_local.path:append("src")
