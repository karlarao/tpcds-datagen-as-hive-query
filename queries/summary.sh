cat /dev/null > summary.log

for F in `ls *.sql.log`;
do
     grep --color -H -e "INFO  : Compile Query" -e "INFO  : Prepare Plan" -e "INFO  : Submit Plan" -e "INFO  : Start DAG" -e "INFO  : Run DAG" -e " rows selected (" -e " row selected (" $F | tee -a summary.log
done


     sed 's/.sql.log.*/ /g' summary.log | uniq > queries.log
     grep --color -e "INFO  : Compile Query" summary.log | sed 's/.*.sql.log:INFO  : Compile Query[ ]*/ /g' | sed 's/s$//g' > compile.log
     grep --color -e "INFO  : Prepare Plan" summary.log | sed 's/.*.sql.log:INFO  : Prepare Plan[ ]*/ /g' | sed 's/s$//g' > prepare.log
     grep --color -e "INFO  : Submit Plan" summary.log | sed 's/.*.sql.log:INFO  : Submit Plan[ ]*/ /g' | sed 's/s$//g'> submit.log
     grep --color -e "INFO  : Start DAG" summary.log | sed 's/.*.sql.log:INFO  : Start DAG[ ]*/ /g' | sed 's/s$//g' > submitdag.log
     grep --color -e "INFO  : Run DAG" summary.log | sed 's/.*.sql.log:INFO  : Run DAG[ ]*/ /g' | sed 's/s$//g' > rundag.log

# paste queries.log  compile.log prepare.log submit.log submitdag.log rundag.log
# Try join which will be more reliable



grep -i -e "row selected" -e "rows selected" *.log | sed 's/.sql.*(/ /g' | sed 's/ seconds)//g' | awk -F" " '{a[$1]=a[$1]?a[$1]" "$2:$2; mi[$1]=mi[$1]?(mi[$1]>$2?$2:mi[$1]):$2;  ma[$1]=$2>ma[$1]?$2:ma[$1];  }END{for (i in a)print i, a[i], ma[i], mi[i], (ma[i]-mi[i])*100/ma[i];}' | sort | showtable -d ' ' 
