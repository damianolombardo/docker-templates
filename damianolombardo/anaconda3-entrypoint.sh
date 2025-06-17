#!/bin/bash

# Debug: Show current user info
echo "=== DEBUG INFO ==="
echo "Current user: $(whoami)"
echo "Current UID: $(id -u)"
echo "Current GID: $(id -g)"
echo "PUID env var: $PUID"
echo "PGID env var: $PGID"
echo "=================="

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
