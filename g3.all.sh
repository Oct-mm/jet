#!/bin/bash
## Build Automation Scripts
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
## on behalf of Team Octos et al.

find jet '(' -name 'd85*.sh' ! -name 'ls*.sh' ! -name 'vs*.sh' ! -name 'g3all.sh' ')' -print |
        while read FILENAME
        do
	${FILENAME} $1 $2
        done
