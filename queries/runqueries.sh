#!/bin/bash

for F in `ls query*.sql`;
do
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>$F.1.log;
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>$F.2.log;
    beeline -u "jdbc:hive2://localhost:10001/;transportMode=http" -i /home/sshuser/tpcds-datagen-as-hive-query/queries/settings.hql -f $F &>$F.3.log;
done
