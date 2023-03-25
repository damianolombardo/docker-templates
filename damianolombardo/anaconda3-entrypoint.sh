#!/bin/bash
conda config --prepend pkgs_dirs $CONDA_CACHE_DIR 
conda install --file /opt/data/conda.txt -y 
pip install --no-input -r /opt/data/pip.txt 
jupyter $NOTEBOOK_OR_LAB --allow-root --no-browser --ip=$IP --notebook-dir=/opt/src
