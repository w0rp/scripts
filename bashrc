#!/bin/bash

# A common 'main' script file to include across multiple machines.

. ~/script/aliases
. ~/script/functions
. ~/script/completion/rules

PS1='\W$ '

export PATH="$PATH:$HOME/bin"
# Scripts which should work on any Unix flavour.
export PATH="$PATH:$HOME/script/unix"

# Don't load the Linux-only scripts on Mac OSX
if ! [[ "$OSTYPE" =~ ^darwin ]]; then
    export PATH="$PATH:$HOME/script/linux"
fi

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

shopt -s globstar
