#!/usr/bin/env bash

# Clear the Dock
dockutil --remove all

# Add apps in Dock
dockutil --add /Applications/Firefox.app --position 1
dockutil --add /Applications/Calendar.app --position 2
dockutil --add /Applications/Things.app --position 3
dockutil --add /Applications/Obsidian.app --position 4

# Add folders in Dock
dockutil --add '~/Documents/Inbox' --view grid --display stack --sort dateadded
dockutil --add '~/Documents/Referentie' --view list --display stack --sort name