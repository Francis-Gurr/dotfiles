#!/bin/sh
# Firefox UI prefs that Sync doesn't cover (toolbar layout, pinned add-ons, sidebar side).
# Deployed as user.js in the default profile and re-applied at every Firefox start, so THIS
# file is the source of truth (rearrange in Firefox and it reverts on restart unless updated here).
#
# To update after rearranging in Firefox, grab the new values and paste them below, then
# `chezmoi apply`:
#   grep -E 'browser\.uiCustomization\.state|^user_pref\("sidebar\.' \
#     ~/.config/mozilla/firefox/*.default*/prefs.js
set -eu

# Find the default profile (Fedora XDG / Debian / macOS).
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
[ -n "${profile:-}" ] || { echo "firefox: no profile yet — launch Firefox once, then: chezmoi apply"; exit 0; }

cat > "$profile/user.js" <<'PREFS'
// Managed by chezmoi. Firefox UI settings that Sync doesn't cover.
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"ublock0_raymondhill_net-browser-action\",\"_5caff8cc-3d2e-4110-a88a-003cc85b3858_-browser-action\",\"_6ac85730-7d0f-4de0-b3fa-21142dd85326_-browser-action\",\"jid1-zadieub7xozojw_jetpack-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"bookmarks-menu-button\",\"customizableui-special-spring2\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"nordvpnproxy_nordvpn_com-browser-action\",\"unified-extensions-button\",\"sidebar-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"ipprotection-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_5caff8cc-3d2e-4110-a88a-003cc85b3858_-browser-action\",\"_6ac85730-7d0f-4de0-b3fa-21142dd85326_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"jid1-zadieub7xozojw_jetpack-browser-action\",\"nordvpnproxy_nordvpn_com-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"widget-overflow-fixed-list\"],\"currentVersion\":23,\"newElementCount\":5}");
user_pref("sidebar.position_start", false);
user_pref("sidebar.revamp", true);
user_pref("sidebar.revamp.defaultLauncherVisible", false);
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("sidebar.main.tools", "aichat,syncedtabs,history,bookmarks,{446900e4-71c2-419f-a6a7-df9c091e268b}");
PREFS
echo "firefox: applied UI prefs -> $profile/user.js"
