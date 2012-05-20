#!/bin/bash

# Create symlinks in the home dir to all files in the dotfiles dir, creating subdirectories if necessary
cd ~/dotfiles
find -type d -exec mkdir --parents -- ~/{} \;
find -type f \( -iname "$0" -or -iname "README.md" \) -exec ln --symbolic -- ~/dotfiles/{} ~/{} \;


