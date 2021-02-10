#!/bin/bash
# Remove all thumbnails from ~/.cache/thumbnails/*

rm -rf ~/.cache/thumbnails/*
notify-send -i dialog-information "All thumbnails removed"

