#! /bin/bash

# `:-` or `:=` soft assignment, 預設值賦值
# VARIABLE=${SOME_VAR:-default_value}
# VARIABLE=${SOME_VAR:=default_value}

A=${A:-'1'}
echo $A

A=${A:='2'}
echo $A

# `-` or `=` 只有當變數未定義時使用預設值

A=''
A=${A:-'3'}
echo $A

A=''
A=${A-'4'}
echo $A

A=${B-'5'}
echo $A

A=${B='6'}
echo $A

# :? 用於錯誤處理
# ${var:?error_message}  # 如果 var 為空或未定義，輸出錯誤訊息並退出

# :+ 用於替代值
# ${var:+replacement}    # 如果 var 存在且不為空，則使用 replacement

# 配置檔案範例
DB_HOST=${DB_HOST:-"localhost"}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-"postgres"}
DB_PASSWORD=${DB_PASSWORD:-""}
DB_NAME=${DB_NAME:-"myapp"}

# # 檢查必要的配置
# if [ -z "$DB_PASSWORD" ]; then
#     echo "錯誤：需要設定資料庫密碼"
#     exit 1
# fi

echo "資料庫配置："
echo "主機：$DB_HOST"
echo "埠口：$DB_PORT"
echo "使用者：$DB_USER"
echo "資料庫：$DB_NAME"


# escape $

echo "use of backslash to escape \$"
A=1

echo "$A"
echo '$A'
echo \$A
echo \044A
echo "\044A"
echo '\044A'
echo -e "\044A"


# echo -e 用於解析轉義字符
# 
# \a 發出警告聲。
# \b 刪除前一個字符。
# \c 最後不加上換行符號。
# \f 換行但光標仍舊停留在原來的位置。
# \n 換行且光標移至行首。
# \r 光標移至行首，但不換行。
# \t 插入tab。
# \\ 插入\字符。

echo -e "Hello\nWorld"
echo -e "Hello\tWorld"
echo -e "Hello\bWorld"
echo -e "Hello\fWorld"
echo -e "Hello\rWorld"
echo -e "Hello\aWorld"
echo -e "Hello\\World"

# echo -e "\033[背景顏色;字體顏色m <字符串> \033[0m"

# 背景顏色範圍：[40-49]
# 40:黑 41:深紅 42:綠 43:黃色 44:藍色 45:紫色 46:深綠 47:白色
# 字體顏色範圍：[30-39]
# 30:黑 31:紅 32:綠 33:黃 34:藍色 35:紫色 36:深綠 37:白色

echo -e "\033[43;31m大家好，我是黃底紅字！\033[0m"