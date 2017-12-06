# Princeton Universiy's THesis Central System  #

## About Thesis Central   ##

Thesis Central is used by Princeton University for  undergraduates to submit their senior thesis. 

Thes system is based on TDL Vireo's system. For more information on Vireo, visit the 
[Github Project page for Vireo](https://github.com/TexasDigitalLibrary/Vireo)
OR
[Github Project wiki for Vireo](https://github.com/TexasDigitalLibrary/Vireo/wiki)
OR
[Github page for Vireo](http://texasdigitallibrary.github.io/Vireo/)

It is derived from (Vireo v3.0.6) https://github.com/akinom/Vireo/releases/tag/v3.0.6

##  Princeton Modifications  ##

Princeton expects that all seniors submit a Home Department Thesis. Some students submit a second thesis, a Dedicated Certificate Program thesis. 
Administrators in the different departments review the theses submitted by seniors from their department. Reviewers want to see which students have already submitted and they want to know which students are still expected to submit. 
Princeton wanted reviewers to not be able to access all thesis submissions in the system, instead they should only be able to 'see' 
those they are reposnsible for. 

In addition Princeton wanted to collect some custom information.

**Data Prepopulation**

The PrepopulateStudentData class loads data from a TAB separated spreadsheet. 
Its parameters, that is the file to read and the columns to look for,  are defined in a bean definition in conf/application-context.xml, see 
~~~
    <bean id="PrepopulateStudentData" class="org.tdl.vireo.services.PrepopulateStudentData" scope="singleton">
    ...
~~~

Addministrators trigger data loading from the User Interfaces's System page. 
Existing student records and related submissions are deleted before new student records are created. 
The data loader creates an 'In Progress' 'Home Department Submission', see college bean property, for each student. 
It creates the related department, as defined by the student's current department setting, if the department is not yet defined.

The data loader expects to find a netid for each sudent described in the the data file.
It sets the students email to the netid followed by the value of the 'emailAddOn' property. 
The optional 'password' property can be set to a string, which is used to set the password for all students.

The data file loaded during testing uses thesis.central.pu+[real-NETID] as the netid value. 
The emailAddOn property of the data loader is set to '@gmail.com'. 
Along with a constant password setting, we can log in on behalf of each student and we receive emails that are send to students at thesis.central.pu@gmail.com.

In production we will use the proper netids and '@princeton.edu' as emailAddOn property. 

**Repurposed Fields:**
- ORCID  - used for department code
- College - used to indicate whether student submits a Home department Thesis or a dedicated Certificate Program thesis 
- Program - used to indicate a certificate program - this field is moved from the personal info section to the document info section 
 
 
