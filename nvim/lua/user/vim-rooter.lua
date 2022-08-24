--[[ submodule프로젝트에서 .git 이거때문에 루트가 자꾸 바뀜.. ]]
-- 아래로 해결
vim.g.rooter_patterns = { ".project.root", "!=common", ".git" }
vim.g.rooter_silent_chdir = 1
