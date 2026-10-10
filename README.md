SIMPLE ANTIVIRUS PROJECT (Lab2)


1. OVERVIEW

This project is a small antivirus and restore tool written in Bash.

antivirusd.sh - watches a folder. When something in the folder changes, it
scans the files. Any file that looks malicious is copied to a quarantine
folder and then deleted from the watched folder.

restore.sh - lets the user look at the quarantined files and either restore
them, permanently delete them, or go back to the list.

Makefile - shortcuts for running the scripts.

terminal.log - log file written by restore.sh.

dir.last and dir.new - working files used by antivirusd.sh to detect changes
(they store the output of ls -l).

Folder hierarchy:

Lab2
|-- Makefile
|-- README.md
|-- antivirusd.sh
|-- restore.sh
|-- terminal.log
|-- dir.last
|-- dir.new
|-- watched/       (folder that is monitored)
|-- malicious/     (quarantine folder, created by "make file")


2. PREREQUISITES

You need Linux with bash, make, grep, diff, sort, cp and rm. On Ubuntu most
of these are already installed. make may not be, so install it with:

    sudo apt update
    sudo apt install make

To check that everything is there:

    bash --version
    make --version
    diff --version


3. HOW TO RUN

Step 1: Open a terminal in the project folder and create the folders.

    mkdir -p watched
    make file

Step 2: Make the scripts executable.

    chmod +x antivirusd.sh restore.sh

Step 3: Run the antivirus.

    make antivirus

This is the same as running:

    ./antivirusd.sh watched malicious 5

The three arguments are:
    1. watched   - the folder to monitor
    2. malicious - the quarantine folder
    3. 5         - seconds to wait between checks

The script prints "Antivirus System is running" and waits. When the contents
of the watched folder change, it scans the folder, moves any malicious files
to the malicious folder, and prints a message like:

    watched/hi.exe is malicious and it is deleted

After one scan it saves the folder listing to dir.last and stops, so run it
again to keep monitoring.

To test it, open a second terminal and add a file to the watched folder:

    echo "this is a virus" > watched/test.txt

Step 4: Run the restore tool.

    make restore

This is the same as running:

    ./restore.sh watched malicious

The arguments are the watched folder and the quarantine folder.

    1. The tool lists the files in the malicious folder, each with a number.
    2. Type the number of the file you want and press Enter.
    3. Choose an action:
         1 - restore the file back to the watched folder
         2 - permanently delete the file
         3 - go back to the list
         0 - end the program
    4. Restores and deletions are written to terminal.log.
    5. When the quarantine folder is empty, the tool prints
       "no malicious files to review." and exits.


4. WHERE THE FLAGGED LISTS ARE DEFINED

Both lists are in antivirusd.sh.

Flagged keywords - line 8. The command
grep -ilE "virus|trojan|malware|worm|ransomware" searches the text inside
each file for these words. To change the keywords, edit the words in that
pattern.

Flagged extensions - line 10. The check
[[ "$file" =~ \.(exe|bat|vbs|scr|ps1)$ ]] flags files that end with .exe,
.bat, .vbs, .scr or .ps1. To change the extensions, edit the list inside the
parentheses.


NOTES

- If you get an error like "bad interpreter" or "^M", the files may have
  Windows line endings. Fix them with:

      sudo apt install dos2unix
      dos2unix antivirusd.sh restore.sh Makefile

- "make all" runs file, antivirus and restore in order, but the restore tool
  only starts after the antivirus script finishes its scan.
