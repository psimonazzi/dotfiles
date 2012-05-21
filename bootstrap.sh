#!/bin/bash

# Create symlinks in the home dir to all files in the dotfiles dir, creating subdirectories if necessary
cd ~/dotfiles
find . -type d -exec mkdir --parents -- ~/{} \;
find . -type f \( -not -name 'bootstrap.sh' -and -not -name 'README.md' -and -not -path '*.git/*' \) -exec ln --symbolic -- ~/dotfiles/{} ~/{} \;

