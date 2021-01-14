#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo creating config file
cp ../config/default.json.example-rtpengine ../config/local.json
sed -i "#35\.195\.201\.218s#127\.0\.0\.1#g" ../config/local.json

echo copying system file
sudo cp -r etc/* /etc
sudo cp -r lib/* /lib
sudo sed -i "s#__HOMEPATH__#$DIR#g" /lib/systemd/system/siprec-drachtio.service


echo restarting services
sudo systemctl restart rsyslog
sudo systemctl enable siprec-drachtio.service
sudo systemctl restart siprec-drachtio.service
echo done.
