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

echo "A manuals.playstation.net 192.168.111.85" > ${folder}/dns.conf
