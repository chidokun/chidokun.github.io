#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mCommitting source to GitHub...\033[0m\n"

# Add changes to git.
git add .

# Commit changes.
git commit -m "Update site"

# Push source and build repos.
git push origin master