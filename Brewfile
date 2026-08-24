# Brewfile — hidekuma
#
#   brew bundle --file=~/dotfiles/Brewfile
#   brew bundle --file=~/dotfiles/Brewfile.local   # 사내/개인 앱 (gitignored)
#
# 재생성: bin/brew-dump.sh

# ─── taps ────────────────────────────────────────────────
tap "aws/tap"
tap "terraform-linters/tap"
tap "grafana/grafana"
tap "hashicorp/tap"
tap "homebrew/services"
tap "jesseduffield/lazygit"
tap "mongodb/brew", trusted: { formulae: ["mongodb-database-tools"] }
tap "warrensbox/tap"

# ─── core / shell ────────────────────────────────────────
brew "coreutils"
brew "curl"
brew "wget"
brew "git"
brew "git-lfs"
brew "git-delta"          # git pager
brew "gh"
brew "tig"
brew "lazygit"
brew "tmux"
brew "zsh"
brew "fzf"
brew "ripgrep"
brew "fd"                 # telescope/nvim-tree 속도
brew "bat"
brew "lsd"
brew "tree"
brew "jq"
brew "yq"
brew "watch"
brew "colordiff"
brew "grep"
brew "util-linux"
brew "gotop"
brew "telnet"
brew "tcping"
brew "openssh"

# ─── neovim + 주변 도구 ──────────────────────────────────
brew "neovim"
brew "tree-sitter"
brew "luajit"
brew "efm-langserver"
brew "stylua"             # conform: lua
brew "shfmt"              # conform: sh
brew "shellcheck"
brew "ruff"               # conform/lint: python
brew "terraform-linters/tap/tflint"   # lint: terraform
brew "ktlint"             # conform: kotlin

# ─── 언어 / 런타임 ───────────────────────────────────────
brew "pyenv"
brew "python@3.12"
brew "uv"
brew "poetry"
brew "virtualenv"
brew "nvm"
brew "go"
brew "jenv"
brew "openjdk@11"
brew "openjdk@17"
brew "kotlin"
brew "gradle"
brew "maven"
brew "ruby-build"
brew "ruby@3.1"

# ─── 인프라 / 클라우드 ───────────────────────────────────
brew "ansible"
brew "awscli"
brew "aws-sam-cli"
brew "aws-iam-authenticator"
brew "cfn-lint"
brew "tfenv"
brew "tgenv"
brew "kubernetes-cli"
brew "kubectx"
brew "helm"
brew "docker-compose"
brew "k6"
brew "pre-commit"
brew "commitizen"

# ─── DB ──────────────────────────────────────────────────
brew "mysql-client"
brew "redis"
brew "mongosh"
brew "mongocli"
brew "percona-toolkit"
brew "libpq"

# ─── 기타 ────────────────────────────────────────────────
brew "ffmpeg"
brew "graphviz"
brew "plantuml"
brew "docutils"
brew "mas"                # App Store 앱 설치용

# ─── AI CLI ──────────────────────────────────────────────
brew "gemini-cli"
cask "codex"

# ─── 폰트 ────────────────────────────────────────────────
cask "font-caskaydia-cove-nerd-font"
cask "font-cascadia-code"
cask "font-hack-nerd-font"
cask "font-jetbrains-mono"
cask "font-fira-code"
cask "font-iosevka"
cask "font-3270"
cask "font-ubuntu-nerd-font"

# ─── GUI 앱 ──────────────────────────────────────────────
cask "iterm2"
cask "visual-studio-code"
cask "jetbrains-toolbox"
cask "docker-desktop"
cask "google-chrome"
cask "obsidian"
cask "slack"
cask "claude"
cask "postman"
cask "karabiner-elements"
cask "appcleaner"
cask "hiddenbar"
cask "shortcat"
cask "scroll-reverser"
cask "keycastr"
cask "stats"
cask "obs"
cask "mongodb-compass"
cask "another-redis-desktop-manager"
cask "gcloud-cli"
