echo -e "\e[32m Setting up nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logs

echo -e "\e[32m Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/logs

echo -e "\e[32m Creating roboshop user \e[0m"
useradd roboshop &>>/tmp/logs

echo -e "\e[32m Creating app directory \e[0m"
rm -rf /app &>>/tmp/logs
mkdir /app &>>/tmp/logs

echo -e "\e[32m Downloading catalogue app content \e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/logs

echo -e "\e[32m Exatracting catalogue content \e[0m"
cd /app &>>/tmp/logs
unzip /tmp/user.zip &>>/tmp/logs

echo -e "\e[32m Installing dependencies \e[0m"
cd /app &>>/tmp/logs
npm install &>>/tmp/logs

echo -e "\e[32m Coping catalogue service file \e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/logs

echo -e "\e[32m Restarting catalogue service \e[0m"
systemctl daemon-reload &>>/tmp/logs
systemctl enable user &>>/tmp/logs
systemctl restart user &>>/tmp/logs

echo -e "\e[32m Installing mongodb \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/logs
yum install mongodb-org-shell -y &>>/tmp/logs

echo -e "\e[32m Loading schema \e[0m"
mongo --host mongodb-dev.devopshemasri.online </app/schema/user.js &>>/tmp/logs

