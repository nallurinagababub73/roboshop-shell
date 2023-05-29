col="\e[33m"
nocol="\e[0m"
log_path="/tmp/logs"
project_dir="/app"

nodejs() {
  echo -e "${col} Setting up nodejs repo ${nocol}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_path}

  echo -e "${col} Install nodejs ${nocol}"
  yum install nodejs -y &>>${log_path}

  app_presetup
  npm_dep
  systemd_setup
}

app_presetup() {
  echo -e "${col} Creating roboshop user ${nocol}"
  useradd roboshop &>>${log_path}

  echo -e "${col} Creating app directory ${nocol}"
  rm -rf ${project_dir} &>>${log_path}
  mkdir ${project_dir} &>>${log_path}

  echo -e "${col} Downloading ${component} app content ${nocol}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_path}

  echo -e " ${col} Exatracting ${component} content ${nocol} "
  cd ${project_dir} &>>${log_path}
  unzip /tmp/${component}.zip &>>${log_path}
}

mongodb_schema() {
  echo -e "${col} Installing mongodb ${nocol}"
  cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_path}
  yum install mongodb-org-shell -y &>>${log_path}

  echo -e "${col} Loading schema ${nocol}"
  mongo --host mongodb-dev.devopshemasri.online <${project_dir}/schema/${component}.js &>>${log_path}

}

systemd_setup() {
  echo -e "${col} Coping ${component} service file ${nocol}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_path}

  echo -e "${col} Restarting ${component} service ${nocol}"
  systemctl daemon-reload &>>${log_path}
  systemctl enable ${component} &>>${log_path}
  systemctl restart ${component} &>>${log_path}
}

npm_dep() {
  echo -e "${col} Installing dependencies ${nocol}"
  cd ${project_dir} &>>${log_path}
  npm install &>>${log_path}
}

maven() {
  echo -e "${col} Installing maven ${nocol}"
  yum install maven -y &>>${log_path}

  app_presetup
  maven_dep
  systemd_setup
}
maven_dep() {
  echo -e "${col} Downloading dependencies ${nocol}"
  cd ${project_dir} &>>${log_path}
  mvn clean package  &>>${log_path}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_path}
}

mysql_schema() {
  echo -e "${col} Installing mysql ${nocol}"
  yum install mysql -y &>>${log_path}

  echo -e "${col} Schema loading ${nocol}"
  mysql -h mysql-dev.devopshemasri.online -uroot -pRoboShop@1 <${project_dir}/schema/${component}.sql &>>${log_path}

}
python() {
  echo -e "${col} Installing Python ${nocol}"
  yum install python36 gcc python3-devel -y &>>${log_path}

  app_presetup
  python_dep
  systemd_setup

}
python_dep() {
  echo -e "${col} Downloading dependencies ${nocol}"
  cd ${project_dir}
  pip3.6 install -r requirements.txt &>>${log_path}
}

