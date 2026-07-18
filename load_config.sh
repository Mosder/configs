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

make_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        return 1
    fi
    echo "mkdir -p $dir"
    if ! mkdir -p "$dir" 2>/dev/null; then
        echo "Failed - using sudo..."
        sudo mkdir -p "$dir"
    fi
}

copy_file() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ]; then
        if diff "$src" "$dest" &> /dev/null; then
            return 1
        else
            echo "Updating $dest..."
        fi
    else
        echo "$dest doesn't exist - copying..."
    fi

    if ! cp -a "$src" "$dest" 2>/dev/null; then
        echo "Failed - using sudo..."
        sudo cp -a "$src" "$dest"
    fi
}

copy_to_disk() {
    local root="$1"
    cd "$root"

    find . -mindepth 1 | while read -r node; do
        # ./node -> /node
        dest="${node#.}"

        if [[ -d "$node" ]]; then
            make_dir "$dest"
        else
            make_dir "$(dirname "$dest")"
            copy_file "$node" "$dest"
        fi
    done
}

copy_to_disk "$SCRIPT_DIR/common"
copy_to_disk "$SCRIPT_DIR/$TARGET"

cd "$SCRIPT_DIR"
echo "Done."
