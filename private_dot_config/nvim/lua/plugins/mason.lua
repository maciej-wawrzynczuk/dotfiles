return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = { command = "clippy" },
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "lua_ls",
                "ltex_plus",
                "bashls",
                "yamlint",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
                end

                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, "Format buffer")
            end,
        })
    end,
}
