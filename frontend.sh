source common.sh

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?

Print_Task_Heading "Copy Expense Nginx Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

Print_Task_Heading "Clean old content"
rm -rf /usr/share/nginx/html/* &>>$LOG
check_status $?

Print_Task_Heading "Download App Content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
check_status $?

Print_Task_Heading "Extract App content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOG
check_status $?

Print_Task_Heading "Start Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?
