#!/usr/bin/env bash

# Include library helper for colorized echo
source ./library/helper_echo.sh

function runScripts() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Run sections based on command line arguments
    for ARG in "$@"
    do
        if [ $ARG == "update" ] || [ $ARG == "all" ]; then
            bot "Starting update.sh script..."
            ./osxprep.sh
        fi
        if [ $ARG == "brew" ] || [ $ARG == "all" ]; then
            bot "Starting brew.sh script..."
            ./brew.sh
        fi
        if [ $ARG == "symlink" ] || [ $ARG == "all" ]; then
            bot "Starting symlink.sh script..."
            ./symlink.sh
        fi
        if [ $ARG == "macos" ] || [ $ARG == "all" ]; then
            bot "Starting macos.sh script..."
            ./macos.sh
        fi
        if [ $ARG == "config" ] || [ $ARG == "all" ]; then
            bot "Starting config.sh script..."
            ./config.sh
        fi
    done
    ok "Completed running setup.sh, restart your computer to ensure all updates take effect"
}

read -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    runScripts $@
fi;

unset runScripts;