import argparse

import logging
import traceback
import openpyxl
import sys
from copy import deepcopy;
import importlib

def snippet():
    logging.getLogger().setLevel('INFO')
    # code snippet when in case you want to test in interactive python
    wb = openpyxl.load_workbook(filename = 'Thesis.xlsx')
    sheet = wb.worksheets[0]
    v = VireoSheet('Thesis.xlsx')
    v.log_info()
    certs = v.readMoreCerts('AdditionalPrograms.xlsx')
    certs.log_info()
    return certs


class ArgParser(argparse.ArgumentParser):
    @staticmethod
    def create():
        description = """read thesis submission info from file given in --thesis option 
if --add_certs option is given when reading info about additional certificate programs from file                  
               and adding appitional entries in the thesis submission list 
    """
        loglevels = ['CRITICAL', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'NOTSET']

        parser = ArgParser(description=description, formatter_class=argparse.RawTextHelpFormatter)
        parser.add_argument("--thesis", "-t", default=None, required=True, help="excel export file from vireo")
        parser.add_argument("--split_col", "-s", required=False, default=VireoSplitter.CERTIFICATE_PROGRAM, help="split column name - default %s" % VireoSplitter.CERTIFICATE_PROGRAM)
        parser.add_argument("--add_certs", "-a", default=None, required=False, help="excel spreadsheet with additional certificate program info")
        parser.add_argument("--all_cols", "-A", action='store_true', help="include all columns in printout")
        parser.add_argument("--loglevel", "-l", choices=loglevels,  default=logging.INFO, help="log level  - default: ERROR")
        return parser;

    def parse_args(self):
        args= argparse.ArgumentParser.parse_args(self)
        try:
            args.vireo = VireoSplitter(args)
        except Exception as e:
            raise e
        return args

class VireoSheet:
    CERTIFICATE_PROGRAM = 'Certificate Program'
    STUDENT_NAME = 'Student name'
    DEPARTMENT = 'Department'
    SUBMISSION_DATE = 'Submission date'
    ADVISORS = 'Advisors'
    DOCUMENT_TITLE = 'Title'
    PRIMARY_DOCUMENT = 'Primary document'
    THESIS_TYPE = 'Thesis Type'
    STUDENT_EMAIL = 'Student email'
    ID = 'ID'

    def __init__(self, thesis_file, unique_ids=True):
        """
        read from execl file
        check that there is only one sheet with an ID column
        :param thesis_file:   excel file
        """
        self.file_name = thesis_file
        thesis_wb = openpyxl.load_workbook(filename = thesis_file)
        if (1 != len(thesis_wb.worksheets)) :
            raise Exception("%s should have exactly one sheet" % (thesis_file))
        self._sheet = thesis_wb.worksheets[0]
        self.id_col = self.col_index_of(VireoSheet.ID, required=True)
        self.id_rows = {}
        for row in self._sheet.iter_rows(min_row=2):
            if not row[self.id_col].value:
                logging.warning("Row has no ID value: %s" % str.join(',',(str(cell.value).strip() for cell in row)))
            else:
                id = int(row[self.id_col].value)
                if not id in self.id_rows:
                    self.id_rows[id] = [row]
                elif unique_ids:
                    raise Exception("%s has duplicate id %s" % (thesis_file, str(id)))
                else:
                    self.id_rows[id].append(row)



    def col_names(self):
        hdrs = next(self._sheet.iter_rows(min_row=1, max_row=1))
        return VireoSheet.row_values(hdrs)

    def col_index_of(self, col_header, required=False):
        try:
            return self.col_names().index(col_header)
        except ValueError as e:
            if (required):
                raise Exception("%s does not contain a '%s' column" % (self.file_name, col_header))
        return None;

    staticmethod
    def row_values(row):
        return [str(cell.value).strip() for cell in row]

    def readMoreCerts(self, add_certs_file):
        add_certs = VireoSheet(add_certs_file, unique_ids=False)
        # check that required columns are present
        certs_email_col_id = add_certs.col_index_of(VireoSheet.STUDENT_EMAIL, required=True)
        certs_cert_col_id = add_certs.col_index_of(VireoSheet.CERTIFICATE_PROGRAM, required=True)
        thesis_email_col_id = self.col_index_of(VireoSheet.STUDENT_EMAIL, required=True)
        thesis_cert_col_id = self.col_index_of(VireoSheet.CERTIFICATE_PROGRAM, required=True)
        # look through whether certs file info matches thesis sheet info
        for cert_id in add_certs.id_rows:
            if not cert_id in  self.id_rows:
                raise Exception("%s, row with ID %d: there is no such row in %s" % (add_certs.file_name, cert_id, self.file_name))
            thesis_row = self.id_rows[cert_id][0]
            for row in  add_certs.id_rows[cert_id]:
                logging.debug("ID %d -> cert_row: %s" % (cert_id, VireoSheet.row_values(row)))
                # check that student email matches
                if (row[certs_email_col_id].value.strip() != thesis_row[thesis_email_col_id].value.strip()):
                    raise Exception("%s, row with ID %d: email mistmatch with same row in %s" % (add_certs.file_name, cert_id, self.file_name))
                # check that certificate program enry is not empty
                if not row[certs_cert_col_id].value:
                    raise Exception("%s, row with ID %d: row has empty certificate value" % (add_certs.file_name, cert_id))
        return add_certs

    def log_info(self):
        logging.info(str(self))
        logging.info("%s: headers %s" % (self.file_name, str.join(',', self.col_names())))
        for col in [VireoSheet.STUDENT_EMAIL, VireoSheet.CERTIFICATE_PROGRAM]:
            logging.info("%s column: %s (%d)" % (self.file_name, col, self.col_index_of(col)))

    def __str__(self):
        return "%s: ID-col:%d, nrows:%d" % (self.file_name, self.id_col, len(self.id_rows))


