package edu.princeton.vireo.services;

import org.tdl.vireo.model.*;
import org.tdl.vireo.security.SecurityContext;
import play.Logger;
import play.modules.spring.Spring;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;

import static edu.princeton.vireo.services.PrepopulateStudentData.NCOLUMNS;

/**
 * Created by monikam on 2/1/18.
 */
public class ManageData {

    private SecurityContext context;
    PersonRepository personRepo;
    SubmissionRepository submissionRepo;
    SettingsRepository settingsRepo;

    public void setSecurityContext(SecurityContext context) {
        this.context = context;
    }

    public void setSettingsRepository(SettingsRepository settingsRepo) {
        this.settingsRepo = settingsRepo;
    }

    public void setPersonRepository(PersonRepository repo) {
        this.personRepo = repo;
    }

    public void setSubmissionRepository(SubmissionRepository repo) {
        this.submissionRepo = repo;
    }

    public void deleteAllSubmissions() {
        Logger.info("Start Deleting All Submissions");
        int n = 0;
        // since we are deleting inside the iterator which goes through batches of submissions
        // by querying with offset values it skips submissions
        while (submissionRepo.findSubmissionsTotal() > 0) {
            Iterator<Submission> submissionsItr = submissionRepo.findAllSubmissions();
            while (submissionsItr.hasNext()) {
                Submission sub = submissionsItr.next();
                sub.delete();
                n++;
                if (0 == n % 50) {
                    Logger.info("Delete " + n + " Submission ...");
                }
            }
        }
        Logger.info("Finished Deleting All Submissions: Deleted # " + n );
    }

    public void deleteAllStudentsAndSubmissions() {
        Logger.info("Start Deleting All Students and their Submissions");
        int n = 0;
        for (Person p : personRepo.findPersonsByRole(RoleType.STUDENT)) {
            // all Persons with role >= STUDENT
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
        Logger.info("Finished Deleting All Students and their Submissions: Deleted #" + n );
    }

    public void updateReviewerAccounts() {
        revoke_reviewer_roles();
        for (Department stp : settingsRepo.findAllDepartments()) {
            makeReviewers(stp.getEmails());
        }
        for (Program stp : settingsRepo.findAllPrograms()) {
            makeReviewers(stp.getEmails());
        }
    }

    public void deleteAllUserWithRoleNONE() {
        for (Person stp : personRepo.findAllPersons()) {
            if (stp.getRole() == RoleType.NONE) {
                stp.delete();
            }
        }
    }

    private void makeReviewers(HashMap<Integer, String> email_hsh) {
        for (Integer i : email_hsh.keySet()) {
            String mail = email_hsh.get(i);
            String netid = mail.split("@")[0];
            Person p = personRepo.findPersonByNetId(netid);
            try {
                if (p == null) {
                    //  must give first or last name
                    p = personRepo.createPerson(netid, mail, null, mail, RoleType.REVIEWER);
                    p.save();
                    Logger.debug(" makeReviewers: created " + p);
                } else {
                    Logger.debug(" Exists Person " + p);
                    if (p.getRole().ordinal() < RoleType.REVIEWER.ordinal()) {
                        Logger.debug(" Make Reviewer " + p + " " + p.getRole());
                        p.setRole(RoleType.REVIEWER);
                        p.save();
                        Logger.debug(" makeReviewers: setRole " + p);
                    }
                }
            } catch (Exception ex) {
                Logger.error(p.toString() + ": " + ex);
            }
        }
    }

    private void revoke_reviewer_roles() {
        for (Person stp : personRepo.findPersonsByRole(RoleType.REVIEWER)) {
            if (RoleType.REVIEWER == stp.getRole()) {
                Logger.debug("PERSON  [" + stp.getNetId() + "] REVIEWER -> NONE");
                stp.setRole(RoleType.NONE);
                stp.save();
            }
        }
    }
}
