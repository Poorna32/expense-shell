source common.sh

Print_Task_Heading "Install Nginx"
dnf install mysql-server -y  &>>$LOG
Check_status $?

Print_Task_Heading "Install Nginx"
systemctl enable mysqld  &>>$LOG
systemctl start mysqld  &>>$LOG
Check_status $?

Print_Task_Heading "Install Nginx"  &>>$LOG
Check_status $?