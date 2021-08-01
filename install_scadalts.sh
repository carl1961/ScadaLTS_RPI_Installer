
#Carl Shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021


function checkFiles {
	cd "$INSTALL_FOLDER"
	
    if [[ -f "$tomcat" ]] && [[ -f "$scadalts" ]] ; then
		# Installer files present, continue
		echo "Files present! Lets go to install!"
    else
		# Files not present. Abort
		echo "ERROR:ScadaLTS and/or Tomcat files not found! Aborting." 
		exit 1
    fi
}

# Setting  variables...

MACHINE_TYPE=$(uname -m)
INSTALL_FOLDER=/home/pi/ScadaLTS_RPI_32bit_OS_Installer


# Files
tomcat=apache-tomcat-9.0.50.tar.gz
scadalts=ScadaBR.war


echo "Welcome to ScadaLTS installer!"
echo

case $MACHINE_TYPE in
	arm64 | armv8l | aarch64)
		echo "ARM 64-bit machine detected"
		echo "ERROR: ARM 64-bit Not Supported! Aborting"
		exit
	;;
    
    armv6l | armv7l)
		echo "ARM 32-bit machine detected"
		echo "ARM 32-bit Supported"
	;;
    
	x86_64)
		echo "x86_64 machine detected"
		echo "ERROR: x86_64 Not Supported! Aborting" 
		exit
	;;
    
	*)
		echo "32-bit machine detected"
		echo "This x86 32-bit  Not Supported! Aborting"
		exit
	;;
esac

checkFiles


# Ensure running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cd
apt-get update

echo "Installing Tomcat"
#move to install folder
cd /home/pi/ScadaLTS_RPI_32bit_OS_Installer

#unpacking the file     
tar vzxf apache-tomcat-9.0.50.tar.gz
#create tomcat directory:
mkdir -p /opt/tomcat
#moving the downloaded file to the tomcat folder
mv apache-tomcat-9.0.50 /opt/tomcat/

cd

echo "Installing Default Jdk"
#install java 11
apt install -y default-jdk

echo "Configure environment variables"

echo "export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-armhf"" >> ~/.bashrc
#echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-7.0.96"" >> ~/.bashrc
echo "export CATALINA_HOME="/opt/tomcat/apache-tomcat-9.0.50"" >> ~/.bashrc
source ~/.bashrc

echo "Install Tomcat init.d "

#copy the startup script to /etc/init.d folder
cd /home/pi/ScadaLTS_RPI_32bit_OS_Installer
mv tomcat /etc/init.d


#echo "Configure environment variables"  
#echo "So that the system environment can be configured at startup" 
#cd
#configure variable

#cat >> /etc/environment <<EOL

# JAVA_HOME=/usr/lib/jvm/java-11-openjdk-armhf
# CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.50
# EOL
cd

echo "Install MariaDB Server"

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

cd /home/pi/ScadaLTS_RPI_32bit_OS_Installer
cp ScadaBR.war /opt/tomcat/apache-tomcat-9.0.50/webapps/

echo "Starting Tomcat to Deploy ScadaBR.war  "
#start Tomcat7

cd /opt/tomcat/apache-tomcat-9.0.50/bin
chmod +x catalina.sh	
./catalina.sh
chmod +x startup.sh
./startup.sh
sleep 30
echo "Stopping Tomcat to finish installing  ScadaLTS "
#cd /opt/tomcat/apache-tomcat-7.0.96/bin
cd /opt/tomcat/apache-tomcat-9.0.50/bin

chmod +x shutdown.sh
./shutdown.sh
sleep 30
cd /home/pi/ScadaLTS_RPI_32bit_OS_Installer
#sudo rm /opt/tomcat/apache-tomcat-7.0.96/webapps/ScadaBR/WEB-INF/classes/env.properties
sudo rm /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/env.properties
cp env.properties /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR/WEB-INF/classes/env.properties

#apply the commands
#for defining appropriate permissions and symbolic links for the init script.
cd 
chmod +x /etc/init.d/tomcat
update-rc.d tomcat defaults


echo "Removing install folder"
cd 
sudo rm -rf/ScadaLTS_RPI_32bit_OS_Installer

echo "Removing ScadaBR.war file"
sudo rm /opt/tomcat/apache-tomcat-9.0.50/webapps/ScadaBR.war

#sudo rm /opt/tomcat/apache-tomcat-7.0.96/webapps/ScadaBR.war
