#!/bin/bash
## Build Automation Scripts
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
<<<<<<< HEAD
## Updated by Richard Covington <rcovington79@gmail.com>
=======
>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd
## on behalf of Team Octos et al.

PUSH=$1
BSPEED=$2
: ${PUSH:=false}
<<<<<<< HEAD
: ${BSPEED:="16"}
BVARIANT=$3

source build/envsetup.sh
source jet/credentials.sh
=======
: ${BSPEED:="12"}
BVARIANT=$3

source build/envsetup.sh
#source jet/credentials.sh
>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd

echo "Setting Lunch Menu to ${BVARIANT}"
lunch to_${BVARIANT}-userdebug

## Clean Up Previous Builds as well as old md5sum files
make installclean && rm -rf out/target/product/*/*md5sum

## Current Build Date
BDATE=`date +%m-%d`

if [ $1 = "y" ]; then
PUSH=true
else
PUSH=false
fi

#if [ ! -d "${COPY_DIR}/${BDATE}" ]; then
	#echo "Creating directory for ${COPY_DIR}/${BDATE}"
	#mkdir -p ${COPY_DIR}/${BDATE}
#fi

<<<<<<< HEAD
echo "Starting brunch with ${BSPEED} threads for ${COPY_DIR}"
=======
echo "Starting brunch with ${BSPEED}"
>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd
if ${PUSH}; then
echo "Pushing to Remote after build!"
fi
# Build command
brunch ${BVARIANT}
find ${OUT} '(' -name 'to*' -size +150000 ')' -print0 |
        xargs --null md5sum |
        while read CHECKSUM FILENAME
        do
		if [ ${FILENAME} == "-" ]; then
			echo "Borked Build"
		else
			if ! $PUSH; then
			echo "Moving to Copybox"
                	cp ${FILENAME} ${COPY_DIR}/${BDATE}/${FILENAME##*/}
                	cp "${FILENAME}.md5sum" ${COPY_DIR}/${BDATE}/${FILENAME##*/}.md5
			fi
		OTAFILE=`basename ${FILENAME} | cut -f 1 -d '.'`
		echo "Filename ${FILENAME} - OTAFILE: ${OTAFILE}"
		if ${PUSH}; then
			if [ -e ota.xml ]; then
			    echo "Cleaning old OTA manifest"
			    rm ota.xml
			fi
			echo "Pulling OTA manifest"
			wget http://www.teamoctos.com/ota.xml
			echo "Updating manifest for ${OTAFILE}"
<<<<<<< HEAD
	                sed -i "s/to-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-${BVARIANT}/${OTAFILE}/g" ota.xml
=======
	                sed -i "s/Oct-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-${BVARIANT}/${OTAFILE}/g" ota.xml
>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd
     			echo "Removing existing file from remote."
			ssh ${RACF}@${RHOST} "rm -rf ${ROUT}/${BVARIANT}/*.zip" < /dev/null
     			echo "Pushing new file ${OTAFILE} to remote"
                        scp ${FILENAME} ${RACF}@${RHOST}:${ROUT}/${BVARIANT}
			echo "Pushing new OTA manifest to remote"
			scp ota.xml ${RACF}@${RHOST}:public_html/ota.xml
			echo "Triggering Sync"
			curl ${RSYNC}
		fi
	fi
        done
<<<<<<< HEAD
=======

>>>>>>> 562c7d5e28b26b2eeffee8053b29b26cfb6719cd
