echo -e "\e[32m Disable the mysql 8 version  \e[0m"
yum module disable mysql -y &>>/tmp/logs

echo -e "\e[32m Coping the mysql repo file \e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/logs

echo -e "\e[32m Installing Mysql \e[0m"
yum install mysql-community-server -y &>>/tmp/logs

echo -e "\e[32m Restarting the mysqld \e[0m"
systemctl enable mysqld &>>/tmp/logs
systemctl start mysqld &>>/tmp/logs

echo -e "\e[32m  \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/logs