#!/usr/bin/env bash

this_script_path="$( cd "$(dirname "$0")" ; pwd -P )"

# find all directories that could be grouping experiments
# (not log, retracked, or notes)
# TODO maybe use DATA_DIR? if set? should be consistent across all analysis
# tools...
data_dir=$HOME/data
most_recent_exp=$(ls -dt ${data_dir}/*/ | grep -Ev 'retracked|log|notes' | \
    head -n 1)

echo "most_recent_exp: ${most_recent_exp}"

# TODO why is first terminal not getting resized appropriately
gnome-terminal --working-directory=${most_recent_exp} --role=tracking -e \
"${this_script_path}/../../ubuntu_16.04/puttext_terminal \"roslaunch choice choice.launch video_only:=True\""
sleep 0.5
# sleep / wait for display?
xdotool keydown ctrl keydown super Left keyup ctrl keyup super

# may like to open my notes.txt here? (vi, but then less nice to other users)
# $EDITOR?
gnome-terminal --working-directory=${most_recent_exp} --role=notes -e \
"${this_script_path}/../../ubuntu_16.04/puttext_terminal \"vi notes.txt\""
sleep 0.5
xdotool keydown ctrl keydown super Right keyup ctrl keyup super

# -e "history -s \"roslaunch stimuli test_valves.launch\""
# -e "history -s \"vi notes.txt\""
# can't get this history setting to work..
# https://askubuntu.com/questions/5363/how-to-start-a-terminal-with-certain-text-already-input-on-the-command-line

# another workspace terminal for test_valves.launch? i mostly just like the
# recency in the history...

# another workspace w/ terminals for rsyncing data off? or just automate that?

