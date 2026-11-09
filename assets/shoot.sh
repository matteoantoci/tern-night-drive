#!/bin/sh
# Renders the README screenshots offscreen, with demo content: a headless `tern serve` window runs
# assets/screenshot.txt, and the PNGs land in assets/. Your own Tern windows do not change.
#
# A headless window loads no user themes, so the script loads Night Drive as a CSS patch. A theme's
# rules count as !important, so the patch is a copy of the theme with !important on every declaration.
set -eu

repo="$(cd "$(dirname "$0")/.." && pwd)"
work="$(mktemp -d)"
sock="$work/tern.sock"
trap 'tern ctl --control "$sock" quit >/dev/null 2>&1 || true; rm -rf "$work"' EXIT

sed -E 's/;[[:space:]]*$/ !important;/' "$repo/themes/night-drive.css" >"$work/night-drive.css"
sed "s|@THEME@|$work/night-drive.css|; s|@REPO@|$repo|g" "$repo/assets/screenshot.txt" >"$work/screenshot.txt"

tern serve --control "$sock" --out "$work/shots" >"$work/serve.log" 2>&1 &
for _ in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
	[ -S "$sock" ] && break
	sleep 0.3
done

tern ctl --control "$sock" --file "$work/screenshot.txt" >"$work/run.log"
cp "$work"/shots/serve/*.png "$repo/assets/"
ls "$repo"/assets/*.png
