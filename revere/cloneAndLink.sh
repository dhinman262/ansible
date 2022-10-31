#!/usr/bin/env bash

PGH_REPO=git@github.com:dhinman262

# Clone Notes
if [[ ! -e ~/Notes ]]; then
    echo "~/Notes does not exist"
    (cd ~; git clone ${PGH_REPO}/Notes.git)
else
    echo "~/Notes exists"
fi   

# Clone machines
if [[ ! -e ~/machines ]]; then
    echo "~/machines does not exist"
    (cd ~; git clone  ${PGH_REPO}/machines.git)
else
    echo "~/machines exists"
fi   

# Symlink in the config files
FROMDIR=~/machines/revere
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

# Symlink in ~/.ssh
if [[ ! -L ~/.ssh ]]; then
    cp ~/.ssh/* ${FROMDIR}/.ssh
    rm -rf ~/.ssh
    chmod 0700 
    ln -s ${FROMDIR}/.ssh ~/.ssh
fi  
