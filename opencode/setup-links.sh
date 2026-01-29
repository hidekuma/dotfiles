#!/bin/bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_DIR="$HOME/dotfiles"
OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
CLAUDE_CONFIG_DIR="$HOME/.claude"

print_header() {
    echo -e "\n${BLUE}==>${NC} ${GREEN}$1${NC}"
}

print_info() {
    echo -e "  ${BLUE}→${NC} $1"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "  ${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "  ${RED}✗${NC} $1"
}

create_symlink() {
    local source=$1
    local target=$2
    
    if [ -L "$target" ]; then
        local current_link=$(readlink "$target")
        if [ "$current_link" = "$source" ]; then
            print_info "이미 존재: $target -> $source"
            return 0
        else
            print_warning "다른 링크 존재: $target -> $current_link"
            read -p "    덮어쓰시겠습니까? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$target"
                print_info "기존 링크 제거됨"
            else
                print_info "건너뜀"
                return 1
            fi
        fi
    fi
    
    if [ -e "$target" ]; then
        print_warning "실제 파일/디렉토리 존재: $target"
        read -p "    백업 후 링크를 생성하시겠습니까? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            local backup="${target}.backup.$(date +%Y%m%d-%H%M%S)"
            mv "$target" "$backup"
            print_info "백업 생성: $backup"
        else
            print_info "건너뜀"
            return 1
        fi
    fi
    
    ln -s "$source" "$target"
    print_success "링크 생성: $target -> $source"
}

setup_opencode() {
    print_header "OpenCode 심볼릭 링크 설정"
    
    if [ ! -d "$DOTFILES_DIR/opencode" ]; then
        print_error "dotfiles/opencode 디렉토리가 존재하지 않습니다: $DOTFILES_DIR/opencode"
        exit 1
    fi
    
    if [ ! -d "$OPENCODE_CONFIG_DIR" ]; then
        print_info "OpenCode 설정 디렉토리 생성: $OPENCODE_CONFIG_DIR"
        mkdir -p "$OPENCODE_CONFIG_DIR"
    fi
    
    print_info ""
    print_info "rules/ 디렉토리 링크 생성 중..."
    create_symlink "$DOTFILES_DIR/opencode/rules" "$OPENCODE_CONFIG_DIR/rules"
    
    print_info ""
    print_info "commands/ 디렉토리 링크 생성 중..."
    create_symlink "$DOTFILES_DIR/opencode/commands" "$OPENCODE_CONFIG_DIR/commands"
    
    if [ ! -d "$OPENCODE_CONFIG_DIR/memory" ]; then
        print_info ""
        print_info "memory/ 디렉토리 생성 중... (로컬 전용)"
        mkdir -p "$OPENCODE_CONFIG_DIR/memory"
        print_success "memory/ 디렉토리 생성됨"
    else
        print_info ""
        print_info "memory/ 디렉토리 이미 존재"
    fi
}

setup_claude() {
    print_header "Claude 심볼릭 링크 설정"
    
    if [ ! -d "$DOTFILES_DIR/opencode" ]; then
        print_error "dotfiles/opencode 디렉토리가 존재하지 않습니다: $DOTFILES_DIR/opencode"
        exit 1
    fi
    
    if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
        print_info "Claude 설정 디렉토리 생성: $CLAUDE_CONFIG_DIR"
        mkdir -p "$CLAUDE_CONFIG_DIR"
    fi
    
    print_info ""
    print_info "rules/ 디렉토리 링크 생성 중..."
    create_symlink "$DOTFILES_DIR/opencode/rules" "$CLAUDE_CONFIG_DIR/rules"
    
    print_info ""
    print_info "commands/ 디렉토리 링크 생성 중..."
    create_symlink "$DOTFILES_DIR/opencode/commands" "$CLAUDE_CONFIG_DIR/commands"
}

