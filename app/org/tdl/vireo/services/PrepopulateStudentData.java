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
    static final int NETID = 2;
    static final int ADV_FIRST_NAME = 3;
    static final int ADV_LAST_NAME = 4;
    static final int ADV_MIDDLE_NAME = 5;
    static final int UID = 6;
    static final int DEPARTMENT = 7;
    static final int DEPT_CODE = 8;
    static final int NCOLUMNS = 9;

    String[] colHeaderName = new String[NCOLUMNS];

    Hashtable<String, Integer> headerIndex;

    String college;
    String emailAddOn;
    String defaultTitle;
    String defaultLanguage;
    String password = null;
    String fileName;

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

    public void setAdvisorMiddleName(String colheader) {
        colHeaderName[ADV_MIDDLE_NAME] = colheader;
    }

    public void setAdvisorNetid(String colheader) {   /*noop */
        ;
    }

    public void setCollege(String college) {
        this.college = college;
    }

    public void setEmailAddOn(String emailAddOn) {
        this.emailAddOn = emailAddOn;
    }

    public void setDefaultTitle(String colheader) {
        defaultTitle = colheader;
    }

    public void setDefaultLanguage(String lang)  { defaultLanguage = lang; }

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
                } else {
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
        try {
            // TODO - remove ? turn off authorization so we can add person entries
            context.turnOffAuthorization();

            for (String[] line = in.readNext(); line != null; line = in.readNext()) {
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
                    p = data.createStudentWithSubmission(emailAddOn, defaultTitle, college);
                    if (null != password) {
                        p.setPassword(password);
                        p.save();
                    }
                    action = "created";
                }
                Logger.info(String.format("%s line %d: %s %s", fileName, lineno, action, data));
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
        Logger.info("deleting all students and their submissions");

        for (Person p : personRepo.findPersonsByRole(RoleType.STUDENT)) {
            if (p.getRole() == RoleType.STUDENT) {
                for (Submission s : submissionRepo.findSubmission(p)) {
                    s.delete();
                }
                Logger.info("Delete Student " + p.getNetId());
                p.delete();
            }
        }
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
            // TODO fix up middle name to be just the initial
            if (null != record[ADV_MIDDLE_NAME] && record[ADV_MIDDLE_NAME].length() > 1) {
                record[ADV_MIDDLE_NAME] =  record[ADV_MIDDLE_NAME].substring(0, 1);
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

        public Person createStudentWithSubmission(String emailAddOn, String defaultTitle, String college) {
            String dept = "";
            if (record[DEPT_CODE].length() > 4) {
                dept = record[DEPT_CODE].substring(4);
                dept = record[DEPARTMENT] + " (" + dept + ")";
            } else {
                dept = record[DEPARTMENT];
            }

            Person p = personRepo.createPerson(record[NETID], email, record[FIRST_NAME], record[LAST_NAME], RoleType.STUDENT);
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
                s.addCommitteeMember(record[ADV_FIRST_NAME], record[ADV_LAST_NAME], record[ADV_MIDDLE_NAME]);
            }
            s.setCollege(college);
            s.save();

            return p;
        }
    }
}