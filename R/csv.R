#!/usr/bin/env Rscript
csv <- tryCatch(read.csv('/dev/stdin', header=FALSE), error=function(e) data.frame())
print(nrow(csv) * ncol(csv))
