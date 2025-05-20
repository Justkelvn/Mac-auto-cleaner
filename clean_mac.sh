#!/bin/bash
purge
rm -rf ~/Library/Caches/*
osascript -e 'display notification "Mac cleanup complete!" with title "Auto Cleaner"'