verify_links() {
    print_header "심볼릭 링크 검증"
    
    local all_ok=true
    
    if [ "$SETUP_OPENCODE" = true ]; then
        if [ -L "$OPENCODE_CONFIG_DIR/rules" ] && [ -e "$OPENCODE_CONFIG_DIR/rules" ]; then
            print_success "OpenCode rules: $(readlink "$OPENCODE_CONFIG_DIR/rules")"
        else
            print_error "OpenCode rules 링크 실패"
            all_ok=false
        fi
        
        if [ -L "$OPENCODE_CONFIG_DIR/commands" ] && [ -e "$OPENCODE_CONFIG_DIR/commands" ]; then
            print_success "OpenCode commands: $(readlink "$OPENCODE_CONFIG_DIR/commands")"
        else
            print_error "OpenCode commands 링크 실패"
            all_ok=false
        fi
        
        if [ -d "$OPENCODE_CONFIG_DIR/memory" ]; then
            print_success "OpenCode memory: 디렉토리 존재"
        else
            print_error "OpenCode memory 디렉토리 없음"
            all_ok=false
        fi
    fi
    
    if [ "$SETUP_CLAUDE" = true ]; then
        if [ -L "$CLAUDE_CONFIG_DIR/rules" ] && [ -e "$CLAUDE_CONFIG_DIR/rules" ]; then
            print_success "Claude rules: $(readlink "$CLAUDE_CONFIG_DIR/rules")"
        else
            print_error "Claude rules 링크 실패"
            all_ok=false
        fi
        
        if [ -L "$CLAUDE_CONFIG_DIR/commands" ] && [ -e "$CLAUDE_CONFIG_DIR/commands" ]; then
            print_success "Claude commands: $(readlink "$CLAUDE_CONFIG_DIR/commands")"
        else
            print_error "Claude commands 링크 실패"
            all_ok=false
        fi
    fi
    
    echo ""
    if [ "$all_ok" = true ]; then
        print_success "모든 심볼릭 링크가 정상적으로 생성되었습니다! ✨"
    else
        print_error "일부 심볼릭 링크 생성에 실패했습니다."
        exit 1
    fi
}

print_usage() {
    echo "사용법: $0 [옵션]"
    echo ""
    echo "옵션:"
    echo "  --opencode    OpenCode 심볼릭 링크만 설정"
    echo "  --claude      Claude Code 심볼릭 링크만 설정"
    echo "  --both        OpenCode와 Claude 모두 설정 (기본값)"
    echo "  --help        이 도움말 출력"
    echo ""
    echo "예시:"
    echo "  $0                  # OpenCode와 Claude 모두 설정"
    echo "  $0 --opencode       # OpenCode만 설정"
    echo "  $0 --claude         # Claude만 설정"
    echo "  $0 --both           # 명시적으로 둘 다 설정"
}

interactive_select() {
    echo ""
    echo -e "${GREEN}어떤 AI를 설정하시겠습니까?${NC}"
    echo ""
    echo "  1) OpenCode만"
    echo "  2) Claude만"
    echo "  3) 둘 다"
    echo "  4) 취소"
    echo ""
    read -p "선택 (1-4): " -n 1 -r
    echo ""
    
    case $REPLY in
        1)
            SETUP_OPENCODE=true
            SETUP_CLAUDE=false
            ;;
        2)
            SETUP_OPENCODE=false
            SETUP_CLAUDE=true
            ;;
        3)
            SETUP_OPENCODE=true
            SETUP_CLAUDE=true
            ;;
        4)
            echo "취소되었습니다."
            exit 0
            ;;
        *)
            print_error "잘못된 선택입니다."
            exit 1
            ;;
    esac
}

main() {
    SETUP_OPENCODE=false
    SETUP_CLAUDE=false
    INTERACTIVE=false
    
    if [ $# -eq 0 ]; then
        INTERACTIVE=true
    fi
    
    for arg in "$@"; do
        case $arg in
            --opencode)
                SETUP_OPENCODE=true
                shift
                ;;
            --claude)
                SETUP_CLAUDE=true
                shift
                ;;
            --both)
                SETUP_OPENCODE=true
                SETUP_CLAUDE=true
                shift
                ;;
            --help)
                print_usage
                exit 0
                ;;
            *)
                print_error "알 수 없는 옵션: $arg"
                print_usage
                exit 1
                ;;
        esac
    done
    
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  AI 설정 심볼릭 링크 설치 스크립트    ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    
    if [ "$INTERACTIVE" = true ]; then
        interactive_select
    fi
    
    if [ "$SETUP_OPENCODE" = false ] && [ "$SETUP_CLAUDE" = false ]; then
        print_error "설정할 AI를 선택해야 합니다."
        print_usage
        exit 1
    fi
    
    if [ ! -d "$DOTFILES_DIR" ]; then
        print_error "dotfiles 디렉토리를 찾을 수 없습니다: $DOTFILES_DIR"
        exit 1
    fi
    
    if [ "$SETUP_OPENCODE" = true ]; then
        setup_opencode
        echo ""
    fi
    
    if [ "$SETUP_CLAUDE" = true ]; then
        setup_claude
        echo ""
    fi
    
    verify_links
    
    print_header "설치 완료!"
    echo ""
    print_info "다음 명령어로 링크를 확인할 수 있습니다:"
    if [ "$SETUP_OPENCODE" = true ]; then
        echo -e "    ${BLUE}ls -la ~/.config/opencode/${NC}"
    fi
    if [ "$SETUP_CLAUDE" = true ]; then
        echo -e "    ${BLUE}ls -la ~/.claude/${NC}"
    fi
    echo ""
}

main "$@"
