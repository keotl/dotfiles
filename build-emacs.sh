#!/bin/sh
sudo apt-get install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev gnutls-dev libgtk-3-dev
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
git checkout emacs-26.3
./autogen.sh
./configure
make -j4
