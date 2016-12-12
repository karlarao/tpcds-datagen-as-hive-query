#!/bin/bash

for F in `ls query*.sql`;
do
    echo START `date` &>$F.1.log
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>>$F.1.log;
    echo END `date` &>>$F.1.log
    
    echo START `date` &>$F.2.log
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>>$F.2.log;
    echo END `date` &>>$F.2.log
    
    echo START `date` &>$F.3.log
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>>$F.3.log;
    echo END `date` &>>$F.3.log
done
