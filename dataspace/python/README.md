# python helper scripts 

##  split Vireo  Spreadsheet export 

To give certificate program administrators access to thesis suubmitted to their certificate program 
we kwep track of sthesis with multiple certificate program designations in a spreadsheet, export all submitted thesis and 
generate spreadsheets of submissions to each certificate program with the [vireoSpreadSheetSplt.py](vireoSpreadSheetSplt.py) script.

~~~
python vireoSpreadSheetSplit.py --help
~~~

The script requires openpyxl. It is written in Python3.6

* export all thesis in submitted and approved and reviewed state with all possible columns from Vireo to excel spreadsheet
* downlod spreadsheet with additional certificate program information: [Addional Certificate Data](https://docs.google.com/spreadsheets/d/1XsX5Z_49vJ5ze-0LNlA9UbUgDON_KUVHMqqRIapaJCM/edit#gid=0)
* mkdir  dated-dir: yyyy-mm-dd
* add [HEADER.html](HEADER.html) to directory  and adjust date in file
* cd dated-dir
* mkdir xlsx
* copy Thesis and Certificate spreadsheets to xlsx
* run script to generate files in date-dir - see command below
* move the list of tesis without a certificate program designation tp xlsx:  mv None.tsv xlsx
* tar/zip dated dir and copy to server
* ssh to server
* cd /var/www/html/CertificatePrograms/
    * unzip tar file and create dated-dir with newly generated files
    * rm latest
    * ln -s latest dated-dir
    * make sure permissions are set to be world readable:
        * chmod o+r dated-dir/*
        * chmod o+rx dated-dir
* test access with browser:; https://thesis-central.princeton.edu/CertificatePrograms/latest


generate certificate program files in the dated directory 

~~~
python ../vireoSpreadSheetSplt.py  --add_certs xlsx/AdditionalPrograms.xlsx  --thesis xlsx/Thesis.xlsx
~~~


##  import Vireo data to DataSpace 
 
This is a multi step process. Work in a dedicated directory - let's call it dspace

* export spreadsheet of all thesis in all states with all available columns - save to export directory -
* download spreadsheet with additional certificate program information: Addiotional Certificate Data and copy to export dir
* get latest list of restriction requests - - save to dspace directory - available a day after graduation
* enhance restriction request table with vireo IDs
* work by department/certificate program:
    * create named subdirectory in export/cert_program or export/home_dept/
    * export spreadsheet of relevant thesis in all states with all available columns - save to named subdir
    * export same thesis in dspace format - also save in named subdirectory
    * run local [prepare-for-dataspace](prepare-for-dataspace) with export/dir_name as parameter, which
        * uses [python/ehanceAips.py](python/ehanceAips.py)
        * uses [python/sortByStatus.py ](python/sortByStatus.py) to organize submission AIPS into directories according to the submissions state: Approved, Cancelled, ....
        * creates a tar file and copies to scratch - so it can be read on the dataspace VM

Post processing
    * Map thesis with cert programs to cert program collection
        * create new collections as needed


### enhance restriction request table with vireo IDs

add empty column with header 'ID' to spreadsheet - then run enhancement script, which will do its best to find the matching subissions

~~~
python restrictionsFindIds.py -t Thesis.xlsx -r Restrictions.xlsx
~~~
    
The script goes through the restriction requests and either prints the match already chosen or offers possible matches to choose from.
At the end it prompts for a filename where to save the enhanced restrictions spreadsheet.
This process usualy matches most of the requests.
The remaining requests need to be matched manually.


### AIP enhancer


see [python/ehanceAips.py](python/ehanceAips.py)

~~~
python  enhanceAips.py --thesis NAMED_DIR/ExcelExport.xlsx --aips NAMED_DIR/DSpaceSimpleArchive \
                --add_certs GlobalAdditionalPrograms.xlsx --restrictions  GlobalRestrictionsFinalWithId.xlsx
~~~

enhanceAips 
    * generates the metadaa-pu.xml file  and enhances the dublin-core.xml file 
    * adds cover page to the primary thesis pdf 
    * enhances dublin-core.xml   with access metadata if mudd walkin restricted
    * generates metadata-pu.xml  
        * includes additional certificate programs 
        * embargo and mud walking metadata if restricted
    

* all
    * pu.pdf.coverpage          SeniorThesisCoverPage  (if it has primary doc in pdf)
    * pu.date.classyear         current year
    * pu.contributor.authorid   (9-digit student id)
* home department thesis
    * pu.department             1 value
    * pu.certificate            0 -n values
* certificate program thesis
    * pu.certificate            1 value (more is technically possible - doesn't happen in reality)
* if mudd walking restrictions
    * dc.rights.accessRights	Walk-in Access. This thesis can only be viewed on computer terminals at the <a href=http://mudd.princeton.edu>Mudd Manuscript Library</a>.
* if embargo
    * pu.embargo.terms	        07-01-(classyear+embargo-years)

### may not need do it that way

would have to teach [vireoSpreadSheetSplit.py](../vireoSpreadSheetSplit.py)  how to read tsv files

* split submissions into several directories, one for each department and one for each certificate program: 
    *  dspace/home_dept/<DEPT_NAME> 
    *  dspace/cert_program/<CERT_NAME> 
    

split by thesis type 
~~~
python ../vireoSpreadSheetSplit.py --thesis Thesis.xlsx --all_cols --split_col 'Thesis Type'
~~~

split by home department name
~~~
python ../../vireoSpreadSheetSplit.py --thesis Certificate-Program-Thesis.tsv --all_cols --split_col 'Department' --format tsv
~~~

split by certificate program name
~~~
python ../../vireoSpreadSheetSplit.py --thesis Certificate-Program-Thesis.tsv --all_cols --split_col 'Department' --format tsv
~~~




