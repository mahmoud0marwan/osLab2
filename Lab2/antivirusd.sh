#!/bin/bash
echo "Antivirus System is running"
ls -l $1 >dir.new
while  diff -q dir.new dir.last > /dev/null;do
sleep $3
ls -l $1 >dir.new
done
x=$(grep -ilE "virus|trojan|malware|worm|ransomware" $1/* 2>/dev/null)
    for file in $1/*; do
        if [[ "$file" =~ \.(exe|bat|vbs|scr|ps1)$ ]]; then
            x="$x"$'\n'"$file"
        fi
    done
    if [ -n "$x" ]; then
        while IFS= read -r file; do
            [ -n "$file" ] || continue

            cp -- "$file" $2/
            rm -- "$file"

            echo "$file is malicious and it is deleted"
        done <<< "$(printf '%s\n' "$x" | sort -u)"
    fi
ls -l $1 >dir.last


