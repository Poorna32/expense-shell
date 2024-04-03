LOG=/tmp/expense.log


Print_Task_Heading(){
  echo $1
  echo "############# $1 ############" &>>$LOG
}

check_status()
{
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}


app_PreReq() {
  Print_Task_Heading "clean the old content"
  rm -rf /${app_dir} &>>$LOG
  check_status $?

  Print_Task_Heading "create app directory"
  mkdir /${app_dir} &>>$LOG
  check_status $?

  Print_Task_Heading "Download the app content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
  check_status $?

  Print_Task_Heading "Extract App Content"
  cd /${app_dir} &>>$LOG
  unzip /tmp/${component}.zip &>>$LOG
  check_status $?

}