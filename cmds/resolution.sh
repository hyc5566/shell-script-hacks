#! /bin/bash

# Variable Expansion
NAME="John"
echo $NAME      # 基本的變數展開

# Parameter Expansion
echo ${NAME:-default}  # 帶有默認值的參數展開
echo ${NAME:0:2}      # 字符串切片的參數展開

# Variable Interpolation
echo "Hello, $NAME"    # 字符串中的變數插值

# Variable Substitution
MESSAGE="Value of HOME is $HOME"  # 變數替換

# Complex Parameter Expansion
echo ${NAME/o/a}      # 替換
echo ${NAME^^}        # 轉大寫
