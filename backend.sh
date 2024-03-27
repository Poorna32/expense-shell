mysql_root_password=$1

echo disable default nodejs version module
dnf module disable nodejs -y  &>>/tmp/expense.log
echo $?

echo enable nodejs module for v20
dnf module enable nodejs:20 -y &>>/tmp/expense.log

echo $?

echo Install nodejs

dnf install nodejs -y &>>/tmp/expense.log

echo $?

echo adding Application User
useradd expense &>>/tmp/expense.log
echo $?
echo copy backend Service file
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo $?
echo clean the old content
rm -rf /app &>>/tmp/expense.log

echo $?

echo create app directory
mkdir /app &>>/tmp/expense.log

echo $?
echo Download the app content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log

echo $?

echo Extract App Content
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log

echo $?

echo Download nodejs dependencies
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log

echo $?

echo Start Backend Service
systemctl daemon-reload &>>/tmp/expense.log

systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log

echo $?
echo install Mysql Client
dnf install mysql -y &>>/tmp/expense.log

echo $?
echo Load Schema
mysql -h 172.31.37.143 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?