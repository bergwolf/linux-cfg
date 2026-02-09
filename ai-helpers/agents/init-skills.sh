#!/usr/bin/env bash
# init-skills.sh — Initialize ~/.agents/skills and symlink into ~/.claude/skills/
#
# Skills come from two sources:
#   1. anthropics/skills repo (cloned/pulled into ~/.agents/skills/anthropics/)
#   2. skills.sh ecosystem repos (installed via `npx skills add`)
#
# ~/.claude/skills/ entries are symlinks pointing to ~/.agents/skills/ so
# there is a single source of truth.
#
# Usage:
#   ./init-skills.sh                     # install defaults
#   ./init-skills.sh --list              # show what would be installed
#   ./init-skills.sh --skip-anthropic    # skip the anthropics/skills clone
#   ./init-skills.sh --skip-community    # skip npx skills repos
#   ./init-skills.sh --repos "owner/repo1 owner/repo2"  # override community repos

set -euo pipefail

# ── Configurable list of community skills repos (owner/repo) ─────────────
# Edit this array or override with --repos "..."
DEFAULT_REPOS=(
  # Official / major
  "anthropics/skills"
  "vercel-labs/agent-skills"

  # Accessibility & quality
  "KreerC/ACCESSIBILITY.md"

  # Development workflows
  "netresearch/agents-skill"
  "michaelboeding/skills"
  "strativd/ai-skills"
  "goldsky-io/agent-skills"
)

# ── Directories ──────────────────────────────────────────────────────────
AGENT_SKILLS_DIR="$HOME/.agents/skills"
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
ANTHROPIC_CLONE_DIR="$AGENT_SKILLS_DIR/anthropics"

# ── Flags ────────────────────────────────────────────────────────────────
SKIP_ANTHROPIC=false
SKIP_COMMUNITY=false
LIST_ONLY=false
REPOS=("${DEFAULT_REPOS[@]}")

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Initialize ~/.agents/skills and symlink into ~/.claude/skills/.

Options:
  --list              Show what would be installed, then exit
  --skip-anthropic    Skip cloning anthropics/skills
  --skip-community    Skip installing community skills via npx
  --repos "r1 r2 .."  Override the default community repos list
  -h, --help          Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list)         LIST_ONLY=true; shift ;;
    --skip-anthropic) SKIP_ANTHROPIC=true; shift ;;
    --skip-community) SKIP_COMMUNITY=true; shift ;;
    --repos)
      shift
      IFS=' ' read -ra REPOS <<< "$1"
      shift
      ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

# ── List mode ────────────────────────────────────────────────────────────
if $LIST_ONLY; then
  echo "=== Anthropic official skills (cloned to $ANTHROPIC_CLONE_DIR) ==="
  echo "  https://github.com/anthropics/skills/tree/main/skills"
  echo ""
  echo "=== Community skills repos (via npx skills add) ==="
  for repo in "${REPOS[@]}"; do
    echo "  $repo"
  done
  exit 0
fi

# ── Helpers ──────────────────────────────────────────────────────────────
log()  { printf '\033[1;34m>>>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m ✓ \033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m ⚠ \033[0m %s\n' "$*"; }
err()  { printf '\033[1;31m ✗ \033[0m %s\n' "$*" >&2; }

require_cmd() {
  if ! command -v "$1" &>/dev/null; then
    err "Required command not found: $1"
    exit 1
  fi
}

# ── Preflight ────────────────────────────────────────────────────────────
require_cmd git
if ! $SKIP_COMMUNITY; then
  require_cmd npx
fi

mkdir -p "$AGENT_SKILLS_DIR"
mkdir -p "$CLAUDE_SKILLS_DIR"

