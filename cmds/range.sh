#! /bin/bash

# brace expansion 需要 bash 3.0 以上版本

for i in {1..10}; do
    echo -n "$i "
done

echo {0..10}
echo {a..z}
echo {A..Z}

echo {apple,banana,cherry}
# range 0.1 ~ 0.9
echo 0.{1..9}

# zero-padded
# echo {01..100} # not work
printf "%02d " {1..10}

# nested brace expansion
echo {1..3}{a..c}

# seq 在某些系統可能不可用
# jot 主要在 macOS 上可用

for i in $(seq 1 10); do
    echo -n "$i "
done

for i in $(seq 1 2 10); do
    echo -n "$i "
done

for ((i=1; i<=10; i++)); do
    echo -n "$i "
done


# random

# # 使用 shuf（Linux）
# shuf -i 1-10 -n 5  # 從 1-10 中隨機選 5 個數

# # 使用 jot（macOS）
# jot -r 5 1 10      # 從 1-10 中隨機選 5 個數

function shuffle() {
  case "$(uname)" in
  Darwin*)
    jot -r 5 1 10
    ;;
  CYGWIN* | MINGW*)
    echo "not supported"
    ;;
  *)
    shuf -i 1-10 -n 5
    ;;
  esac
}

shuffle