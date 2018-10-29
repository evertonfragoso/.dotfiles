#!/bin/bash

Z_FOLDER=~/z

if [ -d "$Z_FOLDER" ]; then
  cd ~/z && git pull
else
  cd && git clone https://github.com/rupa/z.git
fi
