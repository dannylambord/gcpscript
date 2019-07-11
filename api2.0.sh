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

sudo cp pool-manager-api.service ~/../../etc/systemd/system/
sudo cp pool-manager-ui.service ~/../../etc/systemd/system/

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
