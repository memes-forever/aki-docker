# aki-docker

***

### To Do in the future

* if not ./user/mods/SITCoop/config/coopConfig.json - restart before generate file
* if `./build.sh` - delete all *.js from mods

***

### Before using:

* install git + git lfs 
```shell 
sudo apt install git
sudo apt install git-lfs
```
* install docker: https://docs.docker.com/engine/install/ubuntu/
* install docker-compose 
```shell
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
```
* in console: 
```shell 
chmod +x ./build.sh && chmod +x ./backup.sh
```

***

### Config

in file .config:

* SPT_AKI_SERVER_BRANCH=`0.13.5.0` or `master` from https://dev.sp-tarkov.com/SPT-AKI/Server.git \
|- `0.13.5.0` - SPT-AKI 3.7.0\
|- `master` - SPT-AKI 3.6.1


* SIT_AKI_SERVER_MOD_BRANCH=`0.13.5.0` or `master` from https://github.com/paulov-t/SIT.Aki-Server-Mod.git \
|- `0.13.5.0` - mod for SPT-AKI 3.7.0\
|- `master` - mod for SPT-AKI 3.6.1


* INTERNAL_IP=`0.0.0.0` - **Do not change**


* EXTERNAL_IP=`0.0.0.0`
* * If the SIT mod `coopConfig.json`->`useExternalIPFinder=true`, \
then the connection to the server must be made using the external IP of the device
* * If you use VPN (zerotier, etc) or local connection, \
then you need change in the SIT mod `coopConfig.json`->`useExternalIPFinder=false` and EXTERNAL_IP in `.config` on you vpn/local ip.

***

### Build and Run AKI Server
* build server `./build.sh`
* run server `docker-compose up`
* run server in background `docker-compose up -d`

The first launch will be with an error, as it should be

***

### Cron example

* Run backup `1 * * * * cd /home/xxxx/aki-docker && ./backup.sh backup_profiles`

***

### Additional features

#### Zerotier VPN
* Install: `curl -s https://install.zerotier.com | sudo bash`
* Connect: `sudo zerotier-cli join <you_network>`

#### Portainer to manage container (read logs or restart, etc)
* Install:
```shell
docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
```
* Connect to `local_ip:9000` in browser
#### Grafana for monitoring (with Prometheus & AlertManager & NodeExporter & cAdvisor) 
* Install:
```shell
git clone https://github.com/stefanprodan/dockprom
cd dockprom
docker-compose up -d
```
* Connect to `local_ip:3000` in browser

***

Works great on Rock PI 4A \
https://wiki.radxa.com/Rock4 \
![rock pi4a](https://wiki.radxa.com/mw/images/thumb/e/e9/ROCK_4AB.gif/300px-ROCK_4AB.gif)
