#! /bin/bash

# # 基本語法
# if [ $a -eq $b ]; then
#     echo "a 等於 b"
# fi

# # 數值比較運算子
# -eq  # equal (等於)
# -ne  # not equal (不等於)
# -gt  # greater than (大於)
# -lt  # less than (小於)
# -ge  # greater than or equal (大於等於)
# -le  # less than or equal (小於等於)

a=10
b=20

if [ $a -lt $b ]; then
    echo "$a < $b"
elif [ $a -eq $b ]; then
    echo "$a = $b"
else
    echo "$a > $b"
fi

# use test expression <=> square brackets
if test $a -lt $b; then
    echo "$a < $b"
fi


# # 字串比較運算子
#   =    # 等於
#   !=   # 不等於
#   -z   # 字串長度為 0
#   -n   # 字串長度不為 0

str1="hello"
str2="world"

# 檢查字串是否相等
if [ "$str1" = "$str2" ]; then
    echo "字串相等"
fi

# 檢查字串是否為空
if [ -z "$str1" ]; then
    echo "字串為空"
fi


# # 檔案測試運算子
# -e file  # 檔案存在
# -f file  # 是普通檔案
# -d file  # 是目錄
# -r file  # 可讀
# -w file  # 可寫
# -x file  # 可執行
# -s file  # 檔案大小不為 0
# -L file  # 是符號連結


# file="test.txt"
file=$0 # $0 is the script path

# 檢查檔案是否存在
if [ -e "$file" ]; then
    echo "檔案 $file 存在"
else
    echo "檔案 $file 不存在"
fi

# 檢查是否為目錄
if [ -d "$file" ]; then
    echo "檔案 $file 是目錄"
else
    echo "檔案 $file 不是目錄"
fi

# 檢查檔案權限
if [ -r "$file" ] && [ -w "$file" ]; then
    echo "檔案 $file 可讀寫"
fi

# 檢查檔案是否為空
if [ -s "$file" ]; then
    echo "檔案 $file 不為空"
else
    echo "檔案 $file 為空"
fi
