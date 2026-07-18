#!/usr/bin/env bash

# Ensure good argument is passed
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 (desktop | laptop)"
    exit 1
elif [[ "$1" != "laptop" && "$1" != "desktop" ]]; then
    echo "Target must be \"laptop\" or \"desktop\""
    exit 1
fi

TARGET=$1
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_file() {
    local src="$1"
    local dest="$2"
    # update only if files are different
    if ! diff "$src" "$dest" &>/dev/null; then
        echo "Updating $dest..."
        if ! cp -a "$src" "$dest" 2>/dev/null; then
            echo "Failed - using sudo..."
            sudo cp -a "$src" "$dest"
        fi
    fi
}

update_repo() {
    local repo_dir="$1"
    cd "$repo_dir"

    find . -mindepth 1 | while read -r node; do
        # ./node -> /node
        src="${node#.}"

        if [[ -f "$src" ]]; then
            copy_file "$src" "$node"
        elif [[ ! -d "$src" ]]; then
            echo "Skipped missing: $src"
        fi
    done
}

update_repo "$SCRIPT_DIR/common"
update_repo "$SCRIPT_DIR/$TARGET"

cd "$SCRIPT_DIR"
echo "Done."
