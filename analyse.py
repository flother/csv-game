#!/usr/bin/env python

from __future__ import print_function
import pandas as p

d = p.read_csv('results.csv', header=0, names=['lang','lib','task','time'])
fieldcount = d[d.task == 'fieldcount']
empty = d[d.task == 'empty']

best_fc = fieldcount.groupby(['lang', 'lib']).min()
best_empty = empty.groupby(['lang', 'lib']).min()
best_fc['time-minus-empty'] = (best_fc.loc[:,:].time - best_empty.loc[:,:].time)
print(best_fc.sort('time-minus-empty'))
