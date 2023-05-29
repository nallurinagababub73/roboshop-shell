source common.sh
component="user"

nodejs
app_presetup

echo -e "${col} Installing dependencies ${nocol}"
cd ${project_dir} &>>${log_path}
npm install &>>${log_path}

echo -e "${col} Coping ${component} service file ${nocol}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_path}

echo -e "${col} Restarting ${component} service ${nocol}"
systemctl daemon-reload &>>${log_path}
systemctl enable ${component} &>>${log_path}
systemctl restart ${component} &>>${log_path}

echo -e "${col} Installing mongodb ${nocol}"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_path}
yum install mongodb-org-shell -y &>>${log_path}

echo -e "${col} Loading schema ${nocol}"
mongo --host mongodb-dev.devopshemasri.online <${project_dir}/schema/${component}.js &>>${log_path}
