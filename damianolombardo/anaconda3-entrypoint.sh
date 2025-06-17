#!/bin/bash

# Initialize conda for bash shell
conda init bash
source ~/.bashrc

conda config --prepend pkgs_dirs $CONDA_CACHE_DIR 
conda install --file /opt/data/conda.txt -y 
pip install --no-input -r /opt/data/pip.txt 

# Set up Jupyter password if provided
JUPYTER_ARGS="--allow-root --no-browser --ip=$IP --notebook-dir=/opt/src"
if [ -n "${JUPYTER_PASSWORD}" ]; then
    # Generate password hash and set it
    JUPYTER_PASSWORD_HASH=$(python -c "from jupyter_server.auth import passwd; print(passwd('${JUPYTER_PASSWORD}'))")
    JUPYTER_ARGS="$JUPYTER_ARGS --ServerApp.password='$JUPYTER_PASSWORD_HASH'"
fi

jupyter $NOTEBOOK_OR_LAB $JUPYTER_ARGS