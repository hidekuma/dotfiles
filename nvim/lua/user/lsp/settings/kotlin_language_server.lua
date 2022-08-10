local lspconfig = require 'lspconfig'
return {
    root_dir = lspconfig.util.root_pattern(
        "settings.gradle",
        "settings.gradle.kts",
        "build.gradle",
        "build.gradle.kts",
        ".git"
    ),
    filetypes = { "kotlin" }
}
