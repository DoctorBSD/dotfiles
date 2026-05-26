#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_DESKTOP=niri
export GTK_USE_PORTAL=1
export QT_USE_PORTAL=1
export QT_QPA_PLATFORMTHEME=gtk3
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1

exec dbus-run-session niri --session
