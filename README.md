# aki-server-mod-docker

***

### Before using:

* install git `sudo apt install git`
* install git lfs `sudo apt install git-lfs`
* install docker https://docs.docker.com/engine/install/ubuntu/
* install docker-compose `sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose`
* in console: `chmod +x ./build.sh && chmod +x ./backup.sh`

***

### Build and Run AKI Server
* build server `./build.sh`
* in console `docker-compose up`

The first launch will be with an error, as it should be

***

### Cron example

* Run backup `1 * * * * cd /home/xxxx/aki-server && ./backup.sh backup_profiles`

***

Works great on Rock PI 4A \
https://wiki.radxa.com/Rock4 \
![rock pi4a](https://wiki.radxa.com/mw/images/thumb/e/e9/ROCK_4AB.gif/300px-ROCK_4AB.gif)
