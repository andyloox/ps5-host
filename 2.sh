#!/bin/bash
rm start2.sh
rm start2.log
rm genPem.sh
wget --no-check-certificate https://raw.githubusercontent.com/andyloox/ps5-host/master/start2.sh
chmod +x start2.sh
./start2.sh 2>&1 | tee start2.log
wget --no-check-certificate https://raw.githubusercontent.com/andyloox/ps5-host/master/genPem.sh
chmod +x genPem.sh
