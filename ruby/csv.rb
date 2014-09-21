#!/usr/bin/env ruby
require 'csv'
sum = 0
CSV.foreach('/dev/stdin') do |row|
    sum += row.length
end
p sum
