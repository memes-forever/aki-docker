# SPT-AKI / Server on docker
#### Cross-platform server (Linux, or others)

***

### To Do in the future

* if `./build.sh` - delete all *.js from mods

***

### Before using:

* Install git + git lfs 
```shell 
sudo apt install git
sudo apt install git-lfs
```
* Install docker: https://docs.docker.com/engine/install/ubuntu/
* Install docker-compose 
```shell
sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
```
* Clone aki-docker
```shell
cd ~
git clone https://github.com/memes-forever/aki-docker.git
```

***

### Config

in file .config:

* SPT_AKI_SERVER_BRANCH=`0.13.5.0` or `master` from https://dev.sp-tarkov.com/SPT-AKI/Server.git \
|- `0.13.5.0` - SPT-AKI 3.7.0\
|- `master` - SPT-AKI 3.6.1


* SIT_AKI_SERVER_MOD_BRANCH=`master` or `Aki.3.6` from https://github.com/paulov-t/SIT.Aki-Server-Mod.git \
|- `master` - mod for SPT-AKI 3.7.0\
|- `Aki.3.6` - mod for SPT-AKI 3.6.1


* USE_EXTERNAL_IP_FINDER=`true` or `false`
* EXTERNAL_IP=`0.0.0.0`
* * If in the `.config`->`USE_EXTERNAL_IP_FINDER=true`, \
then the connection to the server must be made using the external IP of the device
* * If you use VPN (zerotier, etc) or local connection, \
then you need change in the `.config`->`USE_EXTERNAL_IP_FINDER=false` and EXTERNAL_IP on you vpn/local ip.


***

### Build and Run AKI Server
* Build server 
```shell 
cd aki-docker
chmod +x ./build.sh && chmod +x ./backup.sh
./build.sh
```
* Update build server 
```shell 
cd aki-docker
git reset --hard
git pull
chmod +x ./build.sh && chmod +x ./backup.sh
./build.sh
```
* Run server 
```shell
docker-compose up
```
* Run server in background
```shell
docker-compose up -d
```


***

### Cron example

* Run backup 
```shell
# every hours
0 * * * * cd /xxxx/aki-docker && ./backup.sh backup_profiles
```

***

### Additional features

#### UPNP auto forwarding ports https://dev.to/jacopobonta/upnp-port-forwarding-1pmd
* Install:
```bash
sudo apt-get install miniupnpc
```
* Settings: 
```bash
# you device local ip
LOCAL_IP=192.168.0.2
upnpc -a $LOCAL_IP 6969 6969 tcp
upnpc -a $LOCAL_IP 6969 6969 udp
upnpc -a $LOCAL_IP 6970 6970 tcp
upnpc -a $LOCAL_IP 6970 6970 udp
```

#### Zerotier VPN
* Install: 
```bash
curl -s https://install.zerotier.com | sudo bash
```
* Connect: 
```bash
sudo zerotier-cli join <you_network>
```

#### Portainer to manage container (read logs or restart, etc)
* Install:
```shell
docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
```
* Connect to `local_ip:9000` in browser
#### Grafana for monitoring (with Prometheus & AlertManager & NodeExporter & cAdvisor) 
* Install:
```shell
cd ~
git clone https://github.com/stefanprodan/dockprom.git
cd dockprom
docker-compose up -d
```
* Connect to `local_ip:3000` in browser

***

Works great on Rock PI 4A \
https://wiki.radxa.com/Rock4 \
![rock pi4a](https://wiki.radxa.com/mw/images/thumb/e/e9/ROCK_4AB.gif/300px-ROCK_4AB.gif)
