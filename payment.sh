echo -e "\e[32m Installing Python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/logs

echo -e "\e[32m Creating roboshop useradd \e[0m"
useradd roboshop &>>/tmp/logs

echo -e "\e[32m Creating app directory \e[0m"
mkdir /app &>>/tmp/logs

echo -e "\e[32m Downloading payment app content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/logs

echo -e "\e[32m Extracting app content \e[0m"
cd /app
unzip /tmp/payment.zip &>>/tmp/logs

echo -e "\e[32m Downloading dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/logs

echo -e "\e[32m Coping payment service file \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/logs

echo -e "\e[32m Starting payment service \e[0m"
systemctl daemon-reload &>>/tmp/logs
systemctl enable payment &>>/tmp/logs
systemctl start payment &>>/tmp/logs



