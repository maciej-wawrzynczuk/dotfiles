vim.api.nvim_create_user_command("Daily", function()
    local base = vim.fn.expand("~/my_notes/notes/daily/")
    local template = base .. "template.md"
    local f = base .. os.date("%Y-%m-%d") .. ".md"

    if not vim.uv.fs_stat(f) then
       vim.fn.writefile(vim.fn.readfile(template), f)
    end

    vim.cmd.edit(f)
end, {})
