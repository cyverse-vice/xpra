#!/bin/bash

echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_zone_name": "iplant"}' | tee  > /home/user/.irods/irods_environment.json

exec xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child="gnome-terminal"  --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --file-transfer=on --pulseaudio=no --notifications=no --bell=no :100
