#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false

# Parse flags
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    -h|--help)
      echo "Usage: ./install.sh [--force]"
      echo ""
      echo "Symlinks global skills and tools into place."
      echo ""
      echo "  --force    Replace existing files/symlinks (default: skip existing)"
      echo ""
      echo "Project-specific skills are NOT auto-installed."
      echo "See the printed instructions after running this script."
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      exit 1
      ;;
  esac
done

# Counters
linked=0
skipped=0
replaced=0

install_symlink() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$FORCE" = true ]; then
      rm -f "$dest"
      ln -s "$src" "$dest"
      echo "  replaced: $dest -> $src"
      ((replaced++))
    else
      echo "  skipped:  $dest (already exists)"
      ((skipped++))
    fi
  else
    ln -s "$src" "$dest"
    echo "  linked:   $dest -> $src"
    ((linked++))
  fi
}

# --- Global Skills ---
echo ""
echo "=== Global Skills (-> ~/.claude/commands/) ==="
mkdir -p "$HOME/.claude/commands"

for file in "$SCRIPT_DIR"/global/*.md; do
  [ -f "$file" ] || continue
  name="$(basename "$file")"
  install_symlink "$file" "$HOME/.claude/commands/$name"
done

# --- Tools ---
echo ""
echo "=== Tools (-> ~/.local/bin/) ==="
mkdir -p "$HOME/.local/bin"

for file in "$SCRIPT_DIR"/tools/*; do
  [ -f "$file" ] || continue
  name="$(basename "$file")"
  chmod +x "$file"
  install_symlink "$file" "$HOME/.local/bin/$name"
done

# --- Summary ---
echo ""
echo "=== Summary ==="
echo "  Linked:   $linked"
echo "  Skipped:  $skipped"
echo "  Replaced: $replaced"

# --- Project Skills Instructions ---
echo ""
echo "=== Project-Specific Skills ==="
echo ""
echo "Project skills are NOT auto-installed. To install them for a project,"
echo "symlink the files from projects/<name>/ into <project>/.claude/commands/."
echo ""
echo "Available projects:"

for project_dir in "$SCRIPT_DIR"/projects/*/; do
  [ -d "$project_dir" ] || continue
  project_name="$(basename "$project_dir")"
  echo ""
  echo "  $project_name:"
  for file in "$project_dir"*.md; do
    [ -f "$file" ] || continue
    name="$(basename "$file")"
    echo "    ln -sf \"$file\" \"<project-root>/.claude/commands/$name\""
  done
done

echo ""
echo "Done."
