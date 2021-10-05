#!/bin/bash
conda config --prepend pkgs_dirs $CONDA_CACHE_DIR 
conda install jupyter $CONDA_PKGS -y 
pip install --no-input $PIP_PKGS 
jupyter $NOTEBOOK_OR_LAB --allow-root --no-browser --ip=$IP --notebook-dir=/opt/src
