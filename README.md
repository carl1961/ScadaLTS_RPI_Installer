# ScadaLTS_RPI_Installer (Buster 32bit)
WORK IN PROGRESS


# ScadaLTS Installer for Rasberry PI (testing on RPI 4)
(modified script from carlos j. oliveira https://sourceforge.net/projects/scada-tomcat7/ )



## ScadaLTS Installation:
- Download the sources 
 
wget clone https://github.com/carl1961/ScadaLTS_RPI_32bit_OS_Installer.git

- Move to install folder

#### cd /ScadaLTS_RPI_32bit_OS_Installer

- Give execute permissions to `install_scadalts.sh`
 
#### sudo chmod +x install_scadalts.sh

- To install ScadaBR, run the script `install_scadalts.sh` using the command `./install_scadalts.sh`
You may have to answer Y for some installs
#### sudo ./install_scadalts.sh

## Remove ScadaLTS Installation:
- Download the sources 
- 
wget https://github.com/carl1961/ScadaLTS_RPI_Installer/raw/main/remove_scadalts.sh

- Give execute permissions to`remove_scadalts.sh` 
 
#### sudo chmod +x remove_scadalts.sh

- To remove ScadaBR, run the `remove_scadalts.sh` script via the command `./remove_scadalts.sh`

#### sudo ./remove_scadalts.sh

Note: When installing, you will be asked for the port to be used in Tomcat and the username/password for tomcat-manager. If you want to do a silent installation, use the `./install_scadalts.sh silent` command. In this mode, Tomcat will be installed on port 8080 and the username and password generated for tomcat-manager will be printed on the terminal.


#### In web browser type   http://localhost:8080/ScadaBR  or IP address http://192.168.1.27:8080/ScadaBR
