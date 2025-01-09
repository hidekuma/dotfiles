local lspconfig = require("lspconfig")
-- pyright에서 서브모듈인식을 해버려서 꼬여버릴경우가 있는데 최상위 루트에 아래 항목을 추가해서 처리
-- https://microsoft.github.io/pyright/#/settings?id=pyright-settings

-- local python_path = vim.fn.exepath("python") -- 현재 Neovim에서 실행 중인 Python 경로

return {
  root_dir = lspconfig.util.root_pattern(".project.root", "pyproject.toml", ".git"),
  settings = {
    python = {
      -- pythonPath = python_path,
      analysis = {
        -- diagnosticMode = "openFilesOnly",
        diagnosticMode = { "openFilesOnly" },
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        -- autoImportCompletions = true,
        -- diagnosticSeverityOverrides = {
        --   -- reportGeneralTypeIssues = "information",
        --   reportIncompatibleMethodOverride = "information",
        --   reportIncompatibleVariableOverride = "information"
        --   -- reportGeneralTypeIssues, reportCallIssue, reportArgumentType
        -- }
      },
    },
  }
}