# ── 1. Anthropic official skills ─────────────────────────────────────────
if ! $SKIP_ANTHROPIC; then
  log "Setting up Anthropic official skills..."

  if [[ -d "$ANTHROPIC_CLONE_DIR/.git" ]]; then
    log "Updating existing clone at $ANTHROPIC_CLONE_DIR"
    git -C "$ANTHROPIC_CLONE_DIR" pull --ff-only --quiet 2>/dev/null || \
      warn "Pull failed (maybe offline); using existing checkout"
  else
    log "Cloning anthropics/skills → $ANTHROPIC_CLONE_DIR"
    rm -rf "$ANTHROPIC_CLONE_DIR"
    git clone --quiet --depth 1 https://github.com/anthropics/skills.git "$ANTHROPIC_CLONE_DIR"
  fi

  # Symlink each skill directory from the clone into ~/.agents/skills/<name>
  if [[ -d "$ANTHROPIC_CLONE_DIR/skills" ]]; then
    for skill_dir in "$ANTHROPIC_CLONE_DIR/skills"/*/; do
      skill_name="$(basename "$skill_dir")"
      target="$AGENT_SKILLS_DIR/$skill_name"
      if [[ -L "$target" ]]; then
        # Already a symlink — update if target differs
        current="$(readlink -f "$target")"
        canonical="$(readlink -f "$skill_dir")"
        if [[ "$current" != "$canonical" ]]; then
          ln -sfn "$skill_dir" "$target"
          ok "Updated symlink: $skill_name"
        fi
      elif [[ -e "$target" ]]; then
        warn "Skipping $skill_name — non-symlink already exists at $target"
      else
        ln -sfn "$skill_dir" "$target"
        ok "Linked: $skill_name"
      fi
    done
  fi

  ok "Anthropic skills ready"
fi

# ── 2. Community skills via npx skills add ───────────────────────────────
if ! $SKIP_COMMUNITY; then
  log "Installing community skills via npx skills add..."

  for repo in "${REPOS[@]}"; do
    log "Adding $repo..."
    if npx skills add "$repo" --global --agent claude-code --skill '*' --yes 2>&1; then
      ok "Installed: $repo"
    else
      warn "Failed to install: $repo (continuing)"
    fi
  done

  # Move any skills npx installed into ~/.claude/skills/ to ~/.agents/skills/
  # and replace with symlinks, so ~/.agents/skills/ is the canonical location.
  if [[ -d "$CLAUDE_SKILLS_DIR" ]]; then
    for item in "$CLAUDE_SKILLS_DIR"/*/; do
      [[ -d "$item" ]] || continue
      skill_name="$(basename "$item")"
      # Skip if it's already a symlink (pointing to ~/.agents/skills/)
      if [[ -L "$item" ]]; then
        continue
      fi
      agent_target="$AGENT_SKILLS_DIR/$skill_name"
      if [[ ! -e "$agent_target" ]]; then
        # Move the real directory to ~/.agents/skills/ and symlink back
        mv "$item" "$agent_target"
        ln -sfn "$agent_target" "$item"
        ok "Consolidated: $skill_name → $AGENT_SKILLS_DIR/"
      else
        warn "Skipping consolidation of $skill_name — already exists in $AGENT_SKILLS_DIR/"
      fi
    done
  fi

  ok "Community skills ready"
fi

# ── 3. Ensure ~/.claude/skills/ symlinks point to ~/.agents/skills/ ───────
log "Syncing symlinks in $CLAUDE_SKILLS_DIR..."

for skill_dir in "$AGENT_SKILLS_DIR"/*/; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"

  # Skip the anthropics clone directory itself
  [[ "$skill_name" == "anthropics" ]] && continue

  claude_link="$CLAUDE_SKILLS_DIR/$skill_name"
  if [[ -L "$claude_link" ]]; then
    current="$(readlink -f "$claude_link")"
    canonical="$(readlink -f "$skill_dir")"
    if [[ "$current" != "$canonical" ]]; then
      ln -sfn "$skill_dir" "$claude_link"
      ok "Updated claude symlink: $skill_name"
    fi
  elif [[ -e "$claude_link" ]]; then
    warn "Skipping $skill_name — non-symlink already exists at $claude_link"
  else
    ln -sfn "$skill_dir" "$claude_link"
    ok "Linked to claude: $skill_name"
  fi
done

# ── Summary ──────────────────────────────────────────────────────────────
echo ""
log "Done! Skills installed:"
echo ""
echo "  Canonical:  $AGENT_SKILLS_DIR/"
echo "  Claude:     $CLAUDE_SKILLS_DIR/ (symlinks)"
echo ""
agent_count=$(find "$AGENT_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type d -not -name anthropics 2>/dev/null | wc -l)
link_count=$(find "$AGENT_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type l 2>/dev/null | wc -l)
claude_count=$(find "$CLAUDE_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type l 2>/dev/null | wc -l)
echo "  Skills in ~/.agents/skills/:  $((agent_count + link_count))"
echo "  Symlinks in ~/.claude/skills/: $claude_count"
