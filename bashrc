#!/usr/bin/env bash

# A common 'main' script file to include across multiple machines.

# shellcheck source=./aliases
. ~/script/aliases
# shellcheck source=./functions
. ~/script/functions
# shellcheck source=./completion/rules
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
if [ -d /usr/local/go ] && [ -z "$GOROOT" ]; then
    export GOROOT=/usr/local/go

    if command -v go &> /dev/null; then
        GOPATH=$(go env GOPATH)
        export GOPATH
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
    fi
fi

# Set up Rust, if available.
if [ -d ~/.cargo ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
fi

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
