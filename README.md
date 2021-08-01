# WORK IN PROGRESS Running!

## ScadaLTS Installer for Rasberry PI

   - default-jdk_1.11-71
   - apache-tomcat-9.0.50
   - mariadb-server_10.3.29-0
   - Scada-LTS 2.5
 
- Tested on (Buster 32bit RPI 4)

## ScadaLTS Installation:
- Download the sources 
 

git clone https://github.com/carl1961/ScadaLTS_RPI_Installer.git

- Move to install folder

#### cd ScadaLTS_RPI_Installer

- Give execute permissions to `install_scadalts.sh`
 
#### sudo chmod +x install_scadalts.sh

- To install ScadaLTS, run the script `install_scadalts.sh` using the command `./install_scadalts.sh`
You may have to answer Y for some installs
#### sudo ./install_scadalts.sh

## Remove ScadaLTS Installation:
- Download the sources 
- 
wget https://raw.githubusercontent.com/carl1961/ScadaLTS_RPI_Installer/main/remove_scadalts.sh

- Give execute permissions to`remove_scadalts.sh` 
 
#### sudo chmod +x remove_scadalts.sh

- To remove ScadaBR, run the `remove_scadalts.sh` script via the command `./remove_scadalts.sh`

#### sudo ./remove_scadalts.sh

## Note: 

MariaDB Server, and Scada-LTS Database Auto filled by install_scadalts.sh

When Finish, Rasberry PI will reboot after 5 seconds


To access your Raspberry Pi’s MySQL server and start making changes to your databases, you can enter the following command.

####sudo mysql -u root -p

 You will be prompted to enter the password that you just created.


#### In web browser type   http://localhost:8080/ScadaBR  or IP address http://xxx.xxx.xxx.xxx:8080/ScadaBR

## https://github.com/SCADA-LTS/Scada-LTS       scada-lts.org       https://www.facebook.com/ScadaLTS
