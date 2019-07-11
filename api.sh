#! /bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install nodejs -y

sudo apt install mongodb -y
sudo npm -g install @angular/cli -y


sudo useradd --create-home api
sudo usermod --shell /bin/bash api

sudo useradd --create-home ui
sudo usermod --shell /bin/bash ui
echo >> api.service
echo "[Unit]" >> api.service
echo 'Description=api' >> api.service
echo  >> api.service
echo "[Service]" >> api.service
echo 'user = ui' >> api.service
echo 'ExecStart=/usr/bin/node /home/ui/poolmanager-api/test.js' >> api.service
echo  >> api.service
echo "[Install]" >> api.service
echo 'WantedBy=multi-user.target' >> api.service

sudo  mv api.service /etc/systemd/system/api.service


sudo su - ui << EOF 
git clone https://github.com/yamileon/poolmanage-ui.git
pwd
cd poolmanage-ui
git checkout danny/sully

cd ../
git clone https://github.com/yamileon/poolmanager-api.git
cd poolmanager-api
git checkout Danny/Sully


exit
EOF 


echo >> ui.service
echo "[Unit]" >> ui.service
echo'Description = ui' >> ui.service
echo >> ui.service
echo '[Service]' >> ui.service

echo 'WorkingDirectory=/home/ui/poolmanage-ui' >> ui.service
echo 'ExecStart= /usr/bin/ng s --host 0.0.0.0' >> ui.service
echo "[Install]" >> ui.service
echo 'WantedBy = multi-user.target' >> ui.service

sudo mv ui.service /etc/systemd/system/ui.service

sudo su - api << EOF
echo "Test"
EOF
sudo systemctl daemon-reload

sudo systemctl start mongodb
echo "mongo run"
sudo su systemctl start ui
echo "ui run"
sudo systemctl start api
echo "api run"

sudo systemctl enable mongodb
sudo systemctl enable ui
sudo systemctl enable api
