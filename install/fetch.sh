#!/bin/bash

git clone https://github.com/mauro-balades/bash-plusplus

cd bash-plusplus

if [[ ! "$1" == "" ]];
then
  sudo make install PREFIX="../$1"
  cd "../$1"
  mv libs .
  rm -rf libs
else
  sudo make install
fi

cd ..
sudo rm -rf bash-plusplus

echo "Installed !"
