#!/bin/bash
sudo apt update -y
sudo mkdir /home/ubuntu/project
sudo apt install nginx -y
sudo echo "Hi Welcome to the nginx" > /var/www/html/index.html