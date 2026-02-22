#!/bin/bash
# ========================================
# Shared scripts config (~/.s/)
# Source this from other s_ scripts
# ========================================

# ============ Paths ============
S_LOG_DIR="$HOME/.s_logs"

# ============ Functions ============
s_ensure_dir() {
    mkdir -p "$1"
}
