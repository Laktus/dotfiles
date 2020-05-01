#!/bin/zsh

# [I]nstall/[U]ninstall brew casks or open the [H]omepage of the app
# > Select files with <Tab>
# > Confirm with <Enter>

local token
token=$(brew search --casks | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

if [ "x$token" != "x" ]; then
  echo "(I)nstall, (U)ninstall or open the (h)omepage of $token"
  read input
  if [ $input = "i" ] || [ $input = "I" ]; then
    brew cask install $token
  fi
  if [ $input = "u" ] || [ $input = "U" ]; then
    brew cask uninstall $token
  fi
  if [ $input = "h" ] || [ $input = "H" ]; then
    brew cask home $token
  fi
fi
