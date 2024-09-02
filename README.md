Скрипт автоматически настроивает Хост для ПС5 на убунту, нужно только в dns.conf сменить айпи сервера


Делает клон из https://github.com/idlesauce/PS5-Exploit-Host


Как запустить:
1. nano 1.sh

И вставить код ниже:

#!/bin/bash
rm start.sh
rm start.log
wget --no-check-certificate https://raw.githubusercontent.com/andyloox/ps5-host/master/start.sh
chmod +x start.sh
./start.sh 2>&1 | tee start.log



2. chmod +x 1.sh
./1.sh
