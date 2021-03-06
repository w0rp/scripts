#!/bin/bash

# A common 'main' script file to include across multiple machines.

# shellcheck disable=SC1090
. ~/script/aliases
# shellcheck disable=SC1090
. ~/script/functions
# shellcheck disable=SC1090
. ~/script/completion/rules

if ! ((KEEP_PS1)); then
    PS1='\W$ '
fi

export PATH="$PATH:$HOME/bin"
# Scripts which should work on any Unix flavour.
export PATH="$PATH:$HOME/script/unix"

# Don't load the Linux-only scripts on Mac OSX
if ! [[ "$OSTYPE" =~ ^darwin ]]; then
    export PATH="$PATH:$HOME/script/linux"
fi

# Set up Go, if available
if [ -d /usr/local/go ]; then
    export PATH="$PATH:/usr/local/go/bin"

    if command -v go &> /dev/null; then
        GOPATH=$(go env GOPATH)
        export GOPATH
    fi
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

# Use Chromium for Karma tests.
export CHROME_BIN=/usr/bin/chromium-browser

# Give Node more RAM
export NODE_OPTIONS="--max_old_space_size=4096"

shopt -s globstar

# Set up the gpg agent.
GPG_TTY="$(tty)"
export GPG_TTY
