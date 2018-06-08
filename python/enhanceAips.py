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


EXPORT_STATUS = ['Approved']

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
        parser.add_argument("--export", required=True, help="directory for enhanced aips")
        parser.add_argument("--loglevel", "-l", choices=loglevels,  default=logging.INFO, help="log level  - default: ERROR")
        return parser;

    def parse_args(self):
        args= argparse.ArgumentParser.parse_args(self)
        # test whether export dir exists
        if not os.path.isdir(args.export):
            raise Exception("%s is not a directory" % args.export)
        if not os.path.isdir(args.aips):
            raise Exception("%s is not a directory" % args.aips)
        return args

def enhanceAips(submissions, moreCerts, restrictions, aip_dir, export_dir):
    multi_author_indx = submissions.col_index_of(VireoSheet.MULTI_AUTHOR)
    print("\t".join(submissions.col_names()))
    for sub_id in submissions.id_rows:
        sub = submissions.id_rows[sub_id][0]
        print("\t".join(VireoSheet.row_values(sub)))
        if (sub[multi_author_indx].value == 'yes'):
            logging.warning("%s: submission with ID %d is a multi author thesis" % (submissions.file_name, sub_id))
        # read aip for submission
        if (sub_id in moreCerts.id_rows):
            print("TODO add certitificates")
        if (sub_id in restrictions.id_rows):
            print("TODO add restrictions")

def main():

    try:
        parser = ArgParser.create()
        args = parser.parse_args()

        logging.getLogger().setLevel(args.loglevel)
        logging.basicConfig()

        submissions = VireoSheet.VireoSheet(args.thesis)
        submissions.col_index_of(VireoSheet.MULTI_AUTHOR)
        submissions.log_info()

        moreCerts = submissions.readMoreCerts(args.add_certs, check_id=False)
        moreCerts.log_info()

        restrictions = submissions.readRestrictions(args.restrictions, check_id=True)
        restrictions.log_info()

        enhanceAips(submissions, moreCerts, restrictions, args.aips, args.export)


    except Exception as e:
        logging.error(e)
        logging.debug(traceback.format_exc())
        sys.exit(1)

if __name__ == "__main__":
    main()
