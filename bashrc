#!/bin/bash

# A common 'main' script file to include across multiple machines.

. ~/script/aliases
. ~/script/functions

PS1='\W$ '

export PATH="$PATH:~/bin:~/script/linux"

# Make git accept commit messages generated for merges, so there's less
# typing involved.
export GIT_MERGE_AUTOEDIT=no

# Use completion for dub.
source ~/script/completion/dub-completion.bash

# Stop Ctrl+D from closing the terminal.
set -o ignoreeof

