#!/bin/sh
brew install libxml2 gcc libgccjit autoconf coreutils curl dbus expat gcc gmp gnu-sed gnutls jansson libffi libiconv librsvg libtasn1 libunistring libxml2 little-cms2 mailutils make ncurses nettle pkg-config sqlite texinfo tree-sitter zlib imagemagick libxaw libxft freetype cairo harfbuzz
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
git checkout emacs-28.2
./autogen.sh
./configure --with-x --with-ns=no --with-json --with-modules --with-harfbuzz --with-compress-install \
            --with-threads --with-included-regex --with-x-toolkit=lucid --with-zlib --without-sound \
            --without-xpm --with-jpeg --without-tiff --without-gif --with-png --with-cairo \
            --without-rsvg --with-imagemagick  --without-toolkit-scroll-bars \
            --without-gpm --without-dbus --without-pop \
            --without-mailutils --without-gsettings --without-pop --with-native-compilation
make -j4
