echo -e "\e[31m Install nginx \e[0m"
yum install nginx -y &>>/tmp/logs

echo -e "\e[31m Removing default content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/logs

echo -e "\e[31m Downloading frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/logs

echo -e "\e[31m Changing directory to html \e[0m"
cd /usr/share/nginx/html &>>/tmp/logs

echo -e "\e[31m Unzipping the frontend files \e[0m"
unzip /tmp/frontend.zip &>>/tmp/logs

echo -e "\e[31m Restart Nginx \e[0m"
systemctl enable nginx &>>/tmp/logs
systemctl restart nginx &>>/tmp/logs