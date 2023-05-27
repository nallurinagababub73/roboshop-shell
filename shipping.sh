echo -e "\e[32m Installing maven \e[0m"
yum install maven -y &>>/tmp/logs

echo -e "\e[32m Create a roboshop user \e[0m"
useradd roboshop &>>/tmp/logs

echo -e "\e[32m Creating app directiory \e[0m"
mkdir /app &>>/tmp/logs

echo -e "\e[32m Downloading shipping content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/logs

echo -e "\e[32m Extracting the shipping content \e[0m"
cd /app
unzip /tmp/shipping.zip &>>/tmp/logs

echo -e "\e[32m Downloading dependencies \e[0m"
cd /app &>>/tmp/logs
mvn clean package  &>>/tmp/logs
mv target/shipping-1.0.jar shipping.jar &>>/tmp/logs

echo -e "\e[32m Installing mysql \e[0m"
yum install mysql -y &>>/tmp/logs

echo -e "\e[32m Schema loading \e[0m"
mysql -h mysql-dev.devopshemasri.online -uroot -pRoboShop@1 </app/schema/shipping.sql &>>/tmp/logs

echo -e "\e[32m Coping shipping service file \e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/logs

echo -e "\e[32m Restarting the shipping service \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
