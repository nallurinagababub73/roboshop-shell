echo -e "\e[32m Setting up nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logs

echo -e "\e[32m Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/logs

echo -e "\e[32m Creating roboshop cart \e[0m"
useradd roboshop &>>/tmp/logs

echo -e "\e[32m Creating app directory \e[0m"
rm -rf /app &>>/tmp/logs
mkdir /app &>>/tmp/logs

echo -e "\e[32m Downloading catalogue app content \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/logs

echo -e "\e[32m Exatracting catalogue content \e[0m"
cd /app &>>/tmp/logs
unzip /tmp/cart.zip &>>/tmp/logs

echo -e "\e[32m Installing dependencies \e[0m"
cd /app &>>/tmp/logs
npm install &>>/tmp/logs

echo -e "\e[32m Coping catalogue service file \e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/logs

echo -e "\e[32m Restarting catalogue service \e[0m"
systemctl daemon-reload &>>/tmp/logs
systemctl enable cart &>>/tmp/logs
systemctl restart cart &>>/tmp/logs





