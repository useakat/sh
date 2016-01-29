#!/bin/bash

# This small script makes current directory Git repository,
# and places its remote bare repository in the Dropbox directory.
# I am using this script on Mac OS X.
#
# Usage:
#   1. Before use, give this file executable permission.
#   2. Go to a directory you want to make Git.
#   3. Execute this script.
#
# This program is developed by team-aries (https://github.com/team-aries)
# and is distributed under GPLv2.
#
# ----------
# Copyright 2014 team-aries
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# If you need a copy of the GNU General Public License,
# see <http://www.gnu.org/licenses/gpl-2.0.html>


# will make current directory new repository
localDir=$(pwd)

# will make remote (bare) repository in your Dropbox directory
remoteRoot=$(cd; pwd)/Dropbox/gitStore
remoteDir=$remoteRoot$localDir.git

# abort if repositories exist
#if [ -d "$localDir/.git" ]; then
#	echo "*** $localDir is already Git repository"
#	exit
#fi
if [ -d "$remoteDir" ]; then
	echo "*** $remoteDir already exists"
	exit
fi

# prepare remote bare repository
mkdir -p $remoteDir
if [ -d "$remoteDir" ]; then
	cd $remoteDir
	git init --bare
else
	echo "*** $remoteDir not found"
	exit
fi

# init local repository and set its origin
cd $localDir
#git init
git remote add origin $remoteDir
git config branch.master.remote origin
git config branch.master.merge refs/heads/master

# .DS_Store files will be ignored
if [ ! -e '.gitignore' ]; then
	echo '.DS_Store' > .gitignore
	git add .gitignore
	echo new .gitignore added
fi

echo 'Done.'
