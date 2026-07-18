# Neovim Configuration

Personal Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.11
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- [Ollama](https://ollama.com/) with `gemma3:4b` (for gen.nvim AI prompts)
- A Nerd Font (for icons in lualine and telescope)

## Structure

```
init.lua              # Global options, autocmds, lazy.nvim bootstrap
lua/plugins/          # One file per plugin (auto-loaded by lazy.nvim)
.stylua.toml          # Formatter config (tabs, column width 120)
.luacheckrc           # Linter config
.pre-commit-config.yaml
```

## Plugins

| Plugin | Purpose |
|---|---|
| **mason** + **mason-lspconfig** + **nvim-lspconfig** | LSP server management and config |
| **nvim-cmp** + **LuaSnip** | Completion and snippets |
| **telescope.nvim** + fzf native | Fuzzy finder |
| **trouble.nvim** | Diagnostics and LSP reference panel |
| **nvim-treesitter** | Syntax highlighting and indentation (auto-installs parsers) |
| **catppuccin** + **auto-gnome-theme** | Theme, switches light/dark with GNOME |
| **tokyonight.nvim** | Alternative theme (available but not active) |
| **lualine.nvim** | Statusline with LSP status and progress |
| **vim-fugitive** | Git integration |
| **nvim-autopairs** | Auto-close brackets and quotes |
| **todo-comments.nvim** | Highlight and search TODO/FIXME comments |
| **rainbow_csv** | CSV column highlighting |
| **gen.nvim** | Local LLM prompts via Ollama |

## Key Bindings

`<leader>` defaults to `\`.

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>ft` | Find TODOs |

### LSP (active in LSP-attached buffers)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action (normal + visual) |
| `<leader>f` | Format buffer |
| `grn` | Rename symbol (Neovim default) |
| `gra` | Code action (Neovim default) |
| `grr` | References (Neovim default) |
| `gri` | Implementation (Neovim default) |

### Diagnostics / Trouble

| Key | Action |
|---|---|
| `<leader>xx` | Toggle diagnostics (workspace) |
| `<leader>xX` | Toggle diagnostics (buffer) |
| `<leader>cs` | Symbols panel |
| `<leader>cl` | LSP definitions / references panel |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

### Completion (insert mode)

| Key | Action |
|---|---|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` / `<S-Tab>` | Next / previous item or jump snippet |
| `<C-u>` / `<C-d>` | Scroll docs up / down |

### Terminal

| Key | Action |
|---|---|
| `<Esc>` | Exit terminal mode |

## LSP Servers

Install servers via `:Mason`. Currently configured: `lua_ls`, `pyright`, `rust_analyzer`, `groovyls`, `ansiblels`.

Servers are auto-configured with nvim-cmp capabilities when installed.

## gen.nvim (Local LLM)

Requires Ollama running locally with the `gemma3:4b` model pulled.

Run `:Gen` to open the prompt menu. Custom prompts:

| Prompt | Action |
|---|---|
| `Fix_Writing` | Fix grammar, spelling, and style (replaces selection) |
| `Reformat_80` | Reformat to 80-column width (replaces selection) |

## Code Quality

Pre-commit hooks run automatically on commit:

- **StyLua** — Lua formatter
- **luacheck** — Lua linter
- **nvim headless check** — `nvim --headless +qa` must exit cleanly

Run manually: `pre-commit run --all-files`
