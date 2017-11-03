package org.tdl.vireo.services;

import au.com.bytecode.opencsv.CSVReader;

import org.tdl.vireo.model.*;
import org.tdl.vireo.security.SecurityContext;
import play.Logger;
import play.modules.spring.Spring;

import java.io.*;
import java.util.Hashtable;

/**
 * Created by monikam on 10/17/17.
 */
public class PrepopulateStudentData {

    static final int FIRST_NAME = 0;
    static final int LAST_NAME = 1;
    static final int MIDDLE_NAME = 2;
    static final int NETID = 3;
    static final int UID = 4;
    static final int DEPARTMENT = 5;
    static final int DEPT_CODE = 6;
    static final int ADV_FIRST_NAME = 7;
    static final int ADV_LAST_NAME = 8;

    static final int NCOLUMNS = 9;

    String[] colHeaderName = new String[NCOLUMNS];

    Hashtable<String, Integer> headerIndex;

    String defaultCollege;  // abused as thesis type - eg home department versus certificate thesis
    String defaultTitle;
    String defaultLanguage;
    String defaultDocType = "no";  // abused as multiAuthor value
    String emailAddOn;
    String password = null;
    String fileName;  // file tat contains data to be imported

    private SecurityContext context;
    PersonRepository personRepo;
    SubmissionRepository submissionRepo;
    SettingsRepository settingsRepo;

    public PrepopulateStudentData() {
        personRepo = Spring.getBeanOfType(PersonRepository.class);
        submissionRepo = Spring.getBeanOfType(SubmissionRepository.class);
        settingsRepo = Spring.getBeanOfType(SettingsRepository.class);
        headerIndex = new Hashtable<String, Integer>(NCOLUMNS);
    }

    public void setSecurityContext(SecurityContext context) {
        this.context = context;
    }

    public void setSettingsRepository(SettingsRepository settingsRepo) {
        this.settingsRepo = settingsRepo;
    }

    public void setFirstName(String colheader) {
        colHeaderName[FIRST_NAME] = colheader;
    }

    public void setLastName(String colheader) {
        colHeaderName[LAST_NAME] = colheader;
    }

    public void setMiddleName(String colheader) {
        colHeaderName[MIDDLE_NAME] = colheader;
    }

    public void setNetid(String netidColHeader) {
        colHeaderName[NETID] = netidColHeader;
    }

    public void setDepartment(String department) {
        colHeaderName[DEPARTMENT] = department;
    }

    public void setDepartmentCode(String deptCode) {
        colHeaderName[DEPT_CODE] = deptCode;
    }

    public void setUid(String uid) {
        colHeaderName[UID] = uid;
    }

    public void setAdvisorFirstName(String colheader) {
        colHeaderName[ADV_FIRST_NAME] = colheader;
    }

    public void setAdvisorLastName(String colheader) {
        colHeaderName[ADV_LAST_NAME] = colheader;
    }

    public void setAdvisorNetid(String colheader) {   /*noop */
        ;
    }

    public void setCollege(String college) {
        this.defaultCollege = college;
    }

    public void setEmailAddOn(String emailAddOn) {
        this.emailAddOn = emailAddOn;
    }

    public void setDefaultTitle(String colheader) {
        defaultTitle = colheader;
    }

    public void setDefaultLanguage(String lang) {
        defaultLanguage = lang;
    }

    public void setDefaultDocType(String type) {
        defaultDocType = type;
    }

    public void setPassword(String pwd) {
        password = pwd;
    }

    public void setFileName(String file) {
        fileName = file;
    }

    public void loadStudentsCreateSubmissions() {
        Logger.info("Reading student data from " + fileName);

        CSVReader in = null;
        try {
            in = new CSVReader(new FileReader(fileName), '\t');
            String fileHeaders[] = in.readNext();
            int index = 0;
            for (String key : fileHeaders) {
                headerIndex.put(key, index);
                index++;
            }
            for (int i = 0; i < NCOLUMNS; i++) {
                if (null == headerIndex.get(colHeaderName[i])) {
                    Logger.error(" prop-" + i + " : Missing column for " + colHeaderName[i]);
                    // TODO raise error ?
                } else if (Logger.isDebugEnabled()) {
                    Logger.debug(" prop-" + i + " : headerIndex(" + colHeaderName[i] + ") -> " + headerIndex.get(colHeaderName[i]));
                }
            }
        } catch (FileNotFoundException e) {
            Logger.error(e, fileName + ": Unable to open for reading ");
            return;
        } catch (IOException e) {
            Logger.error(fileName + ": Could not read header line ");
            return;
        }

        deleteAllStudentsAndSubmissions();

        Person p = null;
        String action = "noop";
        int lineno = 1;
        int skipped = 0;
        boolean invalid = false;
        try {
            // TODO - remove ? turn off authorization so we can add person entries
            context.turnOffAuthorization();

            for (String[] line = in.readNext(); line != null; line = in.readNext()) {
                invalid = true;
                lineno++;
                Record data = new Record(line, this);

                // TODO - remove when we have proper HR Data file
                if (data.empty(data.record[DEPARTMENT])) {
                    action = "skipping no department";
                    skipped++;
                } else if (!data.valid()) {
                    Logger.warn("line " + lineno + ": Missing info in Student Record");
                    action = "skipping invalid";
                    skipped++;
                } else {
                    p = data.createStudentWithSubmission();
                    if (null != password) {
                        p.setPassword(password);
                        p.save();
                    }
                    action = "created";
                    invalid = false;
                }
                if (invalid)
                    Logger.info(String.format("%s line %d: %s %s", fileName, lineno, action, data));
                else if (Logger.isDebugEnabled())
                    Logger.debug(String.format("%s line %d: %s %s", fileName, lineno, action, data));

                if (0 == lineno % 50) {
                    Logger.info(String.format("%s line %d: skipped %d", fileName, lineno, skipped));
                }
            }
            Logger.info(String.format("%s: %d total lines;  %d skipped lines ", fileName, lineno, skipped));
        } catch (IOException e) {
            Logger.error(e, fileName + "line " + lineno + ": can't read csv line");
        } finally {
            // turn back on
            context.restoreAuthorization();
        }

        Logger.info(String.format("file %s: %d lines - skipped %d", fileName, lineno, skipped));
    }

