#! /bin/bash

# heredoc: multi-line string
cat << EOF
Hello, world!
second line
third line
EOF

# use another keywords instead of EOF
cat << PPPP
Hello, world!
second line
third line
PPPP

# variables in heredoc will be replaced
# use single quotes or \$ to prevent variables from being replaced
name="Alice"
cat << EOF
Hello, $name!
Now is $(date +'%Y-%m-%d %H:%M:%S')
Now is \$(date +'%Y-%m-%d %H:%M:%S')
EOF

cat << 'EOF'
Hello, $name!
Now is $(date +'%Y-%m-%d %H:%M:%S')
EOF


# to assign a variable by heredoc
text=$(cat << EOF
Hello, $NAME!
EOF
)
echo $text

# write content to a file
cat << EOF > tmp-dir/test.txt
Hello, world!
second line
third line
EOF
