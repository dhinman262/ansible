#!/usr/bin/env bash

PGH_REPO=git@github.com:dhinman262

BASEDIR=/opt/home/dhinman
RESOURCEDIR=${BASEDIR}/Resources
NOTESDIR=${BASEDIR}/Notes
MACHINESDIR=${BASEDIR}/machines
FROMDIR=${MACHINESDIR}/revere


# Make sure github is added to known_hosts
cat >> ~/.ssh/known_hosts <<EOF
|1|kKu62dPA1AB1UUWeUOuCjWyM854=|GohwRR/CZNqMDGPgjOQeZG6L+iU= ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
|1|rHZ9DU/D8l3jCThRGuDxCrgqvfs=|zmA5mZy4x+PDalgfmwsoFsnhfSQ= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|EMSPNsJAHpjNUm0Mek3kE3Pe1Ec=|wFMCo/GzQeKQQiPD+fbkkn/Md6g= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
EOF

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
for d in Videos Documents Pictures Music projects; do
    echo "opt data dir $d ..."
    if [[ ! -L ~/${d} ]]; then
        rm -rf ~/${d}
        ln -s /opt/data/${d} ~/${d}
    fi
done

# Symlink in the opt home directories
for d in Notes projects; do
    echo "opt home dir $d ..."
    if [[ ! -L ~/${d} ]]; then
        rm -rf ~/${d}
        ln -s /opt/home/dhinman/${d} ~/${d}
    fi
done

