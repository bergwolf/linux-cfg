# !/bin/bash

# catch any errors
set -e

echo "Installing azure-ai-inference dependency..."
pip3 install azure-ai-inference > /dev/null

# Install the git hooks
HOOKS_DIR=$(dirname "$0")
HOOKS_DEST_DIR=$(git rev-parse --git-dir)/hooks

mkdir -p "$HOOKS_DEST_DIR"

# copy all hooks except the install script itself
find "$HOOKS_DIR" -maxdepth 1 -type f ! -name 'install.sh' -exec cp {} "$HOOKS_DEST_DIR" \;
chmod +x "$HOOKS_DEST_DIR"/*

echo "Git hooks have been installed in $HOOKS_DEST_DIR"
