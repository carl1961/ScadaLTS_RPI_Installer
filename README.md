# WORK IN PROGRESS

## ScadaLTS Installer for Rasberry PI

- Tested on (Buster 32bit RPI 4)

## ScadaLTS Installation:
- Download the sources 
 

git clone https://github.com/carl1961/ScadaLTS_RPI_32bit_OS_Installer.git

- Move to install folder

#### cd ScadaLTS_RPI_32bit_OS_Installer

- Give execute permissions to `install_scadalts.sh`
 
#### sudo chmod +x install_scadalts.sh

- To install ScadaLTS, run the script `install_scadalts.sh` using the command `./install_scadalts.sh`
You may have to answer Y for some installs
#### sudo ./install_scadalts.sh

## Remove ScadaLTS Installation:
- Download the sources 
- 
wget https://raw.githubusercontent.com/carl1961/ScadaLTS_RPI_32bit_OS_Installer/main/remove_scadalts.sh

- Give execute permissions to`remove_scadalts.sh` 
 
#### sudo chmod +x remove_scadalts.sh

- To remove ScadaBR, run the `remove_scadalts.sh` script via the command `./remove_scadalts.sh`

#### sudo ./remove_scadalts.sh

## Note: 

When installing MariaDB Server, mysql_secure_installation will prompt, just hit enter

Just follow the prompts to set a password for the root user and to secure your MySQL installation.

For a more secure installation, you should answer “Y” to all prompts when asked to answer “Y” or “N“.

These prompts will remove features that allows someone to gain access to the server easier.

Make sure you write down the password you set during this process 

When you see this  just type quit 

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
Enter password:


To access your Raspberry Pi’s MySQL server and start making changes to your databases, you can enter the following command.

####sudo mysql -u root -p

 You will be prompted to enter the password that you just created.


#### In web browser type   http://localhost:8080/ScadaBR  or IP address http://xxx.xxx.xxx.xxx:8080/ScadaBR
