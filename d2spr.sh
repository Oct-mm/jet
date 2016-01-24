#!/bin/bash
## Build Automation Scripts
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
## on behalf of Team Octos et al.

## Check to see if there are build args
## First Argument is for the -j concurrent build threads - Defaults to -j21 unless
## you set it otherwise.  Careful, or it will melt your machine!
BSPEED=$2
PUSH=$1
<<<<<<< HEAD
: ${BSPEED:="16"}
=======
: ${BSPEED:="21"}
>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd
: ${PUSH:=false}
BVARIANT=`basename $0 | cut -f 1 -d "."`
jet/bscript.sh ${PUSH} ${BSPEED} ${BVARIANT}
