source common.sh

app_dir=/usr/share/nginx/html
component=frontend

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?

Print_Task_Heading "Copy Expense Nginx Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

app_PreReq

Print_Task_Heading "Start Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?
