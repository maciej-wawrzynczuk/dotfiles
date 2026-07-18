# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The entry point is `init.lua`, which bootstraps lazy.nvim and calls `require("lazy").setup("plugins")` — this auto-discovers all files under `lua/plugins/`.

## Architecture

- **`init.lua`** — Global settings (tabstop=4, no mouse, termguicolors, updatetime=300), a CursorHold diagnostic float autocmd, terminal escape remap, and lazy.nvim bootstrap.
- **`lua/plugins/`** — Each file returns a lazy.nvim plugin spec (or a table of specs). lazy.nvim loads all files in this directory automatically. To add a plugin, create a new `.lua` file here returning a spec table.
- **`ftplugin/`** — Filetype-specific settings. Currently empty; Treesitter highlighting is enabled globally via a `FileType` autocmd in `treesitter.lua`.

## Key Plugins and Their Roles

| Plugin | File | Notes |
|---|---|---|
| **mason.nvim** + **mason-lspconfig** + **nvim-lspconfig** | `mason.lua` | LSP installation and config; servers must be installed via `:Mason` |
| **nvim-cmp** + **LuaSnip** | `cmp.lua` | Completion: `<CR>` confirms, `<Tab>`/`<S-Tab>` navigate, `<C-Space>` triggers |
| **telescope.nvim** | `telescope.lua` | `<leader>ff` files, `<leader>fg` grep, `<leader>fb` buffers, `<leader>fh` help |
| **trouble.nvim** | `trouble.lua` | `<leader>xx` diagnostics, `<leader>cs` symbols, `<leader>cl` LSP refs |
| **nvim-treesitter** | `treesitter.lua` | New refactored version — `setup()` only accepts `install_dir`; old `opts` (`highlight.enable`, `auto_install`) are silently ignored. Highlighting is enabled via a `FileType` autocmd calling `vim.treesitter.start()` with `pcall` (fails silently for filetypes without a parser). Build with `:TSUpdate`; `lazy=false`. |
| **tokyonight.nvim** | `tokionight.lua` | Loaded with `priority=1000`; not explicitly set as colorscheme in init.lua |
| **catppuccin** | `catpuccin.lua` | Alternative theme; used by `auto-gnome-theme.nvim` |
| **auto-gnome-theme** | `auto-gnome-theme.lua` | Switches between `catppuccin-latte` (light) and `catppuccin` (dark) based on GNOME theme |
| **gen.nvim** | `gen.lua` | Local LLM integration via Ollama (`gemma3:4b`); custom prompts: `Fix_Writing`, `Reformat_80` |
| **vim-fugitive** | `git_fugitive.lua` | Git integration, loaded `VeryLazy` |
| **rainbow_csv** | `rainbow_csv.lua` | CSV column highlighting |
| **todo-comments** | `todo-comments.lua` | Highlights TODO/FIXME/etc. comments |
| **nvim-autopairs** | `autopair.lua` | Auto-closes brackets/quotes on `InsertEnter` |
| **lualine** | `lualine.lua` | Statusline with filename, LSP status, and LSP progress in section `lualine_c` |

## Code Quality

Pre-commit hooks are configured in `.pre-commit-config.yaml` and already installed in `.git/hooks/pre-commit`.

- **stylua** (`stylua-system`) — formatter; config in `.stylua.toml` (tabs, width 4, column 120)
- **luacheck** (`docker_image: pipelinecomponents/luacheck`) — linter; config in `.luacheckrc` (`vim` declared as global)
- **nvim headless startup** — `nvim --headless "+qa" 2>&1` must exit cleanly (no output, exit 0); mandatory check after any plugin change

To run manually: `pre-commit run --all-files`

## Adding a New Plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec:

```lua
return {
    "author/plugin-name",
    -- optional: event, cmd, keys, opts, config, dependencies, build, lazy, priority
}
```

## Conventions

- Indentation: tabs (Neovim's default for Lua files; `tabstop=4` applies to edited files).
- Plugin keymaps are defined in the plugin spec's `keys` table, not in `init.lua`.
- `<leader>` is not explicitly set, so it defaults to `\`.
