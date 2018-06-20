import xml.etree.ElementTree as ET

import argparse

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

        self._confirm_aip_export_dir()
        try:
            self._fix_multi_author()
        except Exception as e:
            #TODO later
            logging.warning(e)

    def print_table(self, sep="\t", file=sys.stdout):
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
            vals[stud_idx] = [ vals[stud_idx] ]
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

def _parse_pu_metadata(xml_file):
    try:
        root = ET.parse(xml_file).getroot()
    except Exception as e:
        raise RuntimeError("xml_file %s: %s" % (xml_file, str(e)))

    props = {}
    for val in ET.parse(xml_file).getroot().findall('dcvalue'):
        try:
            attr = val.attrib
            elem= attr["element"]

            if (elem == "department"):
                if ('department' in props):  raise RuntimeError("duplicate property")
                props["department"] = val.text.strip()
            elif  (elem  == "certificate"):
                if (not 'certificate' in props):
                    props['certificate'] = []
                props['certificate'].append(val.text.strip())
            elif (elem == "contributor" and attr['qualifier'] == 'authorid'):
                if ('authorid' in props):  raise RuntimeError("duplicate property")
                props['authorid'] = val.text.strip()
        except Exception as e:
            raise RuntimeError("%s: Unparsable dcvalue '%s' text=%s  <- %s" % (xml_file, val.attrib, val.text.strip() if val.text else 'None', str(e)))
    return props


def _hash_to_pu_metadata(props, xml_file):
    root = ET.Element('dublin_core', {'schema' : 'pu'})
    for p in props:
        if (p == 'certificate'):
            for c in props['certificate']:
                ET.SubElement(root, 'dcvalue', attrib={'element' : p}).text = c
        else:
            ET.SubElement(root, 'dcvalue', {'element' : p}).text = props[p]
    ET.dump(root)
    return root



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
        #_enhanceAips(submissions, moreCerts, restrictions, args.aips)

    except Exception as e:
        if (enhancer):
            enhancer.submissions_tbl.print(file=sys.stderr)
        logging.error(e)
        logging.debug(traceback.format_exc())
        sys.exit(1)

if __name__ == "__main__":
    main()
