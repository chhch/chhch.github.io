---
title: Neos Installation
tags: [neos, php]
---

Benötigte Anwendungen:

```shell
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2
sudo apt-get install php7.2-mysql
sudo apt-get install php7.2-mbstring
sudo apt-get install php7.2-cli
sudo apt-get install php7.2-xdebug
sudo apt-get install php7.2-xml
sudo apt install php-imagick
php -m
curl -s https://getcomposer.org/installer | php
chmod +x composer.phar
php composer.phar create-project --no-dev neos/neos-base-distribution myneos/
```

php7.2-mbstring php7.2-cli php7.2-xdebug php7.2-xml php-imagick

Intellij: Install Neos Plugin by Christian and Fluid Plugin by Stefan

Run `./flow server:run`

Start MariaDB with Docker `docker run --name mariadb -e MYSQL_ROOT_PASSWORD=password -d --publish 3306:3306 mariadb`

---

https://www.getcomposercat.com/
