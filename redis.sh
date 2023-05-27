echo -e "\e[32m Setting up redis repo \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/logs

echo -e "\e[32m Enable redis 6.2 \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/logs

echo -e "\e[32m Installing redis \e[0m"
yum install redis -y &>>/tmp/logs

echo -e "\e[32m Changing listen address \e[0m"
sed -i "s/127.0.0.1/0.0.0.0/" /etc/redis.conf /etc/redis/redis.conf &>>/tmp/logs

echo -e "\e[32m Restaring redis \e[0m"
systemctl enable redis &>>/tmp/logs
systemctl start redis  &>>/tmp/logs