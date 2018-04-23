import argparse
from argparse import ArgumentError

import logging
import traceback
import openpyxl
import sys
import importlib
from copy import deepcopy;

def interactive():
    importlib.reload(certificateProgramSplit)
    wb = openpyxl.load_workbook(filename = 'ExcelExport.xlsx')
    sheet = wb.worksheets[0]
    header = next(sheet.iter_rows(min_row=1, max_row=1))


class ArgParser(argparse.ArgumentParser):
    def parse_args(self):
        args= argparse.ArgumentParser.parse_args(self)
        try:
            args.split_col_name = Vireo.CERTIFICATE_PROGRAM;
            args.vireo = Vireo(args)
        except Exception as e:
            raise e
        return args

class Vireo:
    CERTIFICATE_PROGRAM = 'Certificate Program'
    STUDENT_EMAIL = 'Student email'
    ID = 'ID'

    def __init__(self, args):
        thesis_file = args.thesis
        thesis_wb = openpyxl.load_workbook(filename = thesis_file)
        if (1 != len(thesis_wb.worksheets)) :
            raise Exception("Workbook '%s' should have exactly one sheet" % (thesis_file))
        self.thesis = thesis_wb.worksheets[0]

        self.thesis_id_col = self._col_index_of(self.thesis, Vireo.ID)
        if (None == self.thesis_id_col):
            raise Exception("Workbook '%s' does not contain a '%s' column" % (thesis_file, Vireo.ID))

        self._split_col = self._col_index_of(self.thesis, args.split_col_name)
        if (None == self._split_col):
            raise Exception("Workbook '%s' does not contain a '%s' column" % (thesis_file, args.split_col_name))

        if (args.add_certs):
            add_certs_file = args.add_certs
            add_certs_wb = openpyxl.load_workbook(filename = add_certs_file)
            if (1 != len(add_certs_wb.worksheets)) :
                raise Exception("Workbook '%s' should have exactly one sheet" % (add_certs_file))
            self.add_certs = add_certs_wb.worksheets[0]

            if (None == self._col_index_of(self.add_certs, Vireo.ID)):
                raise Exception("Workbook '%s' does not contain a '%s' column" % (add_certs_file, Vireo.ID))
            if (None == self._col_index_of(self.add_certs, Vireo.STUDENT_EMAIL)):
                raise Exception("Workbook '%s' does not contain a '%s' column" % (add_certs_file, Vireo.STUDENT_EMAIL))
            if (None == self._col_index_of(self.thesis, Vireo.STUDENT_EMAIL)):
                raise Exception("Workbook '%s' does not contain a '%s' column" % (thesis_file, Vireo.STUDENT_EMAIL))

        self.id_rows = {}
        self._id_rows()

    def print_info(self):
        header = Vireo._header(self.thesis);
        print("thesis workbook %s" % self.thesis.title)
        print("thsis id column: %s (%d)" % (Vireo.ID,  self.thesis_id_col))
        print("thsis split column: %s (%d)" % (header[self._split_col].value, self._split_col));
        if ('add_certs' in dir(self)):
            print("thesis check column: %s (%d)" % (Vireo.STUDENT_EMAIL,  self._col_index_of(self.thesis, Vireo.STUDENT_EMAIL)))
            print("add_certs id column: %s (%d)" % (Vireo.ID,  self._col_index_of(self.add_certs, Vireo.ID)))
            print("add_certs check column: %s (%d)" % (Vireo.STUDENT_EMAIL,  self._col_index_of(self.add_certs, Vireo.STUDENT_EMAIL)))
            print("add_certs certs column: %s (%d)" % (Vireo.CERTIFICATE_PROGRAM,  self._col_index_of(self.add_certs, Vireo.CERTIFICATE_PROGRAM)))

    def _col_index_of(self, sheet, title):
        for row in sheet.iter_rows(min_row=1, max_row=1):
            for cell in  row:
                if (cell.value.strip() == title):
                    return cell.col_idx -1;
        return None;

    def _dump_sheet(self, sheet):
        for row in sheet.iter_rows(min_row=1, max_row=1):
            for cell in  row:
                print("%s" % (cell.value))
            print("---")

    def _add_certificates(self):
        if ('add_certs' in dir(self)):
            certs_id_col = self._col_index_of(self.add_certs, Vireo.ID);
            certs_email_col = self._col_index_of(self.add_certs, Vireo.STUDENT_EMAIL)
            thesis_email_col = self._col_index_of(self.thesis, Vireo.STUDENT_EMAIL)
            if (certs_id_col == None or certs_email_col == None or thesis_email_col == None):
                raise RuntimeError("programming error: should never get here - see checks in constructor")


    def split_sheet(self):
        self._add_certificates()
        splits = {};
        for row in self.thesis.iter_rows(min_row=2):
            col_val = row[self._split_col].value
            if (None != col_val):
                if (col_val in splits):
                    splits[col_val].append(row);
                else:
                    splits[col_val] = [row];
        return splits

    def _id_rows(self):
        if not self.id_rows:
            for row in self.thesis.iter_rows(min_row=2):
                id = row[self.thesis_id_col].value
                if (id in self.id_rows):
                    raise "duplicate id %s" % str(id)
                self.id_rows[id] = row


    def _header(sheet):
        return next(sheet.iter_rows(min_row=1, max_row=1))

    def print_tsv(self, name, rows):
        print("> Print %s (%d)" % (name, len(rows)));
        file_name = name.replace(' ', '-')
        if not file_name:
            file_name = 'None'
        out =open(file_name + ".tsv", 'w')
        Vireo._print_tsv_row(Vireo._header(self.thesis), out)
        for r in rows:
            Vireo._print_tsv_row(r, out)
        out.close();
        print("< Print %s" % name);

    def _print_tsv_row(row, out):
        #print('\t'.join([c.value for c in row]), file=out)
        print('\t'.join([(str(c.value) if None != c.value else 'None') for c in row]), file=out)

def main():
    description = """split vireo excel export file into multiple files based on first column value
    ignore entries that do not have a value in the first column"""
    loglevels = ['CRITICAL', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'NOTSET']

    parser = ArgParser(description=description, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("--thesis", "-t", default=None, required=True, help="excel export file from vireo")
    parser.add_argument("--add_certs", "-a", default=None, required=False, help="excep spreadsheet with addituion certificate program info")
    parser.add_argument("--loglevel", choices=loglevels,  default=logging.ERROR, help="log level  - default: ERROR")
    args = parser.parse_args()
    try:
        vireo = args.vireo;

        logging.getLogger().setLevel(args.loglevel)
        logging.basicConfig()

        vireo.print_info();
        splits = vireo.split_sheet();
        for k in splits.keys():
            vireo.print_tsv(k, splits[k])
    except Exception as e:
        print(e, file = sys.stderr)
        print(traceback.format_exc())

if __name__ == "__main__":
    main()
