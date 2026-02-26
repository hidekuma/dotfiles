# Neovim Setup Notes

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim). Run `:Lazy` to manage plugins.

## LSP: pylsp

- Config: `lua/user/lsp/settings/pylsp.lua`
- Docs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
- Black formatting requires manual install inside Mason venv:
    ```sh
    cd ~/.local/share/nvim/mason/packages/python-lsp-server/venv
    pip install python-lsp-black
    ```
