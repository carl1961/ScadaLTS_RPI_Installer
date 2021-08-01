
#Carl Shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021
echo "Welcome to ScadaLTS installer!"
sleep 2
echo

cd
apt-get update

echo "Installing Tomcat"
sleep 2
#move to install folder
cd /home/pi/ScadaLTS_RPI_Installer

#unpacking the file     
tar vzxf apache-tomcat-9.0.50.tar.gz
#create tomcat directory:
mkdir -p /opt/tomcat
#moving the downloaded file to the tomcat folder
mv apache-tomcat-9.0.50 /opt/tomcat/

cd

echo "Installing Default Jdk"
sleep 2
#install java 11
apt install -y default-jdk

echo "Configure environment variables"

echo "export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-armhf"" >> ~/.bashrc
#echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-7.0.96"" >> ~/.bashrc
echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-9.0.50"" >> ~/.bashrc
source ~/.bashrc

echo "Install Tomcat init.d "
sleep 2
#copy the startup script to /etc/init.d folder
cd /home/pi/ScadaLTS_RPI_Installer
mv tomcat /etc/init.d

cd 
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

# RXTX 
# if not available in PM, try http://neophob.com/files/rxtx-2.2pre5-src.zip
#Installing LibRXTX-java     

apt install -y librxtx-java

echo " Securing MySQL DB... Create password"
## DB configuration
# Refs: https://mariadb.com/kb/en/library/mysql_secure_installation/
mysql_secure_installation

# create database scadalts if not exist
mysql -uroot -p -e "create user 'scadalts'@'localhost' identified by 'scadalts'; \
    create database if not exists scadalts; \
    grant all privileges on scadalts.* to 'scadalts'@'localhost'; \
    flush privileges;"
    

echo "Installing Scada-LTC "
sleep 2
cd /home/pi/ScadaLTS_RPI_Installer
mv ScadaBR.war /opt/tomcat/apache-tomcat-9.0.50/webapps/

echo "Starting Tomcat to Deploy ScadaBR.war  "
sleep 2
#start Tomcat
cd

echo "Tomcat Restarted" 
sleep 2
cd /opt/tomcat/apache-tomcat-9.0.50/bin
chmod +x catalina.sh	
#./catalina.sh
chmod +x startup.sh
#./startup.sh
service tomcat restart
sleep 30

#echo "Stopping Tomcat to finish installing  ScadaLTS "
#cd /opt/tomcat/apache-tomcat-7.0.96/bin
#cd /opt/tomcat/apache-tomcat-9.0.50/bin

#chmod +x shutdown.sh
#./shutdown.sh
#sleep 30
cd /home/pi/ScadaLTS_RPI_Installer
#sudo rm /opt/tomcat/apache-tomcat-7.0.96/webapps/ScadaBR/WEB-INF/classes/env.properties
sudo rm /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/env.properties
cp env.properties /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/env.properties

#echo "Removing install folder"
#cd 
#sudo rm -rf ScadaLTS_RPI_Installer

#echo "Removing ScadaBR.war file"
#sudo rm /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR.war

#sudo rm /opt/tomcat/apache-tomcat-7.0.96/webapps/ScadaBR.war

echo "ScadaLTS Install Complete!"
sleep 3
echo "Rebooting System"
sleep 3
sudo reboot
