source common.sh


mysql_root_password=$1

#if password id not provided then we will exit

if [ -z "${mysql_root_password}" ];then
  echo "Input password is missing"
  exit 1
fi

Print_Task_Heading "disable default nodejs version module"
dnf module disable nodejs -y  &>>$LOG
check_status $?

Print_Task_Heading "enable nodejs module for v20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

Print_Task_Heading "Install nodejs"
dnf install nodejs -y &>>$LOG
check_status $?

Print_Task_Heading "adding Application User"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
check_status $?

Print_Task_Heading "copy backend Service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

Print_Task_Heading "clean the old content"
rm -rf /app &>>$LOG
check_status $?

Print_Task_Heading "create app directory"
mkdir /app &>>$LOG
check_status $?

Print_Task_Heading "Download the app content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
check_status $?

Print_Task_Heading "Extract App Content"
cd /app &>>$LOG
unzip /tmp/backend.zip &>>$LOG
check_status $?

Print_Task_Heading "Download nodejs dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

Print_Task_Heading "Start Backend Service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

Print_Task_Heading  "install Mysql Client"
dnf install mysql -y &>>$LOG
check_status $?

Print_Task_Heading "Load Schema"
mysql -h 172.31.35.119 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
check_status $?