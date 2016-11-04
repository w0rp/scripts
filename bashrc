#!/bin/bash

# A common 'main' script file to include across multiple machines.

. ~/script/aliases
. ~/script/functions
. ~/script/completion/rules

PS1='\W$ '

export PATH="$PATH:$HOME/bin:$HOME/script/linux"
# Add the .vim dir to PYTHONPATH for rope.
export PYTHONPATH="$HOME/.vim:$PYTHONPATH"

# Make git accept commit messages generated for merges, so there's less
# typing involved.
export GIT_MERGE_AUTOEDIT=no

# Stop Ctrl+D from closing the terminal.
set -o ignoreeof

# Make history ten times as large as it is by default.
export HISTSIZE=10000
export HISTFILESIZE=20000
