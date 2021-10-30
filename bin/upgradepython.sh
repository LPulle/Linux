#!/bin/bash
#2.7
sudo -H pip2 install --upgrade pip
sudo -H pip2 install --upgrade setuptools pip
sudo -H python -m pip install --upgrade pip
sudo -H  pip2 install -U $(pip2 freeze | cut -d '=' -f 1 | sed -e '/pycairo/d' | sed -e '/pyusb/d') #exclude pycairo and pyusb
#3.6
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools pip
sudo -H python3.6 -m pip install --upgrade pip
sudo -H pip3 install -U $(pip3 freeze | cut -d '=' -f 1 | sed -e '/pycairo/d' | sed -e '/pyusb/d') #exclude pycairo and pyusb
#3.7
sudo -H /usr/local/bin/pip3.7 install --upgrade pip
sudo -H /usr/local/bin/pip3.7 install --upgrade setuptools pip
sudo -H /usr/local/bin/python3.7 -m pip install --upgrade pip
sudo -H pip install -U $(pip freeze | cut -d '=' -f 1)
sudo -H /usr/local/bin/pip3.7 install -U $(/usr/local/bin/pip3.7 freeze | cut -d '=' -f 1 | sed -e '/pycairo/d' | sed -e '/pyusb/d') #exclude pycairo and pyusb
