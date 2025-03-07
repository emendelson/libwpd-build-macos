#!/bin/bash

# install autoconf and automake first

# install pkg-config first
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/

mkdir $HOME/Development
mkdir $HOME/Development/libwpd-build
cd $HOME/Development/libwpd-build

function pause(){
   read -p "$*"
}

set -e

# for boost
curl -OL https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
tar -xzf boost_1_87_0.tar.gz
cd boost_1_87_0
./bootstrap.sh
./b2
sudo ./b2 install
cd ..

echo ''
echo ==============
pause 'boost installed. Press Enter.'

echo ===============
echo librevenge
echo ===============

# for librevenge 
git clone https://git.code.sf.net/p/libwpd/librevenge librevenge
cd librevenge
autoupdate
./autogen.sh
./configure CXXFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 LDFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 --enable-static --disable-shared --disable-tests
make clean all
sudo make install
cd ..

echo ''
echo ==============
pause 'librevenge installed. Press Enter.'

echo ===============
echo libwpd - document
echo ===============

# for libwpd
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/
git clone https://git.code.sf.net/p/libwpd/code libwpd
cd libwpd 
autoupdate
./autogen.sh
./configure CXXFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 LDFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0  --enable-static --disable-shared
make clean all
sudo make install
cd ..

echo ''
echo ==============
pause 'libwpd installed. Press Enter.'

## check /usr/local/bin/wpd2text for static-linked

echo ===============
echo libwpg - graphics
echo ===============

# for libwpg
git clone https://git.code.sf.net/p/libwpg/code libwpg
cd libwpg
autoupdate
./autogen.sh
./configure CXXFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 LDFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0  --enable-static --disable-shared
make clean all
sudo make install
cd ..

echo ''
echo ==============
pause 'libwpg installed. Press Enter.'

## check /usr/local/bin/wpd2raw for static-linked

echo ===============
echo libodfgen
echo ===============

brew install libxml2

# for libodfgen
git clone https://git.code.sf.net/p/libwpd/libodfgen libodfgen
cd libodfgen 
autoupdate
./autogen.sh
./configure CXXFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 LDFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 --enable-static --disable-shared
make clean all
sudo make install
cd ..

echo ''
echo ==============
pause 'libodfgen installed. Press Enter.'

echo ===============
echo writerperfect
echo ===============

# for writerperfect
git clone https://git.code.sf.net/p/libwpd/writerperfect writerperfect
cd writerperfect
autoupdate  
./autogen.sh
./configure CXXFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0 LDFLAGS=-I$HOME/Development/libwpd-build/boost_1_87_0  --enable-static --disable-shared
make clean all
sudo make install
cd ..

echo ''
echo ==============
pause 'writerperfect installed. Press Enter.'

# test static linking
echo ''
echo ==============
pause 'Next command runs otool -L to test static linking. Press Enter.'

otool -L /usr/local/bin/wpd2odt

echo ''
echo ==============
pause 'All linked libraries should be in the /usr/lib/ folder. Press Enter.'

