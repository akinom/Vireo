package org.tdl.vireo.services;

/**
 * Created by monikam on 1/24/18.
 */

import org.tdl.vireo.model.*;
import org.tdl.vireo.security.SecurityContext;
import play.Logger;
import play.modules.spring.Spring;

import java.util.HashMap;
import java.util.Hashtable;

public class ManageReviewerAccounts {

    private PersonRepository personRepo;
    private SettingsRepository settingsRepo;

    public ManageReviewerAccounts() {
        personRepo = Spring.getBeanOfType(PersonRepository.class);
    }

    public void setSettingsRepository(SettingsRepository settingsRepo) {
        this.settingsRepo = settingsRepo;
    }

    public void updateAccounts() {
        revoke_reviewer_roles();
        for (Department stp : settingsRepo.findAllDepartments()) {
            makeReviewers(stp.getEmails());
        }
        for (Program stp : settingsRepo.findAllPrograms()) {
            makeReviewers(stp.getEmails());
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

    private int revoke_reviewer_roles() {
        int nrevoked = 0;
        for (Person stp : personRepo.findPersonsByRole(RoleType.REVIEWER)) {
            if (RoleType.REVIEWER == stp.getRole()) {
                Logger.debug("PERSON  [" + stp.getNetId() + "] REVIEWER -> NONE");
                stp.setRole(RoleType.NONE);
                stp.save();
                nrevoked ++;
            }
        }
        return nrevoked;
    }


}
