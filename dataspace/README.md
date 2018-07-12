# Export from Vireo - Import to DataSpace #

add  spreadsheet list of all submitted, approved, and under review thesis to export directory
add ID column to restriction request spreadsheet exported from Sharepoint
use [python/restrictionsFindIds.py] to add vireo submission IDs to restriction speadsheet

place prerequisite files into export directory
* AdditionalPrograms.xlsx
* RestrictionsFinalWithId.xlsx

create directory for deprtemt under export
* mkdir  export/$dept
* export thesis information spreadsheet and save to export/$dept/ExcelExport.xlsx
* export dspace simple archive directory and move submission directories to export/$dept

run script to enhance metadata with restriction and additionl certificate program information
~~~
prepare-for-dataspace export/$dept
~~~

the script upon the first encountered error - Fix IT !

upon success it copies $dept.tgz  to /scratch/monikasu  (lowrie)