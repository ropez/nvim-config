#!/bin/bash

if ! command -v gh &> /dev/null
then
    echo "gh is required. Please install it"
    exit 1
fi

if ! command -v unzip &> /dev/null
then
    echo "unzip is required. Please install it"
    exit 1
fi

rid="linux-x64"
targetDir="$HOME/.local/share/nvim/roslyn"
latestVersion=$(gh api repos/Crashdummyy/roslynLanguageServer/releases | jq -r '.[].tag_name' | head -1)
# latestVersion="4.15.0-1.25175.5"

[[ -z "$latestVersion" ]] && echo "Failed to fetch the latest package information." && exit 1

echo "Latest version: $latestVersion"

asset=$(curl -s https://api.github.com/repos/Crashdummyy/roslynLanguageServer/releases |
jq -r --arg version $latestVersion --arg arch $rid '
  .[]
  | select(.tag_name == $version)
  | .assets[]
  | select(.name | contains($arch))
  | .browser_download_url
  ')

echo "Downloading: $asset"

curl -Lo "./roslyn.zip" "$asset"

echo "Remove old installation"
rm -rf $targetDir/*

unzip "./roslyn.zip" -d "$targetDir/"
rm "./roslyn.zip"
