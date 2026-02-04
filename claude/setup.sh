#!/bin/bash
set -e

DOTFILES_CLAUDE="$HOME/dotfiles/claude"

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          Claude Code Configuration Setup                   ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

echo "[0/6] Creating symlinks..."
mkdir -p "$HOME/.claude"

ln -sf "$DOTFILES_CLAUDE/claude.json" "$HOME/.claude.json"
echo "  → ~/.claude.json"

ln -sf "$DOTFILES_CLAUDE/settings.json" "$HOME/.claude/settings.json"
echo "  → ~/.claude/settings.json"

ln -sf "$DOTFILES_CLAUDE/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
echo "  → ~/.claude/CLAUDE.md"

ln -sf "$DOTFILES_CLAUDE/agents" "$HOME/.claude/agents"
echo "  → ~/.claude/agents"

ln -sf "$DOTFILES_CLAUDE/commands" "$HOME/.claude/commands"
echo "  → ~/.claude/commands"

rm -rf "$HOME/.claude/rules"
ln -sf "$DOTFILES_CLAUDE/rules" "$HOME/.claude/rules"
echo "  → ~/.claude/rules"

echo ""
echo "[1/6] Adding marketplaces..."
claude plugin marketplace add https://github.com/anthropics/claude-plugins-official 2>/dev/null || true
claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode 2>/dev/null || true
claude plugin marketplace add https://github.com/affaan-m/everything-claude-code 2>/dev/null || true

echo ""
echo "[2/6] Installing oh-my-claudecode..."
claude plugin install oh-my-claudecode@omc 2>/dev/null || true

echo ""
echo "[3/6] Installing everything-claude-code..."
claude plugin install everything-claude-code@everything-claude-code 2>/dev/null || true

# Rules are now symlinked from dotfiles/claude/rules (Korean version)

echo ""
echo "[4/6] Installing core plugins..."
claude plugin install typescript-lsp@claude-plugins-official 2>/dev/null || true
claude plugin install code-review@claude-plugins-official 2>/dev/null || true
claude plugin install explanatory-output-style@claude-plugins-official 2>/dev/null || true
claude plugin install learning-output-style@claude-plugins-official 2>/dev/null || true
claude plugin install commit-commands@claude-plugins-official 2>/dev/null || true
claude plugin install security-guidance@claude-plugins-official 2>/dev/null || true

echo ""
echo "[5/6] Installing workflow plugins..."
claude plugin install feature-dev@claude-plugins-official 2>/dev/null || true
claude plugin install pr-review-toolkit@claude-plugins-official 2>/dev/null || true

echo ""
echo "[6/6] Installing MCP plugins..."
claude plugin install context7@claude-plugins-official 2>/dev/null || true
claude plugin install playwright@claude-plugins-official 2>/dev/null || true
claude plugin install github@claude-plugins-official 2>/dev/null || true

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                    Setup Complete!                         ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
claude plugin list
echo ""
echo "Next: Run '/oh-my-claudecode:omc-setup' inside Claude Code"
echo ""
echo "Optional:"
echo "  claude plugin install pyright-lsp@claude-plugins-official"
echo "  claude plugin install slack@claude-plugins-official"
echo "  claude plugin install linear@claude-plugins-official"
