#!/bin/bash
sudo dnf update -y

sudo dnf install httpd -y

sudo systemctl enable --now httpd

sudo dnf install mariadb-server -y

sudo systemctl enable --now mariadb

sudo mysql_secure_installation

sudo dnf install php php-mysqlnd php-cli php-gd php-xml php-mbstring -y

sudo systemctl restart httpd

echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
