import QtQuick

// Hyprland bindings are loaded by hyprland.lua. The service entry point keeps
// this directory a valid Omarchy plugin without duplicating compositor state.
Item {
    property var shell: null
}
