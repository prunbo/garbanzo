# Architecture

## Hyprland
Modular config in `hypr/`. `hyprland.conf` sources all modules. Layer-shell tuning in `quickshell/hyprland-layer-config.conf`.

## Quickshell
Entry point `shell.qml` (ShellRoot). Modules:
- `modules/bar/Bar.qml` - top bar (workspaces, clock, tray, audio, network, battery, notifications)
- `modules/dock/Dock.qml` - bottom dock with pinned apps
- `modules/launcher/Launcher.qml` - app grid launcher (IPC: launcher toggle)
- `modules/notifications/Notifications.qml` - toast + center (IPC: notifications toggle)
- `modules/osd/Osd.qml` - volume/brightness OSD (IPC: osd volume/brightness)

Services (singletons): Clock, Workspaces, Audio, Network, Battery.

Config (singletons): Theme (ZZZ palette), Config (user settings).

## IPC
Quickshell IPC targets: `launcher`, `notifications`, `osd`, `clipboard` (optional). Trigger via `qs -c garbanzo ipc call <target> <function>`.