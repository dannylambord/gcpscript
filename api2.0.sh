#!bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y mongodb
sudo sed -i 's/127.0.0.1/0.0.0.0/g' ~/../../etc/mongodb.conf
sudo service mongodb start
#sudo apt-get install git
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
node --version
npm --version
yes | sudo npm install -g @angular/cli
ng --version

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

sudo mv api.service /etc/systemd/system/api.service

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


mkdir ~/pool-manager
cd ~/pool-manager
git clone https://github.com/yamileon/poolmanager-api ~/pool-manager/poolmanager-api
git clone https://github.com/yamileon/poolmanage-ui ~/pool-manager/poolmanager-ui
ls -lrt
sudo chown -R "$(whoami)" ~/pool-manager/poolmanager-ui

cd ~/pool-manager/poolmanager-api
git checkout dev
sudo npm install
echo "export const enviroment = { production: false,url:'http://35.246.90.33:8081'};" > ~/pool-manager/poolmanager-ui/src/enviroments/enviroments.ts
cd ~/pool-manager/poolmanager-ui
git checkout dev2.0
yes n | sudo npm install

sudo systemctl daemon-reload

sudo systemctl enable pool-manager-api
sudo systemctl enable pool-manager-ui

sudo systemctl start pool-manager-api
sudo systemctl start pool-manager-ui
