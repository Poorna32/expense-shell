source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ];then
  echo "Input password id missing"
  exit 1
fi

Print_Task_Heading "Install Nginx"
dnf install mysql-server -y  &>>$LOG
Check_status $?

Print_Task_Heading "Install Nginx"
systemctl enable mysqld  &>>$LOG
systemctl start mysqld  &>>$LOG
Check_status $?

Print_Task_Heading "Install Nginx"
mysql_secure_installation --set--root--pass ${mysql_root_password} &>>$LOG
Check_status $?