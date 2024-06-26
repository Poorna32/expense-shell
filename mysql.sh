source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo "Input password is missing"
  exit 1
fi

Print_Task_Heading "Install Mysql Server "
dnf install mysql-server -y  &>>$LOG
check_status $?

Print_Task_Heading "start Mysql Service"
systemctl enable mysqld  &>>$LOG
systemctl start mysqld  &>>$LOG
check_status $?

Print_Task_Heading "setup Mysql Password"
echo 'Show Databases' |mysql -h mysql-dev.poornachandra3.online -uroot -p${mysql_root_password} &>>$LOG
if [ $? -ne 0 ]; then
  mysql_secure_installation --set--root-pass ${mysql_root_password} &>>$LOG
fi
check_status $?