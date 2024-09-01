#!/bin/bash
clear
apt install git
rm -r /var/ps5host
mkdir /var/ps5host
cd /var/ps5host
folder="/var/ps5host/PS5-Exploit-Host"
c_beginning_url="https://github.com/idlesauce/PS5-Exploit-Host.git"

repo_url=$c_beginning_url

if [ -d ${folder} ]
then
  echo -e "\e[31m${folder} already exist!\e[39m"
  echo "try to update"
  cd ${folder}
  git init
  git remote update
  count=$(git rev-list HEAD...origin/master --count)
  if [ $count -gt "0" ]
  then
    echo -e "\e[31m"
    read -r -p  "Update [y/n] " answer
    echo -e "\e[39m"
    if [ "$answer" = "y" ] 
    then
      git fetch --all
      git reset --hard origin/master
    fi
  fi
  cd -
else
  echo "${folder} not exist"
  git clone $repo_url
  if [ $? -eq "0" ] 
  then
    echo -e "\e[32m${folder} repo clone is Ok!\e[39m"
  fi
fi

echo "A manuals.playstation.net 192.168.111.85" > $folder/dns.conf
systemctl disable --now systemd-resolved.service
alias python=python3
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sysctl -p
systemctl disable deploy.service
systemctl disable fakedns.service
systemctl disable host.service
rm /etc/systemd/system/deploy.service
rm /etc/systemd/system/fakedns.service
rm /etc/systemd/system/host.service

cat > /etc/systemd/system/deploy.service <<EOF
[Unit]
Description=deploy
After=multi-user.target

[Service]
User=root
Group=root
Type=simple
Restart=always
WorkingDirectory=/var/ps5host/PS5-Exploit-Host
ExecStart=/usr/bin/python /var/ps5host/PS5-Exploit-Host/deploy.py

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/fakedns.service <<EOF
[Unit]
Description=fakedns
After=deploy.service
After=multi-user.target

[Service]
User=root
Group=root
Type=simple
Restart=always
WorkingDirectory=/var/ps5host/PS5-Exploit-Host
ExecStart=/usr/bin/python "/var/ps5host/PS5-Exploit-Host/fakedns.py -c dns.conf"

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/host.service <<EOF
[Unit]
Description=host
After=deploy.service
After=fakedns.service
After=multi-user.target

[Service]
User=root
Group=root
Type=simple
Restart=always
WorkingDirectory=/var/ps5host/PS5-Exploit-Host
ExecStart=/usr/bin/python PS5-Exploit-Host/host.py

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable deploy.service
systemctl enable fakedns.service
systemctl enable host.service

systemctl restart deploy.service
systemctl restart fakedns.service
systemctl restart host.service

echo end1
reboot

