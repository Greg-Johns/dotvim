return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open git status" })

        local Gajit_Fugitive = vim.api.nvim_create_augroup("Gajit_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Gajit_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false, desc = "Git push"}
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull',  '--rebase'})
                end, vim.tbl_extend("force", opts, { desc = "Git pull with rebase" }))

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", vim.tbl_extend("force", opts, { desc = "Git push with upstream" }));
            end,
        })


        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Git diffget from left (ours)" })
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git diffget from right (theirs)" })
    end
}
