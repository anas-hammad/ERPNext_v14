#!/bin/bash

function Basic_Requirements {
    echo "----------------------------------------------------------------------"
    echo "  The Installation process of the basic requirements begins now"
    echo "----------------------------------------------------------------------"
    read -p "[ Press any key to continue ]: "

    sudo nala update              #update system
    sudo nala install git         #install git

    #install python-dev, python setuptools, python pip and virtual envirome>
    sudo nala install python3-dev
    sudo nala install virtualenv
    sudo nala install python3.10-venv
}
function MariaDB {
     #Installing MariaDB
    echo "----------------------------------------------------------------------"
    echo "  The Installation process of MariaDB begins now"
    echo "----------------------------------------------------------------------"
    read -p "[ Press any key to continue ]: "
    sudo nala install software-properties-common
    sudo nala install mariadb-server
    #Set of instructions to guide the user to install & secure MariaDB
    echo "----------------------------------------------------------------------"
    echo "  ----> Please, read the following instructions <----"
    echo "----------------------------------------------------------------------"
    echo -e "\n In order to install MariaDB, you need the root password; If you have just installed MariaDB, and haven't set the root password yet, press [Enter] to continue"
    echo -e "\n you will be asked few questions, answer all questions with yes [Y]"
    read -p "Did you read the Instructions mentioned above? [Press any key to continue]: "  
    sudo mysql_secure_installation
    sudo nala install libmysqlclient-dev

    #copying conf to MariaDB folder
    cat mariadb-conf.txt >> /etc/mysql/mariadb.conf.d/50-server.cnf
    sudo service mysql restart
}
function Backend_Apps {
        #Installing the backend apps [nvm node js (v18), yarn, redis-server..........etc ]
    echo "----------------------------------------------------------------------"
    echo "  The Installation process of the back-end apps begins now"
    echo "----------------------------------------------------------------------"
    read -p "[ Press any key to continue ]: "
    #install redis server
    sudo nala install redis-server
    sudo nala install curl
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.profile
    nvm install 18
    sudo nala install npm
    sudo npm install -g yarn      #install yarn
    sudo nala install xvfb libfontconfig wkhtmltopdf
}
echo " ----> This script will be installing the requirements of ERPNext v14 <----"
sleep 2
echo -e "\n The installation will be divided into 4 parts"
sleep 2
echo "     1)  Installing the basic requirements"
sleep 2
echo "     2) Installing MariaDB (SQL Database Manager)"
sleep 2
echo "     3) Installing the back-end applications"
sleep 2
echo "     4) Installing bench CLI"

while true;
do
        read -n 1 -p "Do you wish to continue? [ Y/N ]: " CON
        if [ ${CON^} = "Y" ]; then
                echo -e "\n The installation process begins now...."
                sleep 2
                Basic_Requirements
                sleep 2
                MariaDB
                sleep 2
                Backend_Apps
                echo " ##### Reboot your system #####"
                break
        elif [ ${CON^} = "N" ]; then
                echo -e "\n Terminating the process..."
                sleep 2
                break
        else
                continue
        fi
done
