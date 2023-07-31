install_zoneminder() {
  sudo apt-get -y update
  sudo apt-get -y install apache2 mysql-server php
  sudo systemctl enable --now apache2 mysql
  systemctl status apache2 mysql --no-pager -l
  sudo add-apt-repository -y ppa:iconnor/zoneminder-1.36
  sudo apt-get -y update
  sudo apt-get -y install zoneminder
  sudo rm /etc/mysql/my.cnf
  sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
  echo "sql_mode = NO_ENGINE_SUBSTITUTION" | sudo tee -a /etc/mysql/my.cnf >/dev/null
  sudo chmod 740 /etc/zm/zm.conf
  sudo chown root:www-data /etc/zm/zm.conf
  sudo chown -R www-data:www-data /usr/share/zoneminder/
  sudo a2enmod cgi rewrite expires headers
  sudo a2enconf zoneminder
  sudo sed -i '/\[Date\]/a date.timezone = Africa/Johannesburg' /etc/php/*/apache2/php.ini
  sudo systemctl enable zoneminder
  sudo systemctl start zoneminder
  sudo systemctl reload apache2
  # acccess at http://127.0.0.1/zm
}
