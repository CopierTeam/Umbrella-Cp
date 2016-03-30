Umbrella Source (telegram-bot)
============

[Installation](https://github.com/yagop/telegram-bot/wiki/Installation)
------------
```bash
# Tested on Ubuntu 14.04, for other OSs check out https://github.com/yagop/telegram-bot/wiki/Installation
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev
```

```bash
# After those dependencies, lets install the bot
cd $HOME
git clone https://github.com/CopierTeam/umbrella-cp.git
cd uzzbot
./launch.sh install
./launch.sh # Will ask you for a phone number & confirmation code.
```


Run it as a daemon
------------
If your Linux/Unix comes with [upstart](http://upstart.ubuntu.com/) you can run the bot by this way
```bash
$ sed -i "s/yourusername/$(whoami)/g" etc/copier.conf
$ sed -i "s_telegrambotpath_$(pwd)_g" etc/copier.conf
$ sudo cp etc/copier.conf /etc/init/
$ sudo start copier # To start it
$ sudo stop copier # To stop it
```
