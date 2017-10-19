package org.tdl.vireo.services;

import controllers.Student;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.tdl.vireo.model.*;
import org.tdl.vireo.security.SecurityContext;
import play.Logger;
import play.modules.spring.Spring;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

/**
 * Created by monikam on 10/17/17.
 */
public class PrepopulateStudentData {

    String firstNameColHeader;
    String lastNameColHeader;
    String netidColHeader;
    String uidColHeader;
    String departmentColHeader;
    String departmentCodeColHeader;

    String advisorLastNameColHeader;
    String advisorFirstNameColHeader;
    String advisorMiddleNameColHeader;
    String advisorNetidColHeader;

    String college;
    String emailAddOn;
    String defaultTitle;
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
    }

    public void setSecurityContext(SecurityContext context) {
        this.context = context;
    }

    public void setSettingsRepository(SettingsRepository settingsRepo) {
        this.settingsRepo = settingsRepo;
    }

    public void setFirstName(String colheader) {
        firstNameColHeader = colheader;
    }

    public void setLastName(String colheader) {
        lastNameColHeader = colheader;
    }

    public void setNetid(String netidColHeader) {
        this.netidColHeader = netidColHeader;
    }

    public void setDepartment(String department) {
        this.departmentColHeader = department;
    }

    public void setDepartmentCode(String deptCode) {
        this.departmentCodeColHeader = deptCode;
    }

    public void setUid(String uid) {
        this.uidColHeader = uid;
    }

    public void setAdvisorFirstName(String colheader) {
        advisorFirstNameColHeader = colheader;
    }

    public void setAdvisorLastName(String colheader) {
        advisorLastNameColHeader = colheader;
    }

    public void setAdvisorNetid(String colheader) {
        advisorNetidColHeader = colheader;
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

    public void setPassword(String pwd) {
        password = pwd;
    }

    public void setFileName(String file) {
        fileName = file;
    }

    public void loadStudentsCreateSubmissions() {
        Logger.info("Reading student data from " + fileName);

        deleteAllStudentsAndSubmissions();

        Person p;
        String action = null;
        Reader in = null;
        int lineno = 0;
        int skipped = 0;
        try {
            in = new FileReader(fileName);
            p = null;
            action = "noop";
            try {
                // TODO - remove ? turn off authorization so we can add person entries
                context.turnOffAuthorization();

                Iterable<CSVRecord> records = CSVFormat.TDF.withFirstRecordAsHeader().parse(in);
                for (CSVRecord record : records) {
                    lineno++;
                    Record data = new Record(record, this);

                    // TODO - remove when we have proper HR Data file
                    if (data.empty(data.dept)) {
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
    } catch(
    FileNotFoundException e)

    {
        Logger.error(e, "Unable to read student data file " + fileName);
    }
        Logger.info(String.format("file %s: %d lines - skipped %d",fileName,lineno,skipped));
}

    public void deleteAllStudentsAndSubmissions() {
        Logger.info("deleting all students and their submissions");

        for (Person p : personRepo.findPersonsByRole(RoleType.STUDENT)) {
            if (p.getRole() == RoleType.STUDENT) {
                for (Submission s : submissionRepo.findSubmission(p)) {
                    s.delete();
                }
                Logger.info("Delete " + p.getNetId());
                p.delete();
            }
        }
    }


class Record {
    CSVRecord record;

    String netId;
    String email;
    String lastName;
    String firstName;
    String dept;
    String deptCode;
    String uid;
    String advFirstName;
    String advMiddleName;  // TODO actually get the middle names
    String advLastName;
    String advNetid;

    Record(CSVRecord csv, PrepopulateStudentData populator) {
        record = csv;
        netId = record.get(populator.netidColHeader);
        email = netId + populator.emailAddOn;
        lastName = record.get(populator.lastNameColHeader);
        firstName = record.get(populator.firstNameColHeader);
        dept = record.get(populator.departmentColHeader);
        deptCode = record.get(populator.departmentCodeColHeader);
        uid = record.get(populator.uidColHeader);
        advFirstName = record.get(populator.advisorFirstNameColHeader);
        advMiddleName = lastName.substring(0, 1);  // TODO actually get the middle names
        advLastName = record.get(populator.advisorLastNameColHeader);
        advNetid = record.get(populator.advisorNetidColHeader);
    }

    boolean valid() {
        return !(empty(dept) && empty(deptCode) && empty(firstName) && empty(lastName) && empty(netId) && empty(uid));
    }

    boolean empty(String s) {
        return null == s || s.trim().equals("");
    }

    String toStr(String s) {
        return (empty(s)) ? "" : s;
    }

    public String toString() {
        return String.format("CSV[D:%s(%s),S:(%s,%s),A:(%s)]", toStr(deptCode), toStr(dept), toStr(netId), toStr(lastName), toStr(advNetid));
    }

    public Person createStudentWithSubmission(String emailAddOn, String defaultTitle, String college) {
        Person p = personRepo.createPerson(netId, email, firstName, lastName, RoleType.STUDENT);
        p.setCurrentDepartment(dept);
        p.setInstitutionalIdentifier(uid);
        p.save();

        if (null == settingsRepo.findDepartmentByName(dept)) {
            settingsRepo.createDepartment(dept).save();
        }

        Submission s = submissionRepo.createSubmission(p);
        // personal Info step
        s.setStudentFirstName(p.getFirstName());
        s.setStudentLastName(p.getLastName());
        s.setDepartment(p.getCurrentDepartment());
        s.setOrcid(deptCode);

        // document info step
        s.setDocumentTitle(defaultTitle);
        if (!empty(advNetid) && !empty(advFirstName) && !empty(advLastName)) {
            s.setCommitteeContactEmail(advNetid + emailAddOn);
            s.addCommitteeMember(advFirstName, advLastName, advMiddleName);
        }
        s.setCollege(college);
        s.save();

        return p;
    }
}
}