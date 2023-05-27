echo -e "\e[32m Install nginx \e[0m"
yum install nginx -y &>>/tmp/logs

echo -e "\e[32m Removing default content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/logs

echo -e "\e[32m Downloading frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/logs

echo -e "\e[32m Changing directory to html \e[0m"
cd /usr/share/nginx/html &>>/tmp/logs

echo -e "\e[32m Unzipping the frontend files \e[0m"
unzip /tmp/frontend.zip &>>/tmp/logs

echo -e "\e[32m Unzipping the frontend files \e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m Restart Nginx \e[0m"
systemctl enable nginx &>>/tmp/logs
systemctl restart nginx &>>/tmp/logs