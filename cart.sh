source common.sh
component="cart"

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




