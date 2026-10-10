#!/bin/bash
shopt -s nullglob
echo "restore tool is running"
k=1
while [ "$k" -ne 0 ] 
do
x=()
for file in "$2"/*; do
            x+=("$file")
done
if [[ ${#x[@]} -eq 0 ]] ; then
echo "no malicious files to review."
echo "no malicious files to review.">>terminal.log
break
fi
j=0
echo "choose the file"
for i in "${x[@]}"; do
echo "$i [$j] "
((j++))
done
read num
echo "[1]restore [2]permanently delete [3]go back to the list [0]end"
read k
if [ "$k" -eq 1 ]; then
cp -- "${x[$num]}" "$1"/
rm -- "${x[$num]}"
echo "restored ${x[$num]} to $1"
echo "restored ${x[$num]} to $1">>terminal.log
fi
if [ "$k" -eq 2 ]; then
rm -- "${x[$num]}"
echo "${x[$num]} permanently deleted"
echo "${x[$num]} permanently deleted">>terminal.log
fi
done
