#! /bin/bash

# Usage
#   1. awk 'pattern { action }' filename
#   2. ... | awk 'pattern { action }'

# common variables
# $0: the whole line
# $1, $2, $3, ...: the fields in the line
# NF: the number of fields in the line
# NR: the number of lines in the file
# FS: the field separator
# RS: the record separator


# ps aux: show all processes from all users

# fields: USER PID %CPU %MEM VSZ (virtual memory size) 
#         RSS (resident set size) TT (terminal type) STAT (process status) 
#         STARTED TIME COMMAND

# may use "ps aux | head -1" to see these fields

# print the 3rd (CPU) and 11th (COMMAND) fields of each line,
# sort by the 3rd field in descending order, and print the top 5 lines
echo "*******************************************************"
echo "top 5 processes by CPU usage"
ps aux | awk '{print $3 " " $11}' | sort -nr | head -5
echo "*******************************************************"

# count the number of lines where the 1st field (USER) is "chy1010"
echo "*******************************************************"
echo "count the number of lines where the 1st field (USER) is \"chy1010\""
ps aux | awk '$1=="chy1010" {count++} END {print count}'
echo "*******************************************************"

# print the 4th field (CPU) and 11th field (COMMAND) of each line where the 4th field (CPU) is greater than 1.0
echo "*******************************************************"
echo "print the 4th field (CPU) and 11th field (COMMAND) of each line where the 4th field (CPU) is greater than 1.0"
ps aux | awk '$4 > 1.0 {print $4 "% " $11}'
echo "*******************************************************"


# # netstat
# # 列出所有連接埠的使用狀況
# netstat -an | awk '$4 ~ /:/ {print $4}' | cut -d. -f5 | sort -n | uniq
# # 統計連接狀態
# netstat -an | awk '$6 ~ /ESTABLISHED/ {count++} END {print "連接數量: " count}'

# # ifconfig
# 取得 IP 位址
ifconfig | awk '/inet / {print $2}'
# 取得 MAC 位址
ifconfig | awk '/ether/ {print $2}'

# 外部 IP
# curl -s https://api.ipify.org | awk '{print "外部 IP: " $1}'

# # system log
# # 分析系統日誌中的錯誤
# log show --last 1h | awk '/error/ {print}'
# # 統計特定時間內的日誌數量
# log show --last 1d | awk '{count++} END {print "今日日誌數: " count}'



# deal with file
# 使用 printf 美化輸出
ls -l | awk 'BEGIN {printf "%-20s %s\n", "檔案名稱", "大小"} NR>1 {printf "%-20s %s\n", $9, $5}'
