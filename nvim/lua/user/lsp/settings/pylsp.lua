local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
    py_path = venv_path .. "/bin/python3"
else
    py_path = vim.g.python3_host_prog
end


-- log py_path
print("py_path: " .. py_path)

-- NOTE
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- ~/.local/share/nvim/mason/bin/pylsp 이쪽에 들어가서 서드파티black 을 pip install 해줘야 black formatting 사용가능
-- 2023/09/14 updated 경로 변경됨, 재설치
-- pip install python-lsp-black
-- /Users/joseph/.local/share/nvim/mason/packages/python-lsp-server/venv
--  ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/pip install pylsp-rope

return {
    settings = {
        pylsp = {
            pycodestyle = {
                ignore = { "W391" },
            }
            plugins = {
                jedi = {
                    extra_paths = { py_path }
                },
                jedi_completion = { enabled = true },
                rope_autoimport = { enabled = true },
            }
        }
    },
}
