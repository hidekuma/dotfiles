# Neovim Setup Notes

## Plugins to Consider

- use({ "beeender/Comrade" })
    - https://plugins.jetbrains.com/plugin/12153-comrade-neovim
    - /Users/joseph/.local/share/nvim/site/pack/packer/start/Comrade
    ```python
        # NVIM_LISTEN_ADDRESS is deprecated : https://neovim.io/doc/user/deprecated.html
        addr = os.getenv("NVIM_LISTEN_ADDRESS")
        if addr is None:
            addr = os.getenv("NVIM")
    ```
- /Users/joseph/dotfiles/nvim/lua/user/lsp/settings/pylsp.lua
    - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
    - ~/.local/share/nvim/mason/bin/pylsp 이쪽에 들어가서 서드파티black 을 pip install 해줘야 black formatting 사용가능
    - 2023/09/14 updated 경로 변경됨, 재설치
    - pip install python-lsp-black
    - /Users/joseph/.local/share/nvim/mason/packages/python-lsp-server/venv
    - PylspInstall black?
