#!/bin/bash

# Prompt the user for a GitHub username
read -p "Enter GitHub username: " username

# Fetch the user's repositories and categorize them
curl -s "https://api.github.com/users/$username/repos?per_page=100" | \
    jq '[.[] | if .fork then {type: "fork"} else {type: "original"} end] |
        group_by(.type) |
        map({(.[0].type): length})'
