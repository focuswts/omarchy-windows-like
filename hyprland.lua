-- Windows-like compositor behavior for the focuswts Omarchy setup.

local windows_like = {}

-- The visual switcher already handles all workspaces, hidden minimized windows,
-- and activation on modifier release. Keep the compositor action paired with it
-- so the chosen client is also raised in the stacking order.
hl.unbind("ALT + TAB")
o.bind("ALT + TAB", "Alt-Tab switcher", hl.dsp.global("omarchy-alttab:next"), { repeating = true })
o.bind("ALT + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())

hl.unbind("SUPER + TAB")
o.bind("SUPER + TAB", "Alt-Tab switcher", hl.dsp.global("omarchy-alttab:next"), { repeating = true })

-- Windows-like maximize / restore and always-on-top.
hl.unbind("SUPER + UP")
o.bind("SUPER + UP", "Maximize window", hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.unbind("SUPER + DOWN")
o.bind("SUPER + DOWN", "Restore or minimize window", os.getenv("HOME") .. "/.config/omarchy/plugins/focuswts.windows-like/bin/windows-like down")

hl.unbind("SUPER + SHIFT + T")
o.bind("SUPER + SHIFT + T", "Toggle always on top", hl.dsp.window.pin())

-- Keep directional focus on the Windows keys. Floating Window Mode's native
-- snap integration remains responsible for mouse edge/corner snap previews.
hl.unbind("SUPER + LEFT")
o.bind("SUPER + LEFT", "Focus window on the left", hl.dsp.focus({ direction = "l" }))
hl.unbind("SUPER + RIGHT")
o.bind("SUPER + RIGHT", "Focus window on the right", hl.dsp.focus({ direction = "r" }))

-- Workspace navigation follows Windows virtual-desktop conventions.
hl.unbind("SUPER + CTRL + LEFT")
o.bind("SUPER + CTRL + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
hl.unbind("SUPER + CTRL + RIGHT")
o.bind("SUPER + CTRL + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
hl.unbind("SUPER + CTRL + D")
o.bind("SUPER + CTRL + D", "Create workspace", hl.dsp.focus({ workspace = "e+1" }))

-- Hyprland removes an empty dynamic workspace naturally after its windows are
-- moved away; this shortcut moves the active window to the previous workspace,
-- which is the safe equivalent of closing the current virtual desktop.
o.bind("SUPER + CTRL + F4", "Leave workspace", os.getenv("HOME") .. "/.config/omarchy/plugins/focuswts.windows-like/bin/windows-like leave-workspace")

-- Enable the Aero-style drag zones exposed by Floating Window Mode.
hl.config({
  plugin = {
    omarchy_windows_snap = {
      enabled = true,
      floating_mode_only = true,
    },
  },
})

return windows_like
