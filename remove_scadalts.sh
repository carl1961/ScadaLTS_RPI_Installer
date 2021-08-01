#installation of scadabr and tomcat7
#autor: carlos j. oliveira 
#email: oliveira.carlos1@outlook.com.br
#date 11/25/2019
# Mod to install scadalts by carl shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021


echo "Stop running tomcat instances"
sudo service tomcat stop


# Delete all files from ScadaLTS installation
echo "Removing tomcat and ScadaLTS folders..."
rm -rf /opt/tomcat
echo "Removing install files..."
rm /etc/init.d/tomcat
rm -rf ScadaLTS_RPI_32bit_OS_Installer

echo "ScadaLTS was successfully removed."
