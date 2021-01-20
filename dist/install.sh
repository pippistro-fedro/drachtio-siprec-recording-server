#!/bin/bash

DIR="$(echo $(cd ../ && pwd))"

echo creating config file
cp -f ../config/default.json.example-rtpengine ../config/local.json
sed -i "#35\.195\.201\.218s#127\.0\.0\.1#g" ../config/local.json

echo copying system file
sudo cp -f -r etc/* /etc
sudo cp -f -r lib/* /lib
sudo sed -i "s#__HOMEPATH__#$DIR#g" /lib/systemd/system/siprec-drachtio.service

echo npm install
cd $DIR
npm install

echo restarting services
sudo systemctl restart rsyslog
sudo systemctl enable siprec-rtpengine.service
sudo systemctl restart siprec-rtpengine.service
sudo systemctl enable siprec-drachtio.service
sudo systemctl restart siprec-drachtio.service

sudo mkdir -p /var/spool/rtpengine
sudo chmod +rx  /var/spool/rtpengine

echo done.
