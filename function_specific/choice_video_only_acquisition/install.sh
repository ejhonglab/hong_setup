#!/usr/bin/env bash

cp tom_tracking_terminals.desktop ~/.local/share/applications

# TODO also position at bottom?
app="tom_tracking_terminals.desktop"
existing_launcher_apps=`gsettings get com.canonical.Unity.Launcher favorites`

# checking if app is in existing_launcher_apps
if [[ ! $existing_launcher_apps = *"${app}"* ]]; then
    echo "Adding icon to launcher..."
    new_launcher_apps=`echo $existing_launcher_apps | sed s/]/", '${app}']"/`
    gsettings set com.canonical.Unity.Launcher favorites "$new_launcher_apps"
fi

# TODO provide uninstall

