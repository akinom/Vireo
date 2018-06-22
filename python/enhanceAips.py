
from lxml import etree as ET

import argparse

import datetime
import logging
import traceback
import os
import sys

# for the benefit of IDE import two ways
try:
    from vireo import VireoSheet
except Exception:
    from .vireo import VireoSheet

class ArgParser(argparse.ArgumentParser):
    @staticmethod
    def create():
        description = """
read thesis submission info from file given in --thesis option 
read additional certificate programs from  --add_certs file 
read access restriction info from --restrictions file 

warn when encounterig a multi author thesis 

enhance pu-metadata.xml in AIPS in submission_<ID> subdirections of export directory where needed
"""
        loglevels = ['CRITICAL', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'NOTSET']

        parser = ArgParser(description=description, formatter_class=argparse.RawTextHelpFormatter)
        parser.add_argument("--thesis", "-t", required=True, help="excel export file from vireo")
        parser.add_argument("--add_certs", "-a", required=True, help="excel spreadsheet with additional certificate program info")
        parser.add_argument("--restrictions", "-r", required=True, help="TODO access restrictions")
        parser.add_argument("--aips",  required=True, help="directory with DSPace AIPS")
        parser.add_argument("--loglevel", "-l", choices=loglevels,  default=logging.INFO, help="log level  - default: ERROR")
        return parser;

    def parse_args(self):
        args= argparse.ArgumentParser.parse_args(self)
        if not os.path.isdir(args.aips):
            raise Exception("%s is not a directory" % args.aips)
        return args

