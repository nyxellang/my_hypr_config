set -x fish_greeting ""
function venv
    source ~/python-global-venv/bin/activate.fish
end
if status is-interactive
    echo ' /$$   /$$  /$$$$$$  /$$$$$$$$ /$$      /$$ /$$$$$$$$'
    echo '| $$$ | $$ /$$__  $$|__  $$__/| $$$    /$$$| $$_____/'
    echo '| $$$$| $$| $$  \ $$   | $$   | $$$$  /$$$$| $$      '
    echo '| $$ $$ $$| $$  | $$   | $$   | $$ $$/$$ $$| $$$$$   '
    echo '| $$  $$$$| $$  | $$   | $$   | $$  $$$| $$| $$__/   '
    echo '| $$\  $$$| $$  | $$   | $$   | $$\  $ | $$| $$'
    echo '| $$ \  $$|  $$$$$$/   | $$   | $$ \/  | $$| $$$$$$$$'
    echo '|__/  \__/ \______/    |__/   |__/     |__/|________/'
    fastfetch --logo none --logo-padding-left 0 --logo-padding-top 0
    # Commands to run in interactive sessions can go here
    
end

# Created by `pipx` on 2026-05-17 10:17:45
set PATH $PATH /home/muhammed/.local/bin
