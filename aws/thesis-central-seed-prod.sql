--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 10.0


--
-- Data for Name: college; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO college (id, displayorder, emails, name) VALUES (1, 0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Home Department Thesis');
INSERT INTO college (id, displayorder, emails, name) VALUES (2, 10, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'Certificate Program Thesis');


--
-- Data for Name: configuration; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO configuration (id, name, value) VALUES (2, 'allow_multiple_submissions', 'true');
INSERT INTO configuration (id, name, value) VALUES (3, 'submit_student_orcid_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (4, 'submit_grantor_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (5, 'submit_major_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (6, 'submit_permanent_phone_number_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (7, 'submit_permanent_postal_address_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (8, 'submit_permanent_email_address_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (9, 'submit_current_phone_number_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (10, 'submit_current_postal_address_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (11, 'submit_graduation_date_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (12, 'submit_defense_date_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (13, 'submit_document_keywords_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (16, 'submit_embargo_type_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (17, 'submit_embargo_type_proquest_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (19, 'submit_document_abstract_enabled', 'optional');
INSERT INTO configuration (id, name, value) VALUES (27, 'submit_license', 'I pledge my honor that this paper represents my own work in accordance with University regulations.');
INSERT INTO configuration (id, name, value) VALUES (45, 'submit_student_middle_name_help', 'Enter your middle initial.');
INSERT INTO configuration (id, name, value) VALUES (23, 'button_main_color_on', '#1b333f');
INSERT INTO configuration (id, name, value) VALUES (24, 'button_highlight_color_on', '#43606e');
INSERT INTO configuration (id, name, value) VALUES (25, 'submit_degree_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (26, 'submit_college_enabled', 'required');
INSERT INTO configuration (id, name, value) VALUES (28, 'submit_language_enabled', 'required');
INSERT INTO configuration (id, name, value) VALUES (29, 'submit_committee_label', 'Your Adviser/s');
INSERT INTO configuration (id, name, value) VALUES (31, 'submit_source_attachment_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (32, 'submit_administrative_attachment_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (41, 'orcid_validation', '');
INSERT INTO configuration (id, name, value) VALUES (20, 'submit_student_middle_name_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (33, 'submit_supplemental_attachment_help', 'Upload supplemental files such as audio, video, website files or data sets. These files must be listed in the appendix of your thesis or dissertation. Executable files are not permitted.');
INSERT INTO configuration (id, name, value) VALUES (34, 'submit_committee_contact_email_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (18, 'submit_document_type_enabled', 'required');
INSERT INTO configuration (id, name, value) VALUES (15, 'submit_published_material_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (22, 'background_highlight_color', '#fc7a03');
INSERT INTO configuration (id, name, value) VALUES (35, 'email_from', '"Thesis Central" <noreply@princeton.edu>');
INSERT INTO configuration (id, name, value) VALUES (14, 'submit_document_subjects_enabled', 'disabled');
INSERT INTO configuration (id, name, value) VALUES (38, 'submit_license_agreement_help', 'I pledge my honor that this paper represents my own work in accordance with University regulations.');
INSERT INTO configuration (id, name, value) VALUES (48, 'submit_document_type_help', 'Please indicate whether you have a co-author on your thesis.');
INSERT INTO configuration (id, name, value) VALUES (39, 'submit_license_agreement_label', 'Academic Integrity Statement');
INSERT INTO configuration (id, name, value) VALUES (43, 'button_main_color_off', '#a6a18c');
INSERT INTO configuration (id, name, value) VALUES (47, 'button_highlight_color_off', '#c7c2a9');
INSERT INTO configuration (id, name, value) VALUES (49, 'submit_document_type_label', 'Is this a multi author thesis ?');
INSERT INTO configuration (id, name, value) VALUES (21, 'background_main_color', '#1b333f');
INSERT INTO configuration (id, name, value) VALUES (36, 'email_reply_to', '"Thesis Central" <thesiscentral@princeton.edu>');
INSERT INTO configuration (id, name, value) VALUES (37, 'submit_personal_info_stickyies', '"In the Senior Thesis Type section, most students should select <b>Home Department Thesis</b>.","Select <b>Certificate Program Thesis</b> only if you are submitting a second thesis for a certificate program that is  <b><i> different</i></b> from your home department thesis. This usually only applies to the Creative Writing Program. See <a href=""https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#type"" target=""_blank"">Senior Thesis Type instructions</a> for more info."
');
INSERT INTO configuration (id, name, value) VALUES (46, 'student_submission_personal_info_step', 'Verify and complete the information below. Further instructions on this step are available on our <a href="https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#verify" target="_blank">"Verify Your Information" web page</a>. If any of the supplied information is incorrect, contact <a href="mailto:mudd@princeton.edu">mudd@princeton.edu</a>.



');
INSERT INTO configuration (id, name, value) VALUES (52, 'student_submission_upload_step', 'In this step you will upload your senior thesis. Optionally, you may upload additional supplementary files that will be available along with your document after publication. See <a href="https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#upload" target="_blank">Upload Files</a> for further instructions.


');
INSERT INTO configuration (id, name, value) VALUES (51, 'student_submission_document_step', 'In this step you describe your senior thesis; further instructions are available at <a href="https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#stinfo" target="_blank">Senior Thesis Information Page Instructions</a>.
');
INSERT INTO configuration (id, name, value) VALUES (53, 'student_submission_confirm_step', 'Please verify all the information displayed below before proceeding. <b>Once you click the button to approve this document, you cannot make any more changes to your submission.</b>

');
INSERT INTO configuration (id, name, value) VALUES (54, 'student_submission_list', 'To begin, select <b>"Begin/Resume Submission."</b> You can save your work and return to it at a later time by hitting "Save and Continue" at the bottom of any page, 

The <b>"Make Additional Submission" </b>button should be used <b> only</b> if you need to resubmit your thesis due to an error, or to submit a second thesis if you have written two different theses (i.e. one for your home department and one for a certificate program).

<b>Important note:</b> You must notify the undergraduate administrator for your department if you resubmit your thesis. You need special permission to submit past the deadline.







');
INSERT INTO configuration (id, name, value) VALUES (55, 'student_submission_start_new', '<i>Use this button only to resubmit a faulty submission, or to submit a second thesis if you have written two different theses (i.e. one for your home department and one for a certificate program).</i> 




');
INSERT INTO configuration (id, name, value) VALUES (50, 'submit_instructions', 'Thank you for submitting your senior thesis! You will receive an email confirming your submission shortly. 

<b>Senior Thesis Archive</b>
Each senior thesis is deposited in the <a href="http://dataspace.princeton.edu/jspui/handle/88435/dsp019c67wm88m" target="_blank">Princeton University Undergraduate Senior Theses, 1924-2017 collection</a>, which is managed by the Princeton University Archives. Theses are available in full text only to the Princeton University computing network. If you wish to further restrict your thesis, you must submit a Restricted Access Form to the Office of the Dean of the College before 11:55 pm on commencement day, Tuesday June 5, 2018. See <a href="https://undergraduateresearch.princeton.edu/independent-work/thesis-archive" target="_blank"> ODOC''s Thesis Archive webpage</a> for more information.

For questions about your senior thesis, contact your department''s undergraduate program coordinator.
For questions about this site, or the Senior Thesis Collection, contact <a href=''mailto:mudd@princeton.edu''>mudd@princeton.edu</a>.













');
INSERT INTO configuration (id, name, value) VALUES (40, 'submit_upload_files_stickyies', '"If you do not have a PDF as part of your senior thesis submission, save and upload this <a href=""https://rbsc.princeton.edu/sites/default/files/placeholder_file.pdf"" target=""_blank"">placeholder_file.pdf</a> file, as your main PDF, and submit any other files as supplementary files.","SIZE QUOTA: no individual file may exceed 512 MB, and the total of all files must not exceed 4 GB. If your file exceeds 512 MB see <a href=""https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#large"" target=""_blank""> instructions for large files</a>","There is no limit on the number of supplementary files you may upload. Executable files (.exe) are not allowed. See our <a href=""https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#preferred"" target=""_blank"">list of preferred file types</a>."
');
INSERT INTO configuration (id, name, value) VALUES (57, 'correction_instructions', 'not used');
INSERT INTO configuration (id, name, value) VALUES (56, 'email_bcc', '"Thesis CentralBCC" <thesiscentral@princeton.edu>');
INSERT INTO configuration (id, name, value) VALUES (30, 'submit_document_info_stickyies', '"The <b>Abstract</b> is optional. Only complete this field if you have an abstract in your PDF. It should be copied and pasted from your PDF. You do not need to format the abstract. 

","See <a href=""https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#latex"" target=""_blank""> LaTex Instructions</a> if your title or abstract has special characters such as those found in chemical or mathematical formulae.","Select a program only if your thesis fulfills requirements for a Certificate Program. Just one selection is allowed. <a href=""https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students#certificate"" target=""_blank"">More about Certificate Programs</a> ","If your adviser is not listed, enter their name; find correct form of name in the  
<a href=""https://www.princeton.edu/search?search=advisorname#people"" target=""_blank""> Princeton Directory</a>."
');
INSERT INTO configuration (id, name, value) VALUES (42, 'front_page_instructions', '<h1>Welcome to Thesis Central</h1>

Thesis Central is an application that allows Princeton seniors to upload their senior thesis files for retrieval by their home department; these files will also be transmitted to the Princeton University Archives. Instructions for using Thesis Central are available on the <a href="https://rbsc.princeton.edu/policies/senior-thesis-submission-information-students" target="_blank"> Senior Thesis Submission Information for Students webpage</a>.

Check with your home department for additional senior thesis submission requirements, such as the submission of bound or unbound paper copies.

To get started, click the button below. You will need to authenticate using your Princeton email address and password:

{START_SUBMISSION}');
INSERT INTO configuration (id, name, value) VALUES (58, 'closed_front_page_instructions', '<h1>Welcome to Thesis Central</h1>

Thesis Central is currently closed for submissions.

Starting March 19th, 2018 Students may start submitting their Senior Theses.');


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO department (id, displayorder, emails, name) VALUES (76, 50, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Chemical and Biological Engr');
INSERT INTO department (id, displayorder, emails, name) VALUES (99, 60, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Chemistry');
INSERT INTO department (id, displayorder, emails, name) VALUES (83, 70, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Civil & Environmental Engr');
INSERT INTO department (id, displayorder, emails, name) VALUES (90, 80, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Classics');
INSERT INTO department (id, displayorder, emails, name) VALUES (81, 180, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'English');
INSERT INTO department (id, displayorder, emails, name) VALUES (101, 30, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'Art & Archaeology');
INSERT INTO department (id, displayorder, emails, name) VALUES (106, 40, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'Astrophysical Sciences');
INSERT INTO department (id, displayorder, emails, name) VALUES (92, 10, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'Anthropology');
INSERT INTO department (id, displayorder, emails, name) VALUES (100, 0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'African American Studies');
INSERT INTO department (id, displayorder, emails, name) VALUES (108, 20, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Architecture');
INSERT INTO department (id, displayorder, emails, name) VALUES (94, 90, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Comparative Literature');
INSERT INTO department (id, displayorder, emails, name) VALUES (72, 110, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156d6f6e696b616d407072696e6365746f6e2e65647578', 'Computer Science (AB)');
INSERT INTO department (id, displayorder, emails, name) VALUES (73, 120, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Computer Science (BSE)');
INSERT INTO department (id, displayorder, emails, name) VALUES (109, 130, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'East Asian Studies');
INSERT INTO department (id, displayorder, emails, name) VALUES (89, 140, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Ecology & Evolutionary Biology');
INSERT INTO department (id, displayorder, emails, name) VALUES (86, 150, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Economics');
INSERT INTO department (id, displayorder, emails, name) VALUES (85, 160, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Electrical Engineering');
INSERT INTO department (id, displayorder, emails, name) VALUES (114, 170, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Engish');
INSERT INTO department (id, displayorder, emails, name) VALUES (97, 190, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'French and Italian');
INSERT INTO department (id, displayorder, emails, name) VALUES (115, 290, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Mechanical and Aeorospace Engineering');
INSERT INTO department (id, displayorder, emails, name) VALUES (95, 200, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Geosciences');
INSERT INTO department (id, displayorder, emails, name) VALUES (105, 210, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'German');
INSERT INTO department (id, displayorder, emails, name) VALUES (107, 230, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Independent Study - AB');
INSERT INTO department (id, displayorder, emails, name) VALUES (112, 240, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Independent Study - AB (AB)');
INSERT INTO department (id, displayorder, emails, name) VALUES (110, 250, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Independent Study-Linguistics');
INSERT INTO department (id, displayorder, emails, name) VALUES (113, 260, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Independent Study-Linguistics (LN)');
INSERT INTO department (id, displayorder, emails, name) VALUES (91, 270, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Mathematics');
INSERT INTO department (id, displayorder, emails, name) VALUES (80, 280, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Mechanical & Aerospace Engr');
INSERT INTO department (id, displayorder, emails, name) VALUES (87, 430, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400116f6172407072696e6365746f6e2e65647578', 'Woodrow Wilson School');
INSERT INTO department (id, displayorder, emails, name) VALUES (82, 220, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000107708000000100000000078', 'History');
INSERT INTO department (id, displayorder, emails, name) VALUES (74, 300, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Molecular Biology');
INSERT INTO department (id, displayorder, emails, name) VALUES (104, 310, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Music');
INSERT INTO department (id, displayorder, emails, name) VALUES (93, 320, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Near Eastern Studies');
INSERT INTO department (id, displayorder, emails, name) VALUES (88, 330, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Neuroscience');
INSERT INTO department (id, displayorder, emails, name) VALUES (78, 340, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Ops Research & Financial Engr');
INSERT INTO department (id, displayorder, emails, name) VALUES (103, 350, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Philosophy');
INSERT INTO department (id, displayorder, emails, name) VALUES (75, 360, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Physics');
INSERT INTO department (id, displayorder, emails, name) VALUES (79, 370, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Politics');
INSERT INTO department (id, displayorder, emails, name) VALUES (98, 380, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Psychology');
INSERT INTO department (id, displayorder, emails, name) VALUES (102, 390, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Religion');
INSERT INTO department (id, displayorder, emails, name) VALUES (96, 400, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Slavic Languages & Literatures');
INSERT INTO department (id, displayorder, emails, name) VALUES (84, 410, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Sociology');
INSERT INTO department (id, displayorder, emails, name) VALUES (77, 420, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Spanish and Portuguese');
INSERT INTO department (id, displayorder, emails, name) VALUES (111, 100, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000007708000000010000000078', 'Computer Science');


--
-- Data for Name: document_type; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO document_type (id, displayorder, level, name) VALUES (5, 0, 1, 'yes');
INSERT INTO document_type (id, displayorder, level, name) VALUES (6, 10, 1, 'no');


--
-- Data for Name: email_template; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO email_template (id, displayorder, message, name, subject, systemrequired) VALUES (9, 80, '
Dear Department Administrator: 

{FULL_NAME} has submitted their thesis. It is available for your review at:

    {STUDENT_URL}

The following information is included for your convenience: 

Title: {DOCUMENT_TITLE}

Instructions for reviewing, downloading and sharing senior theses with advisers in Thesis Central are available at xxxx. If you have any questions, please contact mudd@princeton.edu.

Best regards,

Lynn M. Durgin
Special Collections Assistant for Technical Services
Seeley G. Mudd Manuscript Library
Princeton University
65 Olden Street
Princeton, NJ 08540
609.258.5879
mudd@princeton.edu   
http://rbsc.princeton.edu/mudd 


', 'PU Initial Submission Admin', 'Received {DOCUMENT_TITLE} submission', false);
INSERT INTO email_template (id, displayorder, message, name, subject, systemrequired) VALUES (8, 70, '
Dear {FULL_NAME}: 

Congratulations on submitting your senior thesis!  Please retain this email for your records.

The submission is available for your review at:

    {STUDENT_URL}

Title: {DOCUMENT_TITLE}

You will not be able to edit this submission; if you need to resubmit your thesis for any reason Thesis Central will allow you to do so, but you must notify your undergraduate administrator that you are resubmitting, and you will need special permission to submit past the deadline.

Senior Thesis Archive
Each senior thesis is deposited in the Princeton University Undergraduate Senior Theses, 1924-2017 collection (http://dataspace.princeton.edu/jspui/handle/88435/dsp019c67wm88m) managed by the Princeton University Archives. The theses are available in full text only to the Princeton University computing network. 

If you wish to further restrict access to your thesis, you must submit a Restricted Access Form to the Office of the Dean of the College before 11:55 pm on commencement day, Tuesday June 5, 2018. See ODOC''s Thesis Archive webpage (https://undergraduateresearch.princeton.edu/independent-work/thesis-archive) for more information.

Have questions?
For questions about your senior thesis, please contact your department''s undergraduate program coordinator.
For questions about an access restriction request, please contact staccess@princeton.edu.
For questions about this site, or the online repository of senior theses, please contact mudd@princeton.edu.

Do not reply to this email as this is an automated notification that is unable to receive replies.

Thank you again for your submitting your senior thesis, and best of luck for the remainder of the year and in your next endeavors.

Sincerely,
Pascale M. Poussart
Director of Undergraduate Research
Office of the Dean of the College

Daniel J. Linke
University Archivist
Seeley G. Mudd Manuscript Library', 'PU Initial Submission', 'Received {DOCUMENT_TITLE} submission', false);


--
-- Data for Name: email_workflow_rule_conditions; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO email_workflow_rule_conditions (id, conditionid, conditiontype, displayorder) VALUES (3, NULL, 0, 3);
INSERT INTO email_workflow_rule_conditions (id, conditionid, conditiontype, displayorder) VALUES (5, 2, 1, 5);
INSERT INTO email_workflow_rule_conditions (id, conditionid, conditiontype, displayorder) VALUES (7, 1, 1, 7);


--
-- Data for Name: email_workflow_rules; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

UPDATE email_workflow_rules SET isdisabled = True WHERE  issystem = True;
INSERT INTO email_workflow_rules (id, associatedstate, displayorder, isdisabled, issystem, recipienttype, admingrouprecipientid, conditionid, emailtemplateid) VALUES (7, 'Submitted', 7, false, false, 3, NULL, 7, 9);
INSERT INTO email_workflow_rules (id, associatedstate, displayorder, isdisabled, issystem, recipienttype, admingrouprecipientid, conditionid, emailtemplateid) VALUES (3, 'Submitted', 3, false, false, 0, NULL, 3, 8);
INSERT INTO email_workflow_rules (id, associatedstate, displayorder, isdisabled, issystem, recipienttype, admingrouprecipientid, conditionid, emailtemplateid) VALUES (5, 'Submitted', 5, false, false, 4, NULL, 5, 9);


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO language (id, displayorder, name) VALUES (4, 0, 'ar');
INSERT INTO language (id, displayorder, name) VALUES (5, 10, 'ca');
INSERT INTO language (id, displayorder, name) VALUES (6, 20, 'zh');
INSERT INTO language (id, displayorder, name) VALUES (7, 30, 'hr');
INSERT INTO language (id, displayorder, name) VALUES (8, 40, 'cs');
INSERT INTO language (id, displayorder, name) VALUES (9, 50, 'da');
INSERT INTO language (id, displayorder, name) VALUES (11, 60, 'nl');
INSERT INTO language (id, displayorder, name) VALUES (1, 70, 'en');
INSERT INTO language (id, displayorder, name) VALUES (13, 80, 'et');
INSERT INTO language (id, displayorder, name) VALUES (14, 90, 'fi');
INSERT INTO language (id, displayorder, name) VALUES (15, 100, 'fr');
INSERT INTO language (id, displayorder, name) VALUES (2, 110, 'de');
INSERT INTO language (id, displayorder, name) VALUES (16, 120, 'el');
INSERT INTO language (id, displayorder, name) VALUES (17, 130, 'iw');
INSERT INTO language (id, displayorder, name) VALUES (18, 140, 'hu');
INSERT INTO language (id, displayorder, name) VALUES (19, 150, 'is');
INSERT INTO language (id, displayorder, name) VALUES (20, 160, 'ga');
INSERT INTO language (id, displayorder, name) VALUES (3, 170, 'it');
INSERT INTO language (id, displayorder, name) VALUES (21, 180, 'ja');
INSERT INTO language (id, displayorder, name) VALUES (22, 190, 'ko');
INSERT INTO language (id, displayorder, name) VALUES (23, 200, 'lv');
INSERT INTO language (id, displayorder, name) VALUES (24, 210, 'no');
INSERT INTO language (id, displayorder, name) VALUES (25, 220, 'pl');
INSERT INTO language (id, displayorder, name) VALUES (26, 230, 'pt');
INSERT INTO language (id, displayorder, name) VALUES (27, 240, 'ro');
INSERT INTO language (id, displayorder, name) VALUES (28, 250, 'ru');
INSERT INTO language (id, displayorder, name) VALUES (29, 260, 'es');
INSERT INTO language (id, displayorder, name) VALUES (30, 270, 'sv');
INSERT INTO language (id, displayorder, name) VALUES (31, 280, 'tr');
INSERT INTO language (id, displayorder, name) VALUES (32, 290, 'uk');


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: thesis-dev
--

INSERT INTO program (id, displayorder, emails, name) VALUES (200, 90, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Dance Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (201, 100, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'East Asian Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (202, 110, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Engineering Biology Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (192, 10, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'African Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (203, 120, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Engineering and Management Systems Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (204, 130, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Environmental Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (205, 140, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Ethnographic Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (206, 150, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'European Cultural Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (207, 160, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Geological Engineering Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (209, 180, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Hellenic Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (210, 190, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Humanities Council and Humanistic Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (212, 210, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Latin American Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (214, 230, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Linguistics Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (216, 250, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Medieval Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (217, 260, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Musical Performance Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (219, 280, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Neuroscience Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (221, 300, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Entrepreneurship');
INSERT INTO program (id, displayorder, emails, name) VALUES (222, 310, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Gender and Sexuality Studies');
INSERT INTO program (id, displayorder, emails, name) VALUES (224, 330, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Music Theater');
INSERT INTO program (id, displayorder, emails, name) VALUES (226, 350, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Technology & Society, Energy Track');
INSERT INTO program (id, displayorder, emails, name) VALUES (228, 370, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Values and Public Life');
INSERT INTO program (id, displayorder, emails, name) VALUES (229, 380, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Quantitative and Computational Biology Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (231, 400, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Russian & Eurasian Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (232, 410, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'South Asian Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (234, 430, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Theater Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (236, 450, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Urban Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (237, 460, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Visual Arts Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (191, 0, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'African American Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (208, 170, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Global Health and Health Policy Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (211, 200, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Judaic Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (213, 220, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Latino Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (215, 240, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Materials Science and Engineering Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (218, 270, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Near Eastern Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (220, 290, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Cognitive Science');
INSERT INTO program (id, displayorder, emails, name) VALUES (223, 320, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Jazz Studies');
INSERT INTO program (id, displayorder, emails, name) VALUES (225, 340, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Planets and Life');
INSERT INTO program (id, displayorder, emails, name) VALUES (227, 360, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Program in Technology & Society, Technology Track');
INSERT INTO program (id, displayorder, emails, name) VALUES (230, 390, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Robotics & Intelligent Systems Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (233, 420, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Sustainable Energy Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (235, 440, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Translation and Intercultural Communication Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (193, 20, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'American Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (194, 30, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Applications of Computing Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (195, 40, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Architecture and Engineering Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (196, 50, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Canadian Studies Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (197, 60, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Center for Statistics and Machine Learning');
INSERT INTO program (id, displayorder, emails, name) VALUES (198, 70, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000077080000000100000001737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400156c64757267696e407072696e6365746f6e2e65647578', 'Contemporary European Politics and Society Program');
INSERT INTO program (id, displayorder, emails, name) VALUES (199, 80, '\xaced0005737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000002737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000007400187570612d746865736973407072696e6365746f6e2e6564757371007e0002000000017400156c64757267696e407072696e6365746f6e2e65647578', 'Creative Writing Program');


--
-- PostgreSQL database dump complete
--

