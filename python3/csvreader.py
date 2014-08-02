#!/usr/bin/env python3
'''
Read CSV file and print the number of fields.
'''
import csv
import sys

print(sum(map(len, csv.reader(sys.stdin))))
