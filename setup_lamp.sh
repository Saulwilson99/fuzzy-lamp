#!/bin/bash

#C Saul Wilson-Spencer
groupadd acedemic-sm
groupadd research-sm
groupadd poststudent-sm
groupadd research-visitor
echo "added groups"

#following users will be added to groups
echo "adding users..."
useradd -m nathk -g academic staff
useradd -m hkleinberg -g academic-staff
useradd -m phernado -g academic-staff
useradd -m jeani -g research-staff
useradd -m bigxuan -g postgrad-students

echo "added users"

#Profiles with passwords
echo "vapourcounty" | passwd --stdin nathk
echo "goatraspberry" | passwd --stdin hkleinberg
echo "theboss" | passwd --stdin phernando
echo "zombiesimpsons" | passwd --stdin jeani

#installing Apache Web Server
echo "Installing Apache Web Server..."
yum install -y httpd
service httpd start
service https status

echo "Apache has been installed and activated."

#Making MariaDB
echo "Installing MariaDB..."
yum install -y mariadb-server
yum install -y php
yum install -y php-mysqli
service mariadb start
service httpd restart
printf '\ny\n1234\n1234\ny\ny\ny\ny\n' | mysql_secure_installation

echo "installed MariDB and activated!"

#Making Index.php main webpage and inputting the file into SQL Server
Service MariaDB start 
mkdir/home/scriptfiles/
wget https://github.com/Saulwilson99/ICA/tree/master/make_associate_database.sql -P /home/scriptfiles/mysql-uroot -p1234 < /home/scriptfiles/make_associates_database.sql
wget https://github.com/Saulwilson99/ICA/tree/master/index.php -P /home/scriptfiles/
chown phernando /home/scriptfiles/index.php
chmod a=rx,u+w /home/scriptfiles/index.php
cp /home/scriptfiles/index.php /var/www/html

#Configuring User's Access to the Web Space
#Create Users Personal Web Space
mkdir /var/www/html/members
mkdir /var/www/html/members/phernando
mkdir /var/www/html/members/nathk
mkdir /var/www/html/members/hkleinberg

mkdir /home/phernando/www
mkdir /home/nathk/www
mkdir /home/hkleinberg/www

#Configuring Links (Symbolic)
ln -s /home/phernando/www /var/www/html/members/phernando
ln -s /home/nathk/www /var/www/html/members/nathk
ln -s /home/hkleinberg/www /var/www/html/members/hkleinberg

#Configuring Users Personal Web Space
echo "Welcome to Phernando's Personal Space" >> /var/www/html/members/phernando/index.html
chown phernando /var/www/html/members/phernando/index.html
chmod a=rx,u=w /var/www/html/members/phernando/index.html
echo "Welcome to NathK's Personal Space" >> /var/www/html/members/nathk/index.html
chown nathk /var/www/html/members/nathk/index.html
chmod a=rx,u=w /var/www/html/members/nathk/index.html
echo "Welcome to Hkleinberg's Personal Space" >> /var/www/html/members/hkleinberg/index.html
chown hkleinberg /var/www/html/members/hkleinberg/index.html
chmod a=rx,u=w /var/www/html/members/hkleinberg/index.html

#Configuring Apache to Allow A Private Pass and Login
mkdir /var/www/html/private
restorecon -r /var/www/html
adduser aclmember
chgrp -R apache /var/www/html/private
chown -R aclmember /var/www/html/private
chmod -R 750 /var/www/html/private
chmod g+s /var/www/html/private
htpasswd -c -b /etc/httpd/passwords aclmember gimmedata
echo"<Directory " /var/www/html/private">
AuthTyoe Basic
AuthName " Restricted Files"
AuthBasicProvider file
AuthUserFile "/etc/httpd/passwords"
Require user aclmember
</Directory>" >> /var/www/html/members/hkleinberg/.config
AllowOverride .config
service httpd restart



