#! /bin/bash

# The single bracket [ is a shell built-in command 
# that has always been available in Unix and Linux to evaluate expressions.
#  It still exists for backward compatibility and POSIX compliance.

# The double bracket [[ ]] is a `shell keyword` that was introduced in Bash 3.0.
# It provides more powerful and flexible expression evaluation capabilities.
# It is not POSIX-compliant, but it is widely supported in modern Unix-like operating systems.

# In most cases, it is recommended to use [[ syntax, as it is more powerful and POSIX-compliant.
# Only use [ syntax when you need to write scripts that are POSIX-compliant.

# we can use comparison operators directly without escaping in double brackets

[[ 1 < 2 ]] && echo "1 is less than 2"
[ 1 \< 2 ] && echo "1 is less than 2"

# we can use logical operators directly in double brackets
[[ 1 < 2 && 2 < 3 ]] && echo "1 is less than 2 and 2 is less than 3"
[[ 1 < 2 || 2 < 3 ]] && echo "1 is less than 2 or 2 is less than 3"

# we can use string comparison operators directly in double brackets
[[ "a" == "a" ]] && echo "a is equal to a"
[[ "a" != "b" ]] && echo "a is not equal to b"

# we can use regular expressions directly in double brackets
[[ "hello" =~ ^h.*o$ ]] && echo "hello matches the pattern"

# pattern matching without path expression
name="Alice"
[[ $name = *c* ]] && echo "Name includes c"

# while using [], if there are files with c in their path, it will be test to match to the file name.
# but using double brackets, it will not be matched

