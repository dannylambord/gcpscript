sudo apt update

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo apt install -y mongodb

git clone -b furr-dev2 https://github.com/yamileon/poolmanage-ui.git
git clone -b dev https://github.com/yamileon/poolmanager-api.git

cd ~/poolmanage-ui
sudo npm install

cd ~/poolmanager-api
sudo npm install 

echo '[Unit]
Description=ui server
[Service]
User=sulayman_com
WorkingDirectory=/home/sulayman_com/poolmanage-ui
ExecStart=/usr/bin/npm run startg
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/poolmanagerui.service


echo '[Unit]
Description=api server
[Service]
User=yamileon_xfz
WorkingDirectory=/home/sulayman_com/poolmanager-api
ExecStart=/usr/bin/node /home/sulayman_com/poolmanager-api/index.js
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/poolmanagerapi.service

echo "export const environment = {
  production: false,
  url: 'http://"$1":8080'
};" > ~/poolmanage-ui/src/environments/environment.ts

sudo systemctl start poolmanagerapi

sudo systemctl enable poolmanagerapi

sudo systemctl start poolmanagerui

sudo systemctl enable poolmanagerui

sudo systemctl daemon-reload
