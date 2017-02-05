#!/usr/bin/env gawk -f
BEGIN { 
    FPAT="([^,]*)|(\"[^\"]+\")"
}

{ 
    sum += NF
}

END {
    print sum
}
