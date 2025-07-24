```
[parksejin@localhost Downloads]$ nano 80_2_shell_variables_read.sh
# nano
V_FIRST_INPUT="$1"
read -p "read input : " V_READ_INPUT
echo "$V_FIRST_INPUT, $V_READ_INPUT"

```
```
[parksejin@localhost Downloads]$ source 80_2_shell_variables_read.sh argument_first
read input : read_first
input values : argument_first, read_first
```