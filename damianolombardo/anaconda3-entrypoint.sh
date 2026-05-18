#!/bin/bash
set -e

echo "=== DEBUG INFO ==="
echo "Current user: $(whoami)"
echo "Current UID: $(id -u)"
echo "Current GID: $(id -g)"
echo "PUID env var: $PUID"
echo "PGID env var: $PGID"
echo "=================="

INSTALL_MARKER="/opt/data/.packages_installed"
if [ ! -f "$INSTALL_MARKER" ]; then
    [ -n "$CONDA_CACHE_DIR" ] && conda config --prepend pkgs_dirs "$CONDA_CACHE_DIR"
    [ -f /opt/data/conda.txt ] && conda install --file /opt/data/conda.txt -y
    [ -f /opt/data/pip.txt ]   && pip install --no-input -r /opt/data/pip.txt
    touch "$INSTALL_MARKER"
fi

JUPYTER_ARGS="--allow-root --no-browser --ip=$IP --notebook-dir=/opt/src"

if [ -n "${JUPYTER_PASSWORD}" ]; then
    JUPYTER_PASSWORD_HASH=$(JUPYTER_PASSWORD="$JUPYTER_PASSWORD" python -c \
        "import os; from jupyter_server.auth import passwd; print(passwd(os.environ['JUPYTER_PASSWORD']))")
    JUPYTER_ARGS="$JUPYTER_ARGS --ServerApp.password=$JUPYTER_PASSWORD_HASH"
fi

exec jupyter $NOTEBOOK_OR_LAB $JUPYTER_ARGS