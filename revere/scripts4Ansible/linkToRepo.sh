#!/usr/bin/env #!/usr/bin/env bash

# Link in the basic files
HOME=/home/dhinman262
REPO=${HOME}/machines/bixby

# Link up scripts
if [ ! -e "${HOME}/scripts" ] ; then
    echo "Linking in scripts"
    ln -s ${REPO}/scripts ${HOME}/scripts
fi

LINKFILES=( .emacs-custom.el .emacs .profile .bashrc .gitconfig )

for LINKFILE in  "${LINKFILES[@]}"
do
    if [ -L "${HOME}/${LINKFILE}" ] ; then
        echo "Skipping ${LINKFILE}"
    elif [ -f "${HOME}/${LINKFILE}" ] ; then
        echo "Copying and linking ${LINKFILE}"
        cp ${HOME}/${LINKFILE} ${REPO}
        rm ${HOME}/${LINKFILE}
        ln -s ${REPO}/${LINKFILE} ${HOME}/${LINKFILE}
    else
        echo "Linking ${LINKFILE}"
        ln -s ${REPO}/${LINKFILE} ${HOME}/${LINKFILE}
    fi
done
