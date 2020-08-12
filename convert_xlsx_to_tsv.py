'''
Author: davids@rome2rio.com
Purpose: To convert .xslx documents to .tsv documents.

'''

import sys
import pandas as pd

if __name__ == "__main__":
    for filename in sys.argv[1:]:

        # Read excel file into a dataframe
        df = data_xlsx = pd.read_excel(filename, index_col=None)

        # Replace all columns having spaces with underscores
        # data_xlsx.columns = [c.replace(' ', '_') for c in data_xlsx.columns]

        # Replace all fields having line breaks with space
        # df = data_xlsx.replace('\n', ' ',regex=True)

        # Write dataframe into csv
        df.to_csv(f"{filename[:-5]}.tsv", sep='\t', encoding='utf-8',  index=False, line_terminator='\r\n')