class EnhanceAips:
    EXPORT_STATUS = ['Approved']

    def __init__(self, submissions, aip_dir):
        self.aip_dir = aip_dir
        self.submissions = submissions
        self.submissions_tbl = self._make_submission_table()
        self.walkin_idx = len(self.submissions_tbl[0]) -1
        self.embargo_idx = self.walkin_idx - 1
        self.classyear = str(datetime.datetime.now().year)

        self._confirm_aip_export_dir()
        try:
            self._fix_multi_author()
        except Exception as e:
            #TODO later
            logging.warning(e)

    def print_table(self, sep="\t", file=sys.stdout):
        print(sep.join(self.submissions.col_names() + [VireoSheet.R_EMBARGO, VireoSheet.R_WALK_IN]), file=file)
        for row in self.submissions_tbl:
            print(sep.join(str(x) for x in row), file=file)

    def _make_submission_table(self):
        aip_tbl = []
        idx = self.submissions.col_index_of(VireoSheet.ID)
        stud_idx = self.submissions.col_index_of(VireoSheet.STUDENT_NAME)
        cp_idx = self.submissions.col_index_of(VireoSheet.CERTIFICATE_PROGRAM)
        multi_idx = self.submissions.col_index_of(VireoSheet.MULTI_AUTHOR)
        for sub_id in self.submissions.id_rows:
            vals = VireoSheet.row_values(self.submissions.id_rows[sub_id][0])
            vals[idx] = int(vals[idx])
            vals[multi_idx] = not vals[multi_idx] == "no"
            #vals[stud_idx] = [ vals[stud_idx] ]
            cp = vals[cp_idx]
            vals[cp_idx] =  [cp] if (cp) else []
            logging.debug("\t".join(str(_) for _ in vals) + "\n")
            # add two cols at end for walkin and embargo restrictions
            aip_tbl.append(vals + [None, None])
        return aip_tbl


    def _confirm_aip_export_dir(self):
        """
        raise an exception if there is no aip directory for one of the submissions

        :param aip_dir:   path to directory with DSpace aio subdirectories
        :return: void
        """
        idx = self.submissions.col_index_of(VireoSheet.ID)
        status_idx = self.submissions.col_index_of(VireoSheet.STATUS)
        for row in self.submissions_tbl:
            if (row[status_idx] in EnhanceAips.EXPORT_STATUS ):
                os.stat("%s/submission_%d/contents" % (self.aip_dir, int(float(row[idx]))))

    def _fix_multi_author(self):
        has_multi = False
        status_idx = self.submissions.col_index_of(VireoSheet.STATUS)
        multi_idx = self.submissions.col_index_of(VireoSheet.MULTI_AUTHOR)
        for sub in self.submissions_tbl:
            if sub[status_idx] in EnhanceAips.EXPORT_STATUS and sub[multi_idx]:
                logging.error(("TODO: Can't do multi suthor thesis"))
                has_multi = True
        if (has_multi):
            raise Exception("Multi author - can not do it yet")

    def addCertiticates(self, moreCerts):
        idx = self.submissions.col_index_of(VireoSheet.ID)
        cp_idx = self.submissions.col_index_of(VireoSheet.CERTIFICATE_PROGRAM)
        more_cp_idx = moreCerts.col_index_of(VireoSheet.CERTIFICATE_PROGRAM)
        for sub in self.submissions_tbl:
            sub_id = sub[idx]
            if (sub_id in moreCerts.id_rows):
                for row in moreCerts.id_rows[sub_id]:
                    pgm = VireoSheet.row_values(row)[more_cp_idx]
                    logging.debug("ADDING cert program '%s' to submission with ID %d" %(pgm, sub[idx]))
                    sub[cp_idx].append(pgm)

    def addRestrictions(self, vireo_sheet):
        idx = self.submissions.col_index_of(VireoSheet.ID)
        walkin_idx = vireo_sheet.col_index_of(VireoSheet.R_WALK_IN)
        embargo_idx = vireo_sheet.col_index_of(VireoSheet.R_EMBARGO)
        for sub in self.submissions_tbl:
            sub[self.embargo_idx] = 0
            sub[self.walkin_idx] = False
            sub_id = sub[idx]
            if (sub_id in vireo_sheet.id_rows):
                for row in vireo_sheet.id_rows[sub_id]:
                    logging.debug("ADDING restriction submission with ID %d" %(sub[idx]))
                    sub[self.walkin_idx] = ("Yes" == row[walkin_idx].value)
                    if ( "N/A" == row[embargo_idx].value):
                        sub[self.embargo_idx] = 0
                    else:
                        sub[self.embargo_idx] = int(row[embargo_idx].value)

    def create_pu_xmls(self):
        idx = self.submissions.col_index_of(VireoSheet.ID)
        for sub in self.submissions_tbl:
            sub_xml = self._create_pu_xml(sub)
            self.write_xml_file(sub[idx], sub_xml)


    def  _create_pu_xml(self, sub):
        author_id_idx = self.submissions.col_index_of(VireoSheet.STUDENT_ID)
        dept_idx = self.submissions.col_index_of(VireoSheet.DEPARTMENT)
        pgm_idx = self.submissions.col_index_of(VireoSheet.CERTIFICATE_PROGRAM)
        type_idx = self.submissions.col_index_of(VireoSheet.THESIS_TYPE)

        root = ET.Element('dublin_core', {'schema' : 'pu', 'encoding': "utf-8"})
        self.add_el(root, 'date.classyear', self.classyear)
        self.add_el(root, 'contributor.qualifier', sub[author_id_idx])
        if ('Department' in sub[type_idx]):
            self.add_el(root, 'department', sub[dept_idx])
        for p in sub[pgm_idx]:
            self.add_el(root, 'certificate', p)


        return root

    def add_el(self, root, metadata, value):
        splits = metadata.split('.')
        attrs = { 'element' : splits[0]}
        if len(splits) > 1:
            attrs['qualifier'] = splits[1]
        ET.SubElement(root, 'dcvalue', attrib=attrs).text = value

    def write_xml_file(self, sub_id, root):
        f= open("%s/submission_%d/metadata_pu.xml" % (self.aip_dir, sub_id), 'w')
        logging.info("writing %s" % f.name)
        f.write(ET.tostring(root, encoding='utf8', method='xml', pretty_print=True).decode())
        f.close()


def main():
    try:
        enhancer = None

        parser = ArgParser.create()
        args = parser.parse_args()

        logging.getLogger().setLevel(args.loglevel)
        logging.basicConfig()

        submissions = VireoSheet.createFromExcelFile(args.thesis)
        submissions.col_index_of(VireoSheet.MULTI_AUTHOR)
        submissions.log_info()

        moreCerts = submissions.readMoreCerts(args.add_certs, check_id=False)
        moreCerts.log_info()

        restrictions = submissions.readRestrictions(args.restrictions, check_id=False)
        restrictions.log_info()

        enhancer = EnhanceAips(submissions, args.aips)
        enhancer.addCertiticates(moreCerts)
        enhancer.addRestrictions(restrictions)
        enhancer.print_table(file=sys.stdout)
        enhancer.create_pu_xmls()
        #_enhanceAips(submissions, moreCerts, restrictions, args.aips)

    except Exception as e:
        logging.error(e)
        logging.debug(traceback.format_exc())
        sys.exit(1)

if __name__ == "__main__":
    main()
