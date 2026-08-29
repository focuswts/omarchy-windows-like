#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
tmp="$(mktemp -d)"
trap 'rm -rf -- "$tmp"' EXIT

cat >"$tmp/hyprctl" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
case "${FAKE_SCENARIO:-}" in
  restore)
    [[ "$*" == "-j activewindow" ]] && printf '%s\n' '{"fullscreen":1}' && exit 0
    ;;
  minimize)
    [[ "$*" == "-j activewindow" ]] && printf '%s\n' '{"fullscreen":0}' && exit 0
    ;;
  normal-workspace)
    [[ "$*" == "-j activeworkspace" ]] && printf '%s\n' '{"id":1,"name":"1"}' && exit 0
    [[ "$*" == "-j clients" ]] && printf '%s\n' '[{"address":"0x1","workspace":{"id":1}},{"address":"0x2","workspace":{"id":1}},{"address":"0x9","workspace":{"id":2}}]' && exit 0
    ;;
  special-workspace)
    [[ "$*" == "-j activeworkspace" ]] && printf '%s\n' '{"id":-99,"name":"special:minimized"}' && exit 0
    ;;
esac
printf 'dispatch %s\n' "$*" >>"$FAKE_LOG"
EOF
chmod +x "$tmp/hyprctl"

run_case() {
  : >"$tmp/log"
  FAKE_SCENARIO="$1" FAKE_LOG="$tmp/log" PATH="$tmp:$PATH" "$root/bin/windows-like" "$2"
}

run_case restore down
grep -F -- 'dispatch dispatch fullscreen 0' "$tmp/log"

run_case minimize down
grep -F -- 'dispatch dispatch movetoworkspacesilent special:minimized' "$tmp/log"

run_case normal-workspace leave-workspace
grep -F -- 'dispatch dispatch movetoworkspacesilent e-1,address:0x1' "$tmp/log"
grep -F -- 'dispatch dispatch movetoworkspacesilent e-1,address:0x2' "$tmp/log"
grep -F -- 'dispatch dispatch workspace e-1' "$tmp/log"

run_case special-workspace leave-workspace
[[ ! -s "$tmp/log" ]]

echo 'windows-like command tests: OK'
