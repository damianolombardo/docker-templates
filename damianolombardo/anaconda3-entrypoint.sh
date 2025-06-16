#!/bin/bash

conda init bash
source ~/.bashrc

conda config --prepend pkgs_dirs $CONDA_CACHE_DIR 
if [ -n "${DEFAULT_CONDA_ENV}" ]; then 
    if ! conda env list | grep -q "^${DEFAULT_CONDA_ENV}\s"; then
        echo "Creating conda environment: ${DEFAULT_CONDA_ENV}"
        conda create -n $DEFAULT_CONDA_ENV -y
    fi
    conda activate $DEFAULT_CONDA_ENV
fi
conda install --file /opt/data/conda.txt -y 
pip install --no-input -r /opt/data/pip.txt 
jupyter $NOTEBOOK_OR_LAB --allow-root --no-browser --ip=$IP --notebook-dir=/opt/src
