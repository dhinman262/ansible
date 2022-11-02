#!/usr/bin/env bash

PGH_REPO=git@github.com:dhinman262

BASEDIR=/opt/home/dhinman
RESOURCEDIR=${BASEDIR}/Resources
NOTESDIR=${BASEDIR}/Notes
MACHINESDIR=${BASEDIR}/machines
FROMDIR=${MACHINESDIR}/revere

# Clone Notes
if [[ ! -e ${NOTESDIR} ]]; then
    echo "${NOTESDIR} does not exist"
    (cd ${BASEDIR}; git clone ${PGH_REPO}/Notes.git; cd Notes; git remote add pgh ${PGH_REPO}/Notes.git )
else
    echo "${NOTESDIR} exists"
fi   

# Clone machines
if [[ ! -e ${MACHINESDIR} ]]; then
    echo "${MACHINESDIR} does not exist"
    (cd ${BASEDIR}; git clone  ${PGH_REPO}/machines.git; cd machines; git remote add pgh ${PGH_REPO}/machines.git )
else
    echo "${MACHINESDIR} exists"
fi   

# Symlink in the config files
cd ~
for f in .emacs .profile .gitconfig .bashrc .Xmodmap; do
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

# Symlink in the machines directories
if [[ ! -d ~/.jupyter ]]; then
    mkdir ~/.jupyter
fi

for d in templates scripts .ssh .jupyter; do
    echo "machine dir $d ..."
    if [[ ! -L ~/${d} ]] && [[ -d ${FROMDIR}/${d} ]]; then
        cp ~/${d}/* ${FROMDIR}/${d}
        rm -rf ~/${d}
        ln -s ${FROMDIR}/${d} ~/${d}
    fi  
done

# Symlink in the opt data directories
for d in Videos Documents Pictures Music; do
    echo "opt data dir $d ..."
    if [[ ! -L ~/${d} ]]; then
        rm -rf ~/${d}
        ln -s /opt/data/${d} ~/${d}
    fi
done

# Symlink in the opt home directories
for d in Notes; do
    echo "opt home dir $d ..."
    if [[ ! -L ~/${d} ]]; then
        rm -rf ~/${d}
        ln -s /opt/home/dhinman/${d} ~/${d}
    fi
done

