component="catalogue"
echo -e "\e[32m Setting up nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/logs

echo -e "\e[32m Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/logs

echo -e "\e[32m Creating roboshop user \e[0m"
useradd roboshop &>>/tmp/logs

echo -e "\e[32m Creating app directory \e[0m"
rm -rf /app &>>/tmp/logs
mkdir /app &>>/tmp/logs

echo -e "\e[32m Downloading ${component) app content \e[0m"
curl -o /tmp/${component).zip https://roboshop-artifacts.s3.amazonaws.com/${component).zip &>>/tmp/logs

echo -e "\e[32m Exatracting ${component) content \e[0m"
cd /app &>>/tmp/logs
unzip /tmp/${component).zip &>>/tmp/logs

echo -e "\e[32m Installing dependencies \e[0m"
cd /app &>>/tmp/logs
npm install &>>/tmp/logs

echo -e "\e[32m Coping ${component) service file \e[0m"
cp /home/centos/roboshop-shell/${component).service /etc/systemd/system/${component).service &>>/tmp/logs

echo -e "\e[32m Restarting ${component) service \e[0m"
systemctl daemon-reload &>>/tmp/logs
systemctl enable ${component) &>>/tmp/logs
systemctl restart ${component) &>>/tmp/logs

echo -e "\e[32m Installing mongodb \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/logs
yum install mongodb-org-shell -y &>>/tmp/logs

echo -e "\e[32m Loading schema \e[0m"
mongo --host mongodb-dev.devopshemasri.online </app/schema/${component).js &>>/tmp/logs

