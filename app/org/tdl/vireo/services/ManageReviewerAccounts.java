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
            if (p == null) {
                Logger.info(" Create Person " + netid);
                //  must give first or last name
                p = personRepo.createPerson(netid, mail, null, mail, RoleType.REVIEWER);
            } else {
                Logger.info(" Exists Person " + netid);
                p.setRole(RoleType.REVIEWER);
            }
        }
    }

    private void revoke_reviewer_roles() {
        for (Person stp : personRepo.findPersonsByRole(RoleType.REVIEWER)) {
            stp.setRole(RoleType.MANAGER);
        }
    }


}
