#!/usr/bin/env bash

FROM=/mnt/chromeos/removable/MUSICBOX2/gitrepos
TO=/home/dhinman262
REPOS=( Notes machines projects )

if [ ! -d "${FROM}" ] ; then
    echo "Source directory ${FROM} does not exist"
    exit 1
fi

if [ ! -d "${FROM}" ] ; then
    echo "Source directory ${FROM} does not exist"
    exit 1
fi

if [ ! -d "${TO}" ] ; then
    echo "Target directory ${TO} does not exist"
    exit 1
fi

for REPO in "${REPOS[@]}"
do
    cd $TO
    if [ -d "${REPO}" ]
    then
	echo "Skipping existing ${REPO}"
    else
        git clone file://${FROM}/${REPO}
	cd $REPO
	git remote add musicbox2  file://${FROM}/${REPO}
    fi
done
