package org.tdl.vireo.services;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.tdl.vireo.model.Person;
import org.tdl.vireo.model.PersonRepository;
import org.tdl.vireo.model.RoleType;
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
    String emailAddOn;
    String fileName;

    private SecurityContext context;

    public void setSecurityContext(SecurityContext context) {
        this.context = context;
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

    public void setEmailAddOn(String emailAddOn) {
        this.emailAddOn = emailAddOn;
    }

    public void setDepartment(String department) {
        this.departmentColHeader = department;
    }

    public void setUid(String uid) {
        this.uidColHeader = uid;
    }

    public void setFileName(String file) {
        fileName = file;
    }

    public void loadStudents() {
        Logger.info("Reading student data from " + fileName);
        PersonRepository personRepo = Spring.getBeanOfType(PersonRepository.class);

        Person p;
        Reader in = null;
        try {
            in = new FileReader(fileName);
            int lineno = 1;
            try {
                // turn off authorization so we can add person entries
                context.turnOffAuthorization();

                Iterable<CSVRecord> records = CSVFormat.TDF.withFirstRecordAsHeader().parse(in);
                for (CSVRecord record : records) {
                    String netId = record.get(netidColHeader);
                    String email = netId + emailAddOn;
                    String lastName = record.get(lastNameColHeader);
                    String firstName = record.get(firstNameColHeader);
                    String dept = record.get(departmentColHeader);
                    String uid = record.get(uidColHeader);
                    Logger.info("line " + lineno + ": Student " + firstName + " " + lastName );
                    p = personRepo.createPerson(netId, email, firstName, lastName, RoleType.STUDENT);
                    p.setCurrentDepartment(dept);
                    p.setInstitutionalIdentifier(uid);
                    p.save();
                    Logger.info("line " + lineno + ": " + p );
                    lineno += 1;
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
    }
}
