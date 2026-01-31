#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q imagemagick | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/ImageMagick/ImageMagick/blob/main/app-image/icon.png?raw=true
export DESKTOP=https://raw.githubusercontent.com/ImageMagick/ImageMagick/refs/heads/main/app-image/imagemagick.desktop

# Deploy dependencies
quick-sharun \
	/usr/bin/animate   \
	/usr/bin/compare   \
	/usr/bin/composite \
	/usr/bin/conjure   \
	/usr/bin/convert   \
	/usr/bin/display   \
	/usr/bin/identify  \
	/usr/bin/import    \
	/usr/bin/magick*   \
	/usr/bin/mogrify   \
	/usr/bin/montage   \
	/usr/bin/stream

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
