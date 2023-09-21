local lspconfig = require("lspconfig")
local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
    py_path = venv_path .. "/bin/python3"
else
    py_path = vim.g.python3_host_prog
end


-- NOTE
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- ~/.local/share/nvim/mason/bin/pylsp 이쪽에 들어가서 서드파티black 을 pip install 해줘야 black formatting 사용가능
-- 2023/09/14 updated 경로 변경됨, 재설치
-- pip install python-lsp-black
-- /Users/joseph/.local/share/nvim/mason/packages/python-lsp-server/venv
return {
    settings = {
        pylsp = {
            -- cmd = { "~/.local/share/nvim/mason/bin/pylsp", "--log-file=~/pylsp.log" },
            -- cmd = { '/home/eash/scratch/.local/nvim/lsp_servers/pylsp/venv/bin/pylsp', '-v', '-v', '--log-file', '/home/eash/pylsp.log' },
            -- cmd_env = {
            --     VIRTUAL_ENV = ".venv",
            --     PATH = lsputil.path.join(".venv", "bin") .. ":" .. vim.env.PATH,
            -- },
            plugins = {
                black = { enabled = true },
                isort = { enabled = true },
                -- type checker
                pylsp_mypy = {
                    enabled = true,
                    overrides = { "--python-executable", py_path, true },
                    report_progress = true,
                    live_mode = false
                },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                -- rope_autoimport = { enabled = true },
            }
        }
    },
}
