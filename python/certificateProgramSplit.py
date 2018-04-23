import argparse
from argparse import ArgumentError

import logging
import openpyxl
import sys
import importlib

def interactive():
    importlib.reload(certificateProgramSplit)
    wb = openpyxl.load_workbook(filename = 'ExcelExport.xlsx')
    sheet = wb.worksheets[0]
    header = next(sheet.iter_rows(min_row=1, max_row=1))


class ArgParser(argparse.ArgumentParser):
    def parse_args(self):
        args= argparse.ArgumentParser.parse_args(self)
        try:
            args.vireo = Vireo(args)
        except Exception as e:
            raise e
        return args

class Vireo:
    def __init__(self, args):
        self.thesis_file = args.thesis
        self.thesis_wb = openpyxl.load_workbook(filename = args.thesis)
        if (1 != len(self.thesis_wb.worksheets)) :
            raise Exception("Workbook '%s' should have exactly one sheet" % (args.thesis_excel))
        self.thesis = self.thesis_wb.worksheets[0]
        self.split_col_name = 'Certificate Program'
        self.split_col = self._col_index_of(self.split_col_name)
        if (None == self.split_col):
            raise Exception("Workbook '%s' does not contain a '%s' column" % (args.thesis_excel, self.split_col_name))
        self.id_col_name = 'ID'
        self.id_col = self._col_index_of(self.id_col_name)
        if (None == self.id_col):
            raise Exception("Workbook '%s' does not contain a '%s' column" % (args.thesis_excel, self.id_col_name))
        self.id_rows = {}
        self._id_rows()

    def print_info(self):
        print("filename %s" % self.thesis_file)
        print("workbook %s" % self.thesis.title)
        print("id column: %s (%d)" % (self.id_col_name,  self.id_col))
        print("splitting on value in column: %s (%d)" % (self.split_col_name,  self.split_col))

    def _col_index_of(self, title):
        for row in self.thesis.iter_rows(min_row=1, max_row=1):
            for cell in  row:
                if (cell.value == title):
                    return cell.col_idx -1;
        return None;

    def _dump_sheet(self):
        for row in self.thesis.iter_rows(min_row=1, max_row=1):
            for cell in  row:
                print("%s" % (cell.value))
            print("---")


    def split_sheet(self):
        splits = {};
        for row in self.thesis.iter_rows(min_row=2):
            col_val = row[self.split_col].value
            if (None != col_val):
                if (col_val in splits):
                    splits[col_val].append(row);
                else:
                    splits[col_val] = [row];
        return splits

    def _id_rows(self):
        if not self.id_rows:
            for row in self.thesis.iter_rows(min_row=2):
                id = row[self.id_col].value
                if (id in self.id_rows):
                    raise "duplicate id %s" % str(id)
                self.id_rows[id] = row

    def print_tsv(self, name, rows):
        print("> Print %s (%d)" % (name, len(rows)));
        file_name = name.replace(' ', '-')
        if not file_name:
            file_name = 'None'
        out =open(file_name + ".tsv", 'w')
        Vireo._print_tsv_row(self._header(), out)
        for r in rows:
            Vireo._print_tsv_row(r, out)
        out.close();
        print("< Print %s" % name);

    def _header(self):
        return next(self.thesis.iter_rows(min_row=1, max_row=1))

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

if __name__ == "__main__":
    main()
