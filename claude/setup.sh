#!/usr/bin/env bash
#
# Claude Code 설정 자동화 스크립트
#
# 역할:
# - dotfiles/claude/* → ~/.claude/* 심볼릭 링크 생성
# - LSP 서버 설치 (TypeScript, Python, etc.)
# - Claude 플러그인 설치
#
# 사용법:
#   ./setup.sh              # 기본 설치
#   ./setup.sh --force      # 기존 설정 백업 후 덮어쓰기
#   ./setup.sh --dry-run    # 실제 변경 없이 미리보기
#   ./setup.sh --uninstall  # 심볼릭 링크 제거
#   ./setup.sh --minimal    # 심볼릭 링크만 생성
#   ./setup.sh --help       # 도움말

set -eo pipefail

# ============================================================================
# 전역 변수
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_CLAUDE_DIR="$SCRIPT_DIR"
CLAUDE_HOME="$HOME/.claude"

# 옵션 플래그
FORCE_INSTALL=false
DRY_RUN=false
UNINSTALL=false
MINIMAL=false
VERBOSE=false

# 환경 변수
OS_TYPE=""
PACKAGE_MANAGER=""

# 색상 코드
COLOR_RESET="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_GRAY="\033[0;90m"

# ============================================================================
# 유틸리티 함수
# ============================================================================

log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $*"
}

log_warn() {
    echo -e "${COLOR_YELLOW}[WARN]${COLOR_RESET} $*"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" >&2
}

log_dry() {
    echo -e "${COLOR_GRAY}[DRY-RUN]${COLOR_RESET} $*"
}

log_verbose() {
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${COLOR_GRAY}[VERBOSE]${COLOR_RESET} $*"
    fi
}

# ============================================================================
# 환경 감지 함수
# ============================================================================

detect_os() {
    log_verbose "운영체제 감지 중..."

    case "$(uname -s)" in
        Darwin)
            OS_TYPE="macos"
            log_verbose "macOS 감지됨"
            ;;
        Linux)
            OS_TYPE="linux"
            log_verbose "Linux 감지됨"
            ;;
        *)
            log_error "지원하지 않는 운영체제입니다: $(uname -s)"
            exit 1
            ;;
    esac
}

detect_package_manager() {
    log_verbose "패키지 매니저 감지 중..."

    if [[ "$OS_TYPE" == "macos" ]]; then
        if command -v brew &> /dev/null; then
            PACKAGE_MANAGER="brew"
            log_verbose "Homebrew 감지됨"
        else
            log_warn "Homebrew가 설치되어 있지 않습니다"
            PACKAGE_MANAGER="none"
        fi
    elif [[ "$OS_TYPE" == "linux" ]]; then
        if command -v apt-get &> /dev/null; then
            PACKAGE_MANAGER="apt"
            log_verbose "apt 감지됨"
        elif command -v dnf &> /dev/null; then
            PACKAGE_MANAGER="dnf"
            log_verbose "dnf 감지됨"
        elif command -v yum &> /dev/null; then
            PACKAGE_MANAGER="yum"
            log_verbose "yum 감지됨"
        else
            log_warn "지원하는 패키지 매니저를 찾을 수 없습니다"
            PACKAGE_MANAGER="none"
        fi
    fi
}

check_claude_cli() {
    log_verbose "Claude CLI 설치 확인 중..."

    if ! command -v claude &> /dev/null; then
        log_warn "Claude CLI가 설치되어 있지 않습니다"
        log_warn "설치 방법: https://github.com/anthropics/claude-code"
        return 1
    fi

    log_verbose "Claude CLI 감지됨: $(command -v claude)"
    return 0
}

# ============================================================================
# 핵심 작업 함수
# ============================================================================

