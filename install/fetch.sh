#!/bin/bash

git clone https://github.com/mauro-balades/bash-plusplus

cd bash-plusplus

if [[ ! "$1" == "" ]];
then
  sudo make install -B PREFIX="../$1/"
  cd "../$1/bash++"
  pwd
  sudo mv libs/* .
  rm -rf libs

  pwd
  sudo chown $USER:$USER "../$1/bash++"
  sudo chmod  -R 777 "../$1/bash++/"
else
  sudo make -B install
fi

cd ..
sudo rm -rf bash-plusplus

echo "Installed !"
