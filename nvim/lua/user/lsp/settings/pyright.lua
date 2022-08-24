local lspconfig = require("lspconfig")
-- pyright에서 서브모듈인식을 해버려서 꼬여버릴경우가 있는데 최상위 루트에 아래 항목을 추가해서 처리
return {
	root_dir = lspconfig.util.root_pattern(".project.root"),
}
