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
    private  PersonRepository personRepo;
    private SubmissionRepository submissionRepo;

    public PrepopulateStudentData() {
         personRepo = Spring.getBeanOfType(PersonRepository.class);
         submissionRepo = Spring.getBeanOfType(SubmissionRepository.class);
    }

    public void setSecurityContext(SecurityContext context) {
        this.context = context;
    }

    public void setFirstName(String colheader) { firstNameColHeader = colheader; }
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
    public void setDefaultTitle(String colheader) { defaultTitle = colheader; }
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
        Reader in = null;
        int lineno = 0;
        int skipped = 0;        try {
            in = new FileReader(fileName);

            try {
                // turn off authorization so we can add person entries
                context.turnOffAuthorization();

                Iterable<CSVRecord> records = CSVFormat.TDF.withFirstRecordAsHeader().parse(in);
                for (CSVRecord record : records) {
                    lineno++;
                    String netId = record.get(netidColHeader);
                    String email = netId + emailAddOn;
                    String lastName = record.get(lastNameColHeader);
                    String firstName = record.get(firstNameColHeader);
                    String dept = record.get(departmentColHeader);
                    String deptCode = record.get(departmentCodeColHeader);
                    String uid = record.get(uidColHeader);
                    String advFirstName = record.get(advisorFirstNameColHeader);
                    String advMiddleName = lastName.substring(0,1);  // TODO actually get the middle names
                    String advLastName = record.get(advisorLastNameColHeader);
                    String advNetid = record.get(advisorNetidColHeader);

                    // TODO - remove when we have proper HR Data file
                    if (null == dept) {
                        Logger.info("skipping record with missing department");
                        skipped++;
                        continue;
                    }
                    if (null == netId || null == firstName || null == lastName || null == uid || null == dept || null == deptCode) {
                        Logger.warn("line " + lineno + ": Missing info in Student Record");
                        skipped++;
                        continue;
                    }

                    p = personRepo.createPerson(netId, email, firstName, lastName, RoleType.STUDENT);
                    p.setCurrentDepartment(dept);
                    p.setInstitutionalIdentifier(uid);
                    if (null != password) {
                        p.save();
                        p.setPassword(password);
                    }
                    p.save();
                    Logger.info("line " + lineno + ": created " + p );

                    Submission s = submissionRepo.createSubmission(p);
                    // personal Info step
                    s.setStudentFirstName(p.getFirstName());
                    s.setStudentLastName(p.getLastName());
                    s.setDepartment(p.getCurrentDepartment());
                    s.setOrcid(deptCode);

                    // document info step
                    s.setDocumentTitle(defaultTitle);
                    if (null != advNetid) s.setCommitteeContactEmail(advNetid + emailAddOn);
                    if (null != advFirstName && null != advLastName) s.addCommitteeMember(advFirstName, advLastName, advMiddleName);
                    s.setCollege(college);
                    s.save();
                }
            } catch (IOException e) {
                Logger.error(e, fileName + "line " + lineno + ": can't read csv line");
            } finally {
                // turn back on
                context.restoreAuthorization();
            }
        } catch (FileNotFoundException e) {
            Logger.error(e, "Unable to read student data file " + fileName);
        }
        Logger.info(String.format("file %s: %d lines - skipped %d", fileName, lineno, skipped));
    }

    public void deleteAllStudentsAndSubmissions() {
        Logger.info("deleting all students and their submissions");

        for (Person p : personRepo.findPersonsByRole(RoleType.STUDENT)) {
                if (p.getRole() == RoleType.STUDENT) {
                    for (Submission s : submissionRepo.findSubmission(p)) {
                        Logger.info("Delete " + s);
                        s.delete();
                    }
                    Logger.info("Delete " + p.getNetId());
                    p.delete();
                }
        }
    }
}
