
the dated directories contain listings of certificate program submissions
files are generated with the script: [GIT-root]/python/certificateProgramSplit.py 
based on ExcelData export from Thesis Central 

each directory contains a HEADER.html file with a short explanation and the date of the data export 

the latest link points to the youngest export directory 

to find the date of the last submission in the exported files: 
> cd dated-dir 
> cat $* | awk -F '\t' '{print $4}' | sort -u



