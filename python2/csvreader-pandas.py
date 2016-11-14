#!/usr/bin/env python
'''Read CSV file into pandas dataframe and print the number of fields'''

import pandas as p
import sys

try:
    df = p.read_csv(sys.stdin, header=None)
    print df.shape[0] * df.shape[1]
except p.io.common.EmptyDataError as e:
    print 0
