# Input / Output

`command > logfile 2>&1` - this writes stdout to file and redirect stderr to stdout. stderr will show up in file

`command 2>&1 > logfile` - this writes stderr to the console, then direct stdout to file. stderr will show up on console but not in file