    public void deleteAllStudentsAndSubmissions() {
        Logger.info("Start Deleting all students and their submissions");
        int n = 0;
        for (Person p : personRepo.findPersonsByRole(RoleType.STUDENT)) {
            if (p.getRole() == RoleType.STUDENT) {
                for (Submission s : submissionRepo.findSubmission(p)) {
                    s.delete();
                }
                if (Logger.isDebugEnabled())
                    Logger.debug("Delete Student " +  n + " "  + p.getNetId());
                p.delete();
                n++;
                if (0 == n % 50 ) {
                    Logger.info("Delete " + n + " Students ...");
                }
            }
        }
        Logger.info("Finished Deleting all students and their submissions: Deleted total of " + n + " Students ");
    }

    class Record {
        String[] record;
        String email;

        Record(String[] csv, PrepopulateStudentData populator) {
            record = new String[NCOLUMNS];
            for (int i = 0; i < NCOLUMNS; i++) {
                try {
                    // Logger.info("Record.Prop " + i + " " + populator.colHeaderName[i] );
                    if (populator.colHeaderName[i] != null)
                        record[i] = csv[populator.headerIndex.get(populator.colHeaderName[i])];
                    // Logger.info("Record.Prop " + i + " " + populator.colHeaderName[i] + " " +  populator.headerIndex.get(populator.colHeaderName[i])  + " --" + record[i]);
                } catch (ArrayIndexOutOfBoundsException e) {
                    // Logger.info("Record.Prop " + i );
                    record[i] = null;
                }
            }
            email = toStr(record[NETID]) + populator.emailAddOn;
        }

        boolean valid() {
            return !(empty(record[DEPARTMENT]) && empty(record[DEPT_CODE]) && empty(record[FIRST_NAME]) && empty(record[LAST_NAME]) &&
                    empty(record[NETID]) && empty(record[UID]));
        }

        boolean empty(String s) {
            return null == s || s.trim().equals("");
        }

        String toStr(String s) {
            return (empty(s)) ? "" : s;
        }

        public String toString() {
            return String.format("CSV[D:%s(%s),S:(%s,%s),A:(%s)]", toStr(record[DEPT_CODE]), toStr(record[DEPARTMENT]), toStr(record[NETID]),
                    toStr(record[LAST_NAME]), toStr(record[ADV_LAST_NAME]));
        }

        public Person createStudentWithSubmission() {
            String dept = "";
            if (record[DEPT_CODE].length() > 4) {
                dept = record[DEPT_CODE].substring(4);
                dept = record[DEPARTMENT] + " (" + dept + ")";
            } else {
                dept = record[DEPARTMENT];
            }

            Person p = personRepo.createPerson(record[NETID], email, record[FIRST_NAME], record[LAST_NAME], RoleType.STUDENT);
            p.setMiddleName(record[MIDDLE_NAME]);
            p.setCurrentDepartment(dept);
            p.setInstitutionalIdentifier(record[UID]);
            p.save();

            if (null == settingsRepo.findDepartmentByName(dept)) {
                settingsRepo.createDepartment(dept).save();
            }

            Submission s = submissionRepo.createSubmission(p);
            // personal Info step
            s.setStudentFirstName(p.getFirstName());
            s.setStudentLastName(p.getLastName());
            s.setDepartment(p.getCurrentDepartment());

            // document info step
            s.setDocumentTitle(defaultTitle);
            s.setDocumentLanguage(defaultLanguage);
            if (!empty(record[ADV_FIRST_NAME]) && !empty(record[ADV_LAST_NAME])) {
                s.addCommitteeMember(record[ADV_FIRST_NAME], record[ADV_LAST_NAME], "");
            }
            s.setCollege(defaultCollege);
            s.setDocumentType(defaultDocType);
            s.save();

            return p;
        }
    }
}