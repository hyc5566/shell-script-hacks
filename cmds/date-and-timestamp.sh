#! /bin/bash

echo "date: $(date)"

echo $(date +%Y-%m-%d\ %H:%M:%S)
echo $(date +%Y-%m-%d" "%H:%M:%S)

# timestamp
echo $(date +%s)

# timestamp of utc+0
echo $(date -u +%Y-%m-%d" "%H:%M:%S)

# 函數：將 timestamp 轉換為指定格式

## use on linux
# timestamp_to_date() {
#     local timestamp=$1
#     date -d "@$timestamp" "+%Y-%m-%d %H:%M:%S"
# }

# 如果是 macOS，使用這個版本：
timestamp_to_date_mac() {
    local timestamp=$1
    date -r "$timestamp" "+%Y-%m-%d %H:%M:%S"
}

# 使用範例
timestamp=1738251800
echo "Timestamp: $timestamp"
echo "Formatted date: $(timestamp_to_date_mac $timestamp)"
