echo -e "\e[32m Setting up erlang repo \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/logs

echo -e "\e[32m Setting Rabbitmq repo \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/logs

echo -e "\e[32m Installing Rabbitmq \e[0m"
yum install rabbitmq-server -y &>>/tmp/logs

echo -e "\e[32m Starting rabbitmq \e[0m"
systemctl enable rabbitmq-server &>>/tmp/logs
systemctl start rabbitmq-server &>>/tmp/logs

echo -e "\e[32m Creating rabbitmq user \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/logs
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/logs