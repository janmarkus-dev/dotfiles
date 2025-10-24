#!/bin/bash
choice=$(compgen -c | sort -u | wmenu)
[ -z "$choice" ] && exit 0
cmd_path=$(command -v "$choice")
[ -z "$cmd_path" ] && exit 1
desktop_file=$(grep -ril "Exec=.*${choice}" /usr/share/applications ~/.local/share/applications 2>/dev/null | head -n1)
if [ -n "$desktop_file" ]; then
    if grep -q "Terminal=false" "$desktop_file"; then
        nohup "$choice" >/dev/null 2>&1 &
        exit 0
    fi
fi
foot sh -c "$choice; exec $SHELL"