class VireoSplitter:

    PRINT_COLUMNS = [VireoSheet.CERTIFICATE_PROGRAM, VireoSheet.STUDENT_NAME,
                     VireoSheet.DEPARTMENT, VireoSheet.SUBMISSION_DATE,
                     VireoSheet.ADVISORS, VireoSheet.DOCUMENT_TITLE, VireoSheet.PRIMARY_DOCUMENT]

    NOSPLIT_KEY = '___NO_SPLIT___'

    testing = False;

    def __init__(self, args):
        super(args.thesis)
        if (args.add_certs):
            self.addCertificates(args.add_certs)

        VireoSplitter.testing = (args.loglevel == logging.getLevelName(logging.DEBUG))
        if (args.split_col):
            self._split_col = self.submissions.col_index_of(args.split_col, required=True)
        else:
            self._split_col = None

        thesis_col_names = self.submissions.col_names()
        if (args.all_cols):
            print_col_names = thesis_col_names
        else:
            print_col_names = list(filter(lambda x: x in thesis_col_names, VireoSheet.PRINT_COLUMNS))
        self._print_col_ids = [thesis_col_names.index(v) for v in print_col_names]

    def log_info(self):
        super.log_info()
        if (self._split_col): logging.info("thesis split column: %s (%d)" % (self.submissions.col_names()[self._split_col], self._split_col));
        logging.info("print cols: " + ", ".join(self.print_col_ids) )

    def main(args):
        vireo = VireoSplitter(args);
        vireo.log_info();
        splits = vireo.split_sheet()
        vireo.print(splits);

    def _col_index_of(self, sheet, title):
        for row in sheet.iter_rows(min_row=1, max_row=1):
            for cell in  row:
                if (cell.value.strip() == title):
                    return cell.col_idx -1;
        return None;

    def split_sheet(self):
        splits = {}
        splits = self._split_rows(splits, self._add_certificates())
        if (VireoSplitter.testing):
            num_rows = sum(1 for _ in  self._add_certificates())
            logging.debug("# %d certificate rows " % num_rows)
            num_split_rows = self.count_rows("add_certs", splits)
            if (num_rows != num_split_rows):
                logging.error("SANITY CHECK FAILED: # cert rows (%d) != #rows in splits (%d)" % (num_rows, num_split_rows))

        splits = self._split_rows(splits, self.thesis.iter_rows(min_row=2))
        if (VireoSplitter.testing):
            num_rows = num_rows + sum(1 for _ in  self.thesis.iter_rows(min_row=2))
            logging.debug("# %d thesis rows + certificate rows " % num_rows)
            num_split_rows = self.count_rows("thesis", splits)
            if (num_rows != num_split_rows):
                logging.error("SANITY CHECK FAILED: #thesis rows (%d) != #rows in splits (%d)" % (num_rows, num_split_rows))

        return splits

    def count_rows(self, label, splits):
        logging.info("%s #%d split_keys " % (label, len(splits)))
        s = 0
        for k in splits:
            s = s + len(splits[k])
            logging.debug("#%s: %d entries in '%s'" % (label, len(splits[k]), str(k)))
        logging.info("%s total entries %d" % (label, s))
        return s

    def _split_rows(self, splits, iter):
        if (None != self._split_col):
            for row in iter:
                col_val = row[self._split_col].value
                if (None != col_val):
                    col_val = col_val.strip()
                else:
                    col_val = '';
                if (col_val in splits):
                    splits[col_val].append(row);
                else:
                    splits[col_val] = [row]
        else:
            for row in iter:
                if (VireoSplitter.NOSPLIT_KEY in splits):
                    splits[VireoSplitter.NOSPLIT_KEY].append(row);
                else:
                    splits[VireoSplitter.NOSPLIT_KEY] = [row];

        return splits

    def _add_certificates(self):
        if (self._add_rows == None):
            add_rows = []
            if ('add_certs' in dir(self)):
                certs_id_col = self._col_index_of(self.add_certs, VireoSheet.ID);
                certs_cert_col = self._col_index_of(self.add_certs, VireoSheet.CERTIFICATE_PROGRAM)
                certs_email_col = self._col_index_of(self.add_certs, VireoSheet.STUDENT_EMAIL)
                thesis_email_col = self._col_index_of(self.thesis, VireoSheet.STUDENT_EMAIL)
                thesis_cert_col = self._col_index_of(self.thesis, VireoSheet.CERTIFICATE_PROGRAM)
                if (certs_id_col == None or certs_cert_col == None or certs_email_col == None or thesis_email_col == None or thesis_cert_col == None):
                    raise RuntimeError("programming error: should never get here - see checks in constructor")

                thesis_ids = self.submissions.id_rows();
                # go through all data rows in add_certs sheet
                i = 1  #header row is row one
                for row in self.add_certs.iter_rows(min_row=2):
                    i = i + 1
                    sub_id = row[certs_id_col].value
                    if (sub_id):
                        if (sub_id in thesis_ids):
                            add_cert = deepcopy(thesis_ids[row[self.thesis_id_col].value])
                            if (add_cert[thesis_email_col].value.strip() != row[certs_email_col].value.strip()):
                                logging.error("add_certs/thesis Sheet: %s and %s disagree on student email for submission with ID %s " % (
                                self.thesis.title, self.add_certs.title, sub_id));
                            else:
                                logging.debug("add_cert %d %s->%s %s" % (sub_id,  add_cert[thesis_cert_col].value, row[thesis_cert_col].value, add_cert[thesis_email_col]))
                                add_cert[thesis_cert_col].value = row[certs_cert_col].value
                                add_rows.append(add_cert)
                        else:
                                logging.error("add_certs Sheet: No thesis with ID %s found in %s" % (sub_id, self.thesis.title))
                    else:
                        if (row[certs_cert_col].value or row[certs_email_col].value or row[certs_email_col].value):
                            logging.error("add_certs Sheet: row %d in has no ID but other values" % i)

            self._add_rows = add_rows
        return self._add_rows

    def _header(sheet):
        return next(sheet.iter_rows(min_row=1, max_row=1))

    def print(self, splits):
        logging.info("printing %d tsv files" % len(splits))
        if VireoSplitter.NOSPLIT_KEY in splits:
            logging.info("no splits %s" % VireoSplitter.NOSPLIT_KEY)
            self._print_tsv(VireoSplitter._header(self.thesis), splits[VireoSplitter.NOSPLIT_KEY], sys.stdout)
        else:
            for k in splits:
                self.print_tsv(k, splits[k])

    def print_tsv(self, name, rows):
        file_name = name.replace(' ', '-')
        if not file_name:
            file_name = 'None'
        out =open(file_name + ".tsv", 'w')
        self._print_tsv(VireoSplitter._header(self.thesis), rows, out)
        out.close();

    def _print_tsv(self, header, rows, out):
        self._print_tsv_row(header, out)
        for r in rows:
            self._print_tsv_row(r, out)


    def _print_tsv_row(self, row, out):
        prt_row = [row[i] for i in self._print_col_ids]
        print('\t'.join([(str(c.value) if None != c.value else 'None') for c in prt_row]), file=out)

def main():

    try:
        parser = ArgParser.create()
        args = parser.parse_args()

        logging.getLogger().setLevel(args.loglevel)
        logging.basicConfig()

        VireoSplitter.main(args)

    except Exception as e:
        logging.error(e, file = sys.stderr)
        logging.debug(traceback.format_exc())

if __name__ == "__main__":
    main()
