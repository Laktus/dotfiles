#!/usr/bin/env bash

# Include library helper for colorized echo
source ./library/helper_echo.sh
source ./library/helper_install.sh

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# ZSH                                                                         #
###############################################################################

bot "Installing zsh, ohmyzsh, powerlevel9k theme..."
install_brew zsh 
install_brew zsh-autosuggestions 
install_brew zsh-completions 
install_brew zsh-syntax-highlighting

action "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

action "Installing powerlevel9k..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

running "Installing the Tomorrow Night theme for iTerm (opening file)"
open "./themes/Tomorrow Night.itermcolors"
ok

running "Setting ZSH as the default shell environment"
chsh -s $(which zsh)
ok

###############################################################################
# Homebrew                                                                    #
###############################################################################

bot "Installing binaries, terminal stuff, CLI..."
install_brew git
install_brew tree
install_brew mas
install_brew neofetch 
install_brew htop
brew install ruby
install_brew the_silver_searcher
install_brew thefuck
install_brew autojump

bot "Installing dev environment..."
install_brew maven
install_brew node
install_brew postgresql
install_brew mongodb
install_brew redis

bot "Installing fonts..."
brew tap homebrew/cask-fonts
install_cask font-firacode-nerd-font-mono

bot "Installing dev tool casks..."
install_cask visual-studio-code
install_cask iterm2
install_cask java

bot "Installing misc casks..."
# Dropbox was already installed via update.sh
install_cask alfred
install_cask appcleaner
install_cask evernotes
install_cask fliqlo
install_cask google-chrome
install_cask google-backup-and-sync
install_cask iina
install_cask keepassx
install_cask keepingyouawake
install_cask mactex
install_cask slack
install_cask spectacle
install_cask texmaker
install_cask the-unarchiver
install_cask tunnelblick
install_cask whatsapp

bot "Installing quick look plugins..."
# Reference: https://github.com/sindresorhus/quick-look-plugins/blob/master/readme.md
install_cask qlcolorcode 
install_cask qlstephen 
install_cask qlmarkdown 
install_cask quicklook-json 
install_cask betterzip 
install_cask suspicious-package 
install_cask webpquicklook 
install_cask qlvideo

###############################################################################
# Ruby                                                                        #
###############################################################################

bot "Installing ruby packages..."
install_gem_local bundler 
install_gem_local jekyll

###############################################################################
# Mac App Store                                                               #
###############################################################################

bot "Installing apps from App Store..."
install_mas 1278508951 # Trello
install_mas 836505650 # Battery Monitor: Health, Info

###############################################################################
# Other apps                                                                  #
###############################################################################

action "Downloading latest release of Portfolio Performance..."
curl -LO "$(curl -s https://api.github.com/repos/buchen/portfolio/releases/latest \
| grep browser_download_url | grep 'macosx' | head -n 1 | cut -d '"' -f 4)"

action "Unpacking tar.gz..."
tar -xzf "$(ls | grep PortfolioPerformance)" | xargs rm -r

action "Moving PortfolioPerformance to application folder..."
mv "PortfolioPerformance.app" /Applications/
ok

bot "Cleaning up..."
brew cleanup
rm "$(ls | grep PortfolioPerformance)"
ok