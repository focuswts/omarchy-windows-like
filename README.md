# Windows-like Window Experience

Omarchy plugin that makes floating-mode window management behave more like
Windows while preserving Hyprland's workspaces.

## Behaviors

- `Alt+Tab` and `Win+Tab`: visual task switcher across workspaces;
- selected windows are raised above normal windows;
- `Win+↑`: maximize;
- `Win+↓`: restore the maximized window or minimize the active window;
- `Win+←/→`: focus the neighboring window;
- `Ctrl+Win+←/→`: move between workspaces;
- `Ctrl+Win+D`: create/focus the next workspace;
- `Ctrl+Win+F4`: leave the current workspace;
- `Win+Shift+T`: toggle always-on-top;
- Aero-style drag zones are enabled through the installed Floating Window Mode
  integration.

The plugin intentionally uses `Win+Tab` for the same task switcher as `Alt+Tab`.
The workspace navigation shortcuts remain separate from task switching.

## Installation

Install with Omarchy:

```sh
omarchy plugin add https://github.com/focuswts/omarchy-windows-like.git --enable
```

Then load the Hyprland module from `~/.config/hypr/hyprland.lua`:

```lua
dofile(os.getenv("HOME") .. "/.config/omarchy/plugins/focuswts.windows-like/hyprland.lua")
```

The plugin expects Omarchy Quattro, Hyprland 0.56 or newer, `jq`, and the
Floating Window Mode snap integration for Aero drag previews. The Alt+Tab
switcher is provided by Omarchy's `vbrosseau.alttab` plugin.

## Removal

Remove the loader line from `~/.config/hypr/hyprland.lua`, then disable and
remove the plugin:

```sh
omarchy plugin disable focuswts.windows-like
omarchy plugin remove focuswts.windows-like --yes
```

Reload Hyprland afterward with `hyprctl reload`.

After restoring or changing the plugin:

```sh
omarchy restart shell
hyprctl reload
hyprctl configerrors
```
