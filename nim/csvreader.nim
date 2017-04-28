import os
import parsecsv
import streams


var
  fields = 0
  csv: CsvParser
let
  stream = newFileStream(paramStr(1), fmRead)

csv.open(stream, paramStr(1))
while csv.readRow():
  fields += csv.row.len()
csv.close()
echo(fields)
