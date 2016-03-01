#!/bin/bash
## Build Automation Scripts
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
## Updated by Richard Covington <rcovington79@gmail.com>
## on behalf of Team Octos et al.

PUSH=$1
BSPEED=$2
: ${PUSH:=false}
: ${BSPEED:="12"}
BVARIANT=$3

source build/envsetup.sh

echo "Setting Lunch Menu to ${BVARIANT}"
lunch to_${BVARIANT}-userdebug

## Clean Up Previous Builds as well as old md5sum files
make installclean && rm -rf out/target/product/*/*md5sum

## Current Build Date
BDATE=`date +%m-%d`

echo "Starting brunch with ${BSPEED}"

# Build command
brunch ${BVARIANT}
find ${OUT} '(' -name 'to*' -size +150000 ')' -print0 |
        xargs --null md5sum |
        while read CHECKSUM FILENAME
        do
		if [ ${FILENAME} == "-" ]; then
			echo "Borked Build"
		fi
	fi
        done
