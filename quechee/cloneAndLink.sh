#!/usr/bin/env bash

REPO_DIR=/mnt/chromeos/removable/MUSICBOX2/gitrepos

# Clone Notes
if [[ ! -e ~/Notes ]]; then
    echo "~/Notes does not exist"
    (cd ~; git clone ${REPO_DIR}/Notes)
else
    echo "~/Notes exists"
fi   

# Clone machines
if [[ ! -e ~/machines ]]; then
    echo "~/machines does not exist"
    (cd ~; git clone ${REPO_DIR}/machines)
else
    echo "~/machines exists"
fi   

# Symlink in the config files
FROMDIR=~/machines/quechee
cd ~
for f in .emacs .emacs-custom.el .profile .gitconfig .bashrc; do
    echo $f
    if [[ -f $f && ! -L $f ]]; then
	echo "File ${f} found; moving to ${f}.backup"
	mv ${f} ${f}.backup
    fi
    if [[ ! -L $f ]]; then
	echo "Will ln -s ${FROMDIR}/$f $f"
	ln -s ${FROMDIR}/$f $f
    fi
done

# Symlink in the config directories
if [[ ! -L ~/scripts ]]; then
    ln -s ${FROMDIR}/scripts scripts
fi    
