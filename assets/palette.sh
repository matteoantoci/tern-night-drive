#!/bin/sh
# Prints the 16 ANSI colors of the active theme and a short build log in the state colors, as the README
# screenshot shows them.
e=$(printf '\033')
names="black red green yellow blue magenta cyan white"

printf '\n  %s[1;35mnight%s[0m %s[1;36mdrive%s[0m  %s[2m· the 16 ANSI colors%s[0m\n\n' "$e" "$e" "$e" "$e" "$e" "$e"

i=0
for name in $names; do
	# Black text is not visible on the dark background, so its label uses bright black.
	label=3$i
	[ "$i" -eq 0 ] && label=90
	printf '  %s[4%sm      %s[0m  %s[10%sm      %s[0m  %s[%sm%-8s%s[0m %s[9%sm%s%s[0m\n' \
		"$e" "$i" "$e" "$e" "$i" "$e" "$e" "$label" "$name" "$e" "$e" "$i" "bright" "$e"
	i=$((i + 1))
done

printf '\n  %s[2m── build ──────────────────────────%s[0m\n\n' "$e" "$e"
printf '  %s[32m✓%s[0m compiled  %s[2mthemes/night-drive.css%s[0m\n' "$e" "$e" "$e" "$e"
printf '  %s[32m✓%s[0m 25 rules   %s[2min 4 ms%s[0m\n' "$e" "$e" "$e" "$e"
printf '  %s[33m!%s[0m 1 warning  %s[2mcontrast 3.9:1 on --ansi8%s[0m\n' "$e" "$e" "$e" "$e"
printf '  %s[31m✗%s[0m 0 errors\n' "$e" "$e"
printf '  %s[36m→%s[0m watching for changes%s[5m…%s[0m\n\n' "$e" "$e" "$e" "$e"
