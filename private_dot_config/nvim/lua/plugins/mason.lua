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
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        })
        vim.lsp.config("ltex_plus", {
            settings = {
                ltex = { language = "auto" }
            }
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client or client.name ~= "ltex_plus" then
                    return
                end
                require("ltex_extra").setup({
                    path = vim.fn.stdpath("data") .. "/ltex",
                })
            end
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "lua_ls",
                "ltex_plus",
                "bashls",
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
