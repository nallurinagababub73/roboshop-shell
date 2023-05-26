echo "\e[31m Install nginx \e[0m"
yum install nginx -y

echo "\e[31m Removing default content \e[0m"
rm -rf /usr/share/nginx/html/*

echo "\e[31m Downloading frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo "\e[31m Changing directory to html \e[0m"
cd /usr/share/nginx/html

echo "\e[31m Unzipping the frontend files \e[0m"
unzip /tmp/frontend.zip

echo "\e[31m Restart Nginx \e[0m"
systemctl enable nginx
systemctl restart nginx