#!/usr/bin/env python
'''Read CSV file and print the number of fields'''

import csv
import sys

print sum(map(len, csv.reader(sys.stdin)))
