#!/bin/bash
rm start.sh
rm start.log
wget --no-check-certificate https://raw.githubusercontent.com/andyloox/ps5-host/master/start.sh
chmod +x start.sh
./start.sh 2>&1 | tee start.log
