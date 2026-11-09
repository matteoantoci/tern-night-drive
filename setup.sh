#!/usr/bin/env bash
# Night Drive setup for Tern: links the theme and applies the window settings.
# Safe to run more than once. Run it inside a Tern pane, so that `tern ctl` finds the window.
set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
tern_dir="$HOME/Library/Application Support/Tern"
settings="$tern_dir/settings.json"

# 1. Theme: link the file, so edits in the repo reload live, and select it for light and dark.
mkdir -p "$tern_dir/themes"
ln -sf "$repo/themes/night-drive.css" "$tern_dir/themes/night-drive.css"
tern ctl theme night-drive

# 2. Window settings with ctl commands. Each sets a fixed value, except status_bar,
#    which is a toggle and so runs only when the status line is off.
tern ctl style islands
tern ctl padding 14
[ "$(tern ctl state | jq .status_bar)" = true ] || tern ctl plugins run status_bar

# 3. Cursor: no ctl command exists. A blinking block (blink is Tern's default, so no key).
#    Tern reads this change after `tern restart`.
tmp="$(mktemp)"
jq '.cursor = ((.cursor // {}) + {shape: "block"} | del(.blink))' "$settings" >"$tmp"
mv "$tmp" "$settings"

echo "Night Drive is set. Run 'tern restart' if the cursor is not a blinking block."
