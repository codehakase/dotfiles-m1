#!/usr/bin/env bash

echo "synching dotfiles to vcs..."

now=`date '+%y-%m-%d'`

cd $HOME/dotfiles

git add .
git commit -m "Auto Syncing dotfiles.... $now"
git push origin HEAD
