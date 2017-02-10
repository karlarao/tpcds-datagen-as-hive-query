#! /bin/bash

grep --color -e "INFO  : Compile Query" *.sql.*.log | sed 's/.sql.* Query/ /g' | sed 's/s$//g' | awk -F" " '{a[$1]=a[$1]?a[$1]" "$2:$2; mi[$1]=mi[$1]?(mi[$1]>$2?$2:mi[$1]):$2;  ma[$1]=$2>ma[$1]?$2:ma[$1];  }END{for (i in a)print i, a[i] ;}' | sort | showtable -d ' '
