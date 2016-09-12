#!/bin/bash

# A common 'main' script file to include across multiple machines.

. ~/script/aliases
. ~/script/functions
. ~/script/git-completion.bash

PS1='\W$ '

export PATH="$PATH:$HOME/bin:$HOME/script/linux"
# Add the .vim dir to PYTHONPATH for rope.
export PYTHONPATH="$HOME/.vim:$PYTHONPATH"

# Make git accept commit messages generated for merges, so there's less
# typing involved.
export GIT_MERGE_AUTOEDIT=no

# Use completion for dub.
source ~/script/completion/dub-completion.bash

# Stop Ctrl+D from closing the terminal.
set -o ignoreeof

# Make history ten times as large as it is by default.
export HISTSIZE=10000
export HISTFILESIZE=20000

# Make completion case-insensitive
bind "set completion-ignore-case on"
# Show all of the options when completing
bind "set show-all-if-ambiguous on"
# Complete immediately to some available option, and allow cycling through
# options, like in Vim.
#
# We'll start completion with the last match first, which is usually what
# we want.
bind 'TAB:menu-complete-backward'
# Shift+Tab should go backwards.
bind '"\e[Z":menu-complete'

# Use git branch completion for move-migrations
__git_complete move-migrations _git_checkout
