# Export from Vireo - Import to DataSpace #

## export to laptop 
add  spreadsheet list of all thesis to export directory; 
add ID column to restriction request spreadsheet exported from Sharepoint;
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

the script uses [python/sortByStatus.py](python/sortByStatus.py) to sort submission directories into status and department specific directories, eg: 
~~~
$dept/Approved/English/submission_1234
$dept/Cancelled/History/submission_2345
~~~

Multi Author submission are moved to 
~~~
Multi-Author/Approved/Engineering/submission_4568
Multi-Author/Cancelled/Engineering/submission_4568
~~~

the script copies $dept.tgz  to /scratch/monikasu  (lowrie)  if it is successfull 

## MultiAuthor thesis 
once all departments/certificate programs have been exported you can find al multi author thesis in  export/Multi-Author organized into 
state specific and deprtment specific directories, see above

move cancelled submissions for to the directory of the corresponding approved submission by the co-author

then check for correctness with 

~~~
cd export/Multi-Author
check_all_approved
# once the combine is legit 

combine_all_approved 
# just cut and paste and follow instrctions as directed 

#sanity double check with 
check_after_combine
~~~ 

once all checks out tar and copy to lowrie: 
~~~
set dept = Multi-Author
(cd export; tar cfz $dept.tgz ./$dept) 
scp export/$dept.tgz monikasu@arizona.princeton.edu:/scratch/monikasu/$dept.tgz
ssh monikasu@arizona.princeton.edu chmod o+r /scratch/monikasu/$dept.tgz
~~~


## import to dspace 

next log into dataspace/updatespace, unwarp the tgz file, and import theses

~~~
ssh dspace@dataspace/updatespace 
cd ~/thesiscentral-vireo/dataspace/import

./unwarp 
# just cut and paste the desrived tgz file from the prompt 

# test access at https://dataspace.princeton.edu/www/thesis_central/

#then import to dspace - follow prompts 
./import