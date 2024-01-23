#!/usr/bin/env bash
# Scaffolding for a new, basic webdev project

VAR_GIT=false
if [ -z "$1" ]; then
    echo "Error: No arguments provided. Requires a project name."
    exit 1
elif [ -n "$2" ]; then
    if [ "$2" = 'true' ] || [ "$2" = 'false' ]
        then
            VAR_GIT=true
    else
        echo "Error: Second argument error. The second argument regarding the creation of a git repository. Value must be 'true' or 'false'. Exiting..."
        exit 2
    fi
fi

# If git is true, check for git installation and conditions
if [ "$VAR_GIT" = true ]; then
    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed. Cannot use to create a git repository. Exiting...'
        exit 3
    elif [ -z "$(git config --get user.name)" ] || [ -z "$(git config --get user.email)" ]; then
        echo 'Error: git is not configured (username, email). Cannot create repository. Exiting...'
        exit 4
    fi
fi
