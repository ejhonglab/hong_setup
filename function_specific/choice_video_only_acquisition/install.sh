#!/usr/bin/env bash

cp tom_tracking_terminals.desktop ~/.local/share/applications

# TODO also position at bottom?
# TODO make idempotent
app='tom_tracking_terminals.desktop'
existing_launcher_apps=`gsettings get com.canonical.Unity.Launcher favorites`
new_launcher_apps=`echo $existing_launcher_apps | sed s/]/", '${app}']"/`
gsettings set com.canonical.Unity.Launcher favorites "$new_launcher_apps"

# TODO provide uninstall

