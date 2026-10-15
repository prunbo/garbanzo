import QtQuick
import Quickshell
import "config" as Config
import "services" as Services
import "modules/bar" as BarModule
import "modules/dock" as DockModule
import "modules/launcher" as LauncherModule
import "modules/notifications" as NotificationsModule
import "modules/osd" as OsdModule

ShellRoot {
    // Force singletons to load
    property var _clock: Services.Clock
    property var _workspaces: Services.Workspaces
    property var _audio: Services.Audio
    property var _network: Services.Network
    property var _battery: Services.Battery

    BarModule.Bar {}
    DockModule.Dock {}
    LauncherModule.Launcher {}
    NotificationsModule.Notifications {}
    OsdModule.Osd {}
}