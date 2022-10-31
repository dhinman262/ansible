#!/usr/bin/env bash

# Finish up miniconda
bash /opt/Miniconda3-latest-Linux-x86_64.sh
source /home/dhinman262/miniconda3/bin/activate
conda init

# Finish up gvm
bash /opt/gvminstall.sh
source /home/dhinman262/.gvm/scripts/gvm
