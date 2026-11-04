function ColorMe(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    -- Clear only the background; nvim_set_hl replaces the whole group, so keep existing attributes
    for _, group in ipairs({ "Normal", "NormalFloat" }) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.bg = "none"
        vim.api.nvim_set_hl(0, group, hl)
    end
end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true,     -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })

            ColorMe("tokyonight");
        end
    },
}
