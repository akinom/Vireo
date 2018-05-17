# python helper scripts 

##  split Vireo  Spreadsheet export 

To give certificate program administrators access to thesis suubmitted to their certificate program 
we kwep track of sthesis with multiple certificate program designations in a spreadsheet, export all submitted thesis amd 
generate spreadsheets of submissions to each certificate program with the [vireoSpreadSheetSplt.py](vireoSpreadSheetSplt.py) script.

~~~
python vireoSpreadSheetSplt.py --help 
~~~

The script requires openpyxl. It is written in Python3.6

* export all thesis in submitted and approved and reviewed state from Vireo to spreadsheet
* downlod spreadsheet with additional certificate program information: [Addional Certificate Data](https://docs.google.com/spreadsheets/d/1XsX5Z_49vJ5ze-0LNlA9UbUgDON_KUVHMqqRIapaJCM/edit#gid=0) 
* mkdir  dated-dir: yyyy-mm-dd 
* add [HEADER.html](HEADER.html) to directory  and adjust date in file 
* run script to generate files in date-dir - see command below 
* tar/zip dated dir and copy to server 
* ssh to server     
* cd /var/www/html/CertificatePrograms/   
    * unzip tar file and create dated-dir with newly generated files 
    * rm latest
    * ln -s latest dated-dir
    * make sure permissions are set to be word readable 
* test access with browser:; https://thesis-central.princeton.edu/CertificatePrograms/latest 


generate certificate program files 

~~~
~~~