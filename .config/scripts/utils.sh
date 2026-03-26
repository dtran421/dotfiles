#!/usr/bin/env bash

# ── Colors ──────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ── Logging ─────────────────────────────────────────────────────────────
log_header() {
	printf "\n${BOLD}${MAGENTA}%s${RESET}\n" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	printf "${BOLD}${MAGENTA}  🚀 %s${RESET}\n" "$1"
	printf "${BOLD}${MAGENTA}%s${RESET}\n\n" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

log_section() {
	printf "\n${BOLD}${CYAN}  📦 %s${RESET}\n" "$1"
	printf "${DIM}${CYAN}  %s${RESET}\n" "──────────────────────────────────────"
}

log_info() {
	printf "${BLUE}  ℹ️  %s${RESET}\n" "$1"
}

log_success() {
	printf "${GREEN}  ✅ %s${RESET}\n" "$1"
}

log_warn() {
	printf "${YELLOW}  ⚠️  %s${RESET}\n" "$1"
}

log_error() {
	printf "${RED}  ❌ %s${RESET}\n" "$1"
}

log_step() {
	printf "${DIM}  ➜  %s${RESET}\n" "$1"
}

log_skip() {
	printf "${DIM}  ⏭️  %s (already installed)${RESET}\n" "$1"
}

# ── Helpers ─────────────────────────────────────────────────────────────
OS_NAME=$(uname -s)

is_macos() { [[ "$OS_NAME" == "Darwin" ]]; }
is_linux() { [[ "$OS_NAME" == "Linux" ]]; }

command_exists() { command -v "$1" &>/dev/null; }

clone_if_missing() {
	local repo="$1" dest="$2"
	if [[ -d "$dest" ]]; then
		log_skip "$(basename "$dest")"
	else
		log_step "Cloning $(basename "$dest")"
		git clone "$repo" "$dest"
	fi
}
