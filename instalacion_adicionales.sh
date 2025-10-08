#!/bin/bash

#echo "Actualizando el sistema..."
sudo dnf update -y

#echo "Instalando Apache..."
sudo dnf install httpd -y
sudo systemctl enable --now httpd

#echo "Instalando MariaDB..."
sudo dnf install mariadb-server -y
sudo systemctl enable --now mariadb

#echo "Configurando seguridad de MariaDB..."
sudo mysql_secure_installation

#echo "Instalando PHP y extensiones necesarias..."
sudo dnf install php php-mysqlnd php-cli php-gd php-xml php-mbstring php-json -y
sudo systemctl restart httpd

#echo "Instalando wget (descargas web)..."
sudo dnf install wget -y

#echo "Instalando Adminer..."
sudo mkdir -p /var/www/html/adminer
sudo wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php
sudo chown -R apache:apache /var/www/html/adminer

#echo "Instalando phpMyAdmin..."
cd /var/www/html
sudo wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
sudo tar -xvzf phpMyAdmin-latest-all-languages.tar.gz
sudo mv phpMyAdmin-*-all-languages phpmyadmin
sudo chown -R apache:apache /var/www/html/phpmyadmin
cd phpmyadmin
sudo cp config.sample.inc.php config.inc.php
sudo sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg['blowfish_secret'] = 'FraseSecreta123!';/" config.inc.php

#echo "Instalación completa."
#echo "Accede a:"
echo " - Adminer: http://localhost/adminer"
echo " - phpMyAdmin: http://localhost/phpmyadmin"
