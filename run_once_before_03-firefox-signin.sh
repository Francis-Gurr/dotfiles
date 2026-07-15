#!/bin/sh
# Sign in to Firefox Sync before GitHub auth (which opens a browser) — pulls down
# bookmarks/history/tabs/extensions first. No headless sign-in exists for Mozilla
# accounts (OAuth), so this opens the page and waits, unless already signed in.
# Passwords stay local (see the firefox prefs script); Bitwarden desktop (previous step)
# handles those.
set -eu

command -v firefox >/dev/null 2>&1 || { echo "firefox: not installed; skipping sync sign-in"; exit 0; }

for base in "${XDG_CONFIG_HOME:-$HOME/.config}/mozilla/firefox" \
            "$HOME/.mozilla/firefox" \
            "$HOME/Library/Application Support/Firefox"; do
	[ -f "$base/profiles.ini" ] || continue
	rel=$(awk -F= '/^\[Install/{i=1;next} /^\[/{i=0} i&&$1=="Default"{print $2;exit}' "$base/profiles.ini")
	if [ -z "$rel" ]; then
		d=$(ls -d "$base"/*.default-release 2>/dev/null | head -n1)
		[ -n "$d" ] && rel=$(basename "$d")
	fi
	[ -n "$rel" ] && { profile="$base/$rel"; break; }
done

if [ -n "${profile:-}" ] && [ -f "$profile/signedInUser.json" ]; then
	echo "firefox: already signed in to Sync"
	exit 0
fi

firefox about:preferences#sync >/dev/null 2>&1 &
printf 'firefox: sign in to Firefox Sync, then press Enter here to continue... '
read -r _ < /dev/tty || true
