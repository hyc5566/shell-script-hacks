#! /bin/bash

# 字串替換

# # 替換檔案中的文字並輸出到終端
# sed 's/old/new/g' file.txt

# # 替換並直接修改原檔案 (-i 參數)
# sed -i 's/old/new/g' file.txt

# # 在 macOS 上使用 -i 需要加上備份副檔名（可以是空的）
# sed -i '' 's/old/new/g' file.txt

sed 's/eg/example/g' CHANGELOG.md


# # 使用多個 -e 參數
# sed -e 's/old1/new1/g' -e 's/old2/new2/g' file.txt

# # 或使用分號分隔
# sed 's/old1/new1/g; s/old2/new2/g' file.txt

sed 's/eg/example/g; s/feat/feature/g' CHANGELOG.md


# # 只替換第 5 行
# sed '5s/old/new/g' file.txt

# # 替換 5-10 行
# sed '5,10s/old/new/g' file.txt

# # 從第 5 行開始到最後
# sed '5,$s/old/new/g' file.txt

sed '6s/eg/example/g' CHANGELOG.md
sed '5,10s/eg/example/g' CHANGELOG.md


# 替換檔案內容並創建備份
# sed -i.bak 's/old/new/g' file.txt
# sed -i .bak 's/eg/example/g' CHANGELOG.md


# 使用不同的分隔符（當替換的內容包含斜線時很有用）
sed 's#/bin/bash#/bin/zsh#g' cmds/double_brackets.sh

# 或使用逃脫字符 \/
sed 's/\/bin\/bash/\/usr\/local\/bash/g' cmds/double_brackets.sh
