#!/bin/bash

# A common 'main' script file to include across multiple machines.

. ~/script/aliases
. ~/script/functions

PS1='\W$ '

export PATH="$PATH:~/bin:~/script/linux"

# Use completion for dub.
source ~/script/completion/dub-completion.bash

# Stop Ctrl+D from closing the terminal.
set -o ignoreeof