backup_existing() {
    local backup_dir="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"

    if [[ ! -d "$CLAUDE_HOME" ]]; then
        log_verbose "백업할 기존 설정이 없습니다"
        return
    fi

    # 심볼릭 링크만 있는지 확인 (실제 데이터가 없으면 백업 불필요)
    local has_real_files=false
    for item in "$CLAUDE_HOME"/*; do
        if [[ -e "$item" ]] && [[ ! -L "$item" ]]; then
            has_real_files=true
            break
        fi
    done

    if [[ "$has_real_files" == false ]]; then
        log_verbose "실제 파일이 없어 백업을 건너뜁니다"
        return
    fi

    log_info "기존 설정 백업 중..."

    if [[ "$DRY_RUN" == true ]]; then
        log_dry "백업 생성: $backup_dir"
        return
    fi

    mkdir -p "$backup_dir"
    cp -r "$CLAUDE_HOME"/* "$backup_dir/" 2>/dev/null || true
    log_success "백업 완료: $backup_dir"
}

create_symlinks() {
    log_info "심볼릭 링크 생성 중..."

    # ~/.claude 디렉토리 생성
    if [[ "$DRY_RUN" == true ]]; then
        log_dry "디렉토리 생성: $CLAUDE_HOME"
    else
        mkdir -p "$CLAUDE_HOME"
    fi

    # 심볼릭 링크 생성할 항목들 (claude.json 제외!)
    local items=(
        "settings.json"
        "CLAUDE.md"
        "agents"
        "commands"
        "rules"
    )

    for item in "${items[@]}"; do
        local source="$DOTFILES_CLAUDE_DIR/$item"
        local target="$CLAUDE_HOME/$item"

        # 소스 파일/디렉토리 존재 확인
        if [[ ! -e "$source" ]]; then
            log_warn "소스를 찾을 수 없습니다: $source"
            continue
        fi

        # 이미 심볼릭 링크가 있고 올바른 경우 스킵
        if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
            log_verbose "이미 올바른 심볼릭 링크가 있습니다: $item"
            continue
        fi

        # 기존 파일/디렉토리가 있는 경우 처리
        if [[ -e "$target" ]] || [[ -L "$target" ]]; then
            if [[ "$FORCE_INSTALL" == true ]]; then
                if [[ "$DRY_RUN" == true ]]; then
                    log_dry "기존 항목 제거: $target"
                else
                    rm -rf "$target"
                    log_verbose "기존 항목 제거됨: $target"
                fi
            else
                log_error "이미 존재합니다: $target"
                log_error "--force 옵션을 사용하여 덮어쓸 수 있습니다"
                exit 1
            fi
        fi

        # 심볼릭 링크 생성
        if [[ "$DRY_RUN" == true ]]; then
            log_dry "심볼릭 링크 생성: $target -> $source"
        else
            ln -s "$source" "$target"
            log_success "  → $item"
        fi
    done
}

remove_symlinks() {
    log_info "심볼릭 링크 제거 중..."

    local items=(
        "settings.json"
        "CLAUDE.md"
        "agents"
        "commands"
        "rules"
    )

    for item in "${items[@]}"; do
        local target="$CLAUDE_HOME/$item"

        if [[ -L "$target" ]]; then
            if [[ "$DRY_RUN" == true ]]; then
                log_dry "심볼릭 링크 제거: $target"
            else
                rm "$target"
                log_success "  ✗ $item"
            fi
        else
            log_verbose "심볼릭 링크가 아닙니다: $item"
        fi
    done

    log_success "제거 완료"
}

install_lsp() {
    log_info "LSP 서버 설치 중..."

    # TypeScript LSP
    if command -v npm &> /dev/null; then
        if [[ "$DRY_RUN" == true ]]; then
            log_dry "npm install -g typescript typescript-language-server"
            log_dry "npm install -g vscode-langservers-extracted"
            log_dry "npm install -g yaml-language-server"
        else
            log_verbose "TypeScript LSP 설치 중..."
            npm install -g typescript typescript-language-server 2>/dev/null || true
            log_success "  → typescript-language-server"

            npm install -g vscode-langservers-extracted 2>/dev/null || true
            log_success "  → vscode-langservers-extracted (json, html, css)"

            npm install -g yaml-language-server 2>/dev/null || true
            log_success "  → yaml-language-server"
        fi
    else
        log_warn "npm이 없어 TypeScript LSP를 설치할 수 없습니다"
    fi
}

install_plugins() {
    if ! check_claude_cli; then
        log_warn "Claude CLI가 없어 플러그인 설치를 건너뜁니다"
        return
    fi

    log_info "Marketplace 추가 중..."

    if [[ "$DRY_RUN" == true ]]; then
        log_dry "claude plugin marketplace add https://github.com/anthropics/claude-plugins-official"
        log_dry "claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode"
        log_dry "claude plugin marketplace add https://github.com/affaan-m/everything-claude-code"
    else
        claude plugin marketplace add https://github.com/anthropics/claude-plugins-official 2>/dev/null || true
        claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode 2>/dev/null || true
        claude plugin marketplace add https://github.com/affaan-m/everything-claude-code 2>/dev/null || true
        log_success "  → Marketplace 추가 완료"
    fi

    log_info "플러그인 설치 중..."

    # 플러그인 목록
    local plugins=(
        "oh-my-claudecode@omc"
        "everything-claude-code@everything-claude-code"
        "typescript-lsp@claude-plugins-official"
        "code-review@claude-plugins-official"
        "explanatory-output-style@claude-plugins-official"
        "learning-output-style@claude-plugins-official"
        "commit-commands@claude-plugins-official"
        "security-guidance@claude-plugins-official"
        "feature-dev@claude-plugins-official"
        "pr-review-toolkit@claude-plugins-official"
        "serena@claude-plugins-official"
        "context7@claude-plugins-official"
        "playwright@claude-plugins-official"
        "github@claude-plugins-official"
    )

    for plugin in "${plugins[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            log_dry "claude plugin install $plugin"
        else
            claude plugin install "$plugin" 2>/dev/null || true
            log_success "  → $plugin"
        fi
    done
}

verify_installation() {
    log_info "설치 검증 중..."

    local all_ok=true

    # 심볼릭 링크 확인
    local items=(
        "settings.json"
        "CLAUDE.md"
        "agents"
        "commands"
        "rules"
    )

    echo ""
    for item in "${items[@]}"; do
        local target="$CLAUDE_HOME/$item"
        if [[ -L "$target" ]]; then
            echo -e "  ${COLOR_GREEN}✓${COLOR_RESET} $item"
        else
            echo -e "  ${COLOR_RED}✗${COLOR_RESET} $item"
            all_ok=false
        fi
    done
    echo ""

    # 순환 심볼릭 링크 확인
    if [[ -e "$DOTFILES_CLAUDE_DIR/agents/agents" ]] || [[ -e "$DOTFILES_CLAUDE_DIR/commands/commands" ]]; then
        log_error "순환 심볼릭 링크가 감지되었습니다!"
        all_ok=false
    fi

    if [[ "$all_ok" == true ]]; then
        log_success "모든 검증 통과!"
    else
        log_error "일부 검증 실패"
        return 1
    fi
}

# ============================================================================
# 옵션 파싱
# ============================================================================

show_help() {
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════╗
║          Claude Code Configuration Setup                   ║
╚═══════════════════════════════════════════════════════════╝

사용법:
  ./setup.sh [옵션]

옵션:
  -h, --help        이 도움말 출력
  -f, --force       기존 설정 백업 후 덮어쓰기
  -n, --dry-run     실제 변경 없이 수행할 작업 출력
  -u, --uninstall   심볼릭 링크 제거
  -m, --minimal     심볼릭 링크만 생성 (LSP, 플러그인 설치 제외)
  -v, --verbose     상세 로그 출력

예시:
  ./setup.sh                    # 기본 설치
  ./setup.sh --force            # 기존 설정 덮어쓰기
  ./setup.sh --dry-run          # 미리보기
  ./setup.sh --uninstall        # 제거
  ./setup.sh --minimal          # 최소 설치 (심볼릭 링크만)
  ./setup.sh --force --verbose  # 강제 설치 + 상세 로그

심볼릭 링크 매핑:
  dotfiles/claude/settings.json  →  ~/.claude/settings.json
  dotfiles/claude/CLAUDE.md      →  ~/.claude/CLAUDE.md
  dotfiles/claude/agents/        →  ~/.claude/agents/
  dotfiles/claude/commands/      →  ~/.claude/commands/
  dotfiles/claude/rules/         →  ~/.claude/rules/

주의사항:
  • claude.json은 심볼릭 링크되지 않습니다 (로컬 전용, 민감정보 포함)
  • --force 없이 실행 시 기존 설정이 있으면 오류 발생
  • --uninstall은 심볼릭 링크만 제거 (백업은 유지)

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -f|--force)
                FORCE_INSTALL=true
                shift
                ;;
            -n|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -u|--uninstall)
                UNINSTALL=true
                shift
                ;;
            -m|--minimal)
                MINIMAL=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            *)
                log_error "알 수 없는 옵션: $1"
                echo ""
                show_help
                exit 1
                ;;
        esac
    done
}

# ============================================================================
# 메인 실행 흐름
# ============================================================================

main() {
    # 1. 옵션 파싱 (배너 출력 전에 --help 체크)
    parse_args "$@"

    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║          Claude Code Configuration Setup                   ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""

    if [[ "$DRY_RUN" == true ]]; then
        log_warn "DRY-RUN 모드: 실제 변경 없이 미리보기만 수행합니다"
        echo ""
    fi

    # 2. 환경 감지
    detect_os
    detect_package_manager
    check_claude_cli || true

    # 3. Uninstall 모드
    if [[ "$UNINSTALL" == true ]]; then
        remove_symlinks
        echo ""
        exit 0
    fi

    # 4. 백업 (force 모드일 때)
    if [[ "$FORCE_INSTALL" == true ]]; then
        backup_existing
    fi

    # 5. 심볼릭 링크 생성
    create_symlinks

    # 6. 추가 설치 (minimal 모드가 아닐 때만)
    if [[ "$MINIMAL" == false ]]; then
        echo ""
        install_lsp
        echo ""
        install_plugins
    else
        echo ""
        log_info "Minimal 모드: LSP 및 플러그인 설치 건너뜀"
    fi

    # 7. 검증
    echo ""
    if [[ "$DRY_RUN" == false ]]; then
        verify_installation
    fi

    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                    Setup Complete!                         ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""

    if [[ "$DRY_RUN" == false ]]; then
        log_info "다음 단계:"
        echo "  1. Claude Code를 재시작하세요"
        echo "  2. '/oh-my-claudecode:omc-setup' 실행하여 추가 설정"
        echo ""
    fi
}

# 스크립트 실행
main "$@"
