#!/usr/bin/env ruby
require 'csv'
field = Integer(ARGV[0]) - 1
filename = ARGV[1]
sum = 0
CSV.foreach(filename) do |row|
    sum += Integer(row[field])
end
p sum
