echo -e "\e[32m Coping mongodb repo \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/logs

echo -e "\e[32m Install mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/logs

echo -e "\e[32m Changing mongodb listen address \e[0m"
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf &>>/tmp/logs

echo -e "\e[32m Restarting Mongodb \e[0m"
systemctl enable mongod &>>/tmp/logs

systemctl restart mongod &>>/tmp/logs