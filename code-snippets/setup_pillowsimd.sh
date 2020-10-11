#!/bin/bash
# This script will install libjpeg-turbo https://libjpeg-turbo.org/ and 
# Pillow-SIMD https://github.com/uploadcare/pillow-simd.
# These are Python image libraries which parallelise image operations.
# libjpeg-turbo speeds up jpeg encoding and decoding, while Pillow-SIMD speeds 
# up resizing and other operations like Gaussian blur for all Pillow images. 
# In deep learning applications I have typically noticed a ~5% speedup or 
# increased GPU utilisation by using these.

# NOTE: this script has only been tested inside an ubuntu:18.04 Docker
# container, so use with caution on a different OS. If it works, the final line 
# of the script will print the Pillow version, for example "7.0.0.post3" - the 
# '.post3' at the end indicates that Pillow-SIMD was successfully installed.

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Recommended to use this with every bash script. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

pip uninstall -y Pillow

apt install -y \
    libjpeg-turbo8-dev \
    zlib1g-dev \
    libtiff5-dev \
    liblcms2-dev \
    libfreetype6-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libopenjp2-7-dev \
    libraqm0 \

CC="cc -mavx2" pip install --no-cache-dir -U -I --force-reinstall pillow-simd \
    --global-option="build_ext" \
    --global-option="--enable-zlib" \
    --global-option="--enable-jpeg" \
    --global-option="--enable-tiff" \
    --global-option="--enable-freetype" \
    --global-option="--enable-lcms" \
    --global-option="--enable-webp" \
    --global-option="--enable-webpmux" \
    --global-option="--enable-jpeg2000" \

python -c "from PIL import __version__; print(f'Pillow Version: {__version__}')"