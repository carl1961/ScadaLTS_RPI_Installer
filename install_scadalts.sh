#Carl Shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021
echo "Welcome to ScadaLTS installer!"
sleep 2
apt-get update
echo "Installing Tomcat"
sleep 2

tar vzxf apache-tomcat-9.0.50.tar.gz
#incase this is a reinstall
rm -rf /opt/tomcat
sudo mkdir -p /opt/tomcat
sudo mv apache-tomcat-9.0.50 /opt/tomcat/

echo "Installing Default Jdk"
sleep 2
#install java 11
apt install -y default-jdk

echo "Configure environment variables"

echo "export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-armhf"" >> ~/.bashrc
#echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-7.0.96"" >> ~/.bashrc
echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-9.0.50"" >> ~/.bashrc

source  ~/.bashrc

echo "Install Tomcat init.d "
sleep 2
#copy the startup script to /etc/init.d folder

cp tomcat /etc/init.d

chmod +x /etc/init.d/tomcat
update-rc.d tomcat defaults

#configure variable

 cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-armhf
CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.50
EOL
 
 
echo "Install MariaDB Server"
sleep 2
# MySQL/MariaDB
apt install -y mariadb-server

# MySQL connector
apt install -y libmariadb-java

apt install -y librxtx-java

sudo systemctl enable mariadb
sudo systemctl start mariadb

root_password=admin
 
# Make sure that NOBODY can access the server without a password

sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$root_password') WHERE User = 'root'"
 
# Kill the anonymous users
sudo mysql -e "DROP USER IF EXISTS ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
sudo mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"
# Kill off the demo database
sudo mysql -e "DROP DATABASE IF EXISTS test"
 
echo "Creating scadalts database..."
sleep 2 
sudo mysql -e "create user 'scadalts' identified by 'scadalts'"
sudo mysql -e "create database if not exists scadalts"
sudo mysql -e "grant all privileges on scadalts.* to 'scadalts'"
sudo mysql -e "flush privileges"


echo "Installing Scada-LTC "
sleep 2

mkdir -p /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR

unzip ScadaBR.war -d /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR
sudo rm /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/env.properties
cp env.properties /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/

sleep 2


#echo "Removing install folder"
 
#sudo rm -rf ScadaLTS_RPI_Installer

#echo "Removing ScadaBR.war file"

echo "ScadaLTS Install Complete!"


