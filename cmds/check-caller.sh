#!/bin/bash

# caller 的輸出格式
# 行號 呼叫者函數名 腳本檔案名

get_stack_depth() {
    local i=0
    # 計算呼叫堆疊深度
    while caller $i; do
        i=$((i + 1))
    done
    # while caller $i > /dev/null 2>&1; do
    #     i=$((i + 1))
    # done
    echo $i  # 返回堆疊深度
}

function func3() {
    echo -e "Stack depth: \n$(get_stack_depth)"
}

function func2() {
    func3
}

function func1() {
    func2
}

# 測試
func1  # 會顯示堆疊深度
