#!/usr/bin/env ruby

require 'factor_oracle'

def factors(a)
  fs = []
  (0..(a.length-1)).map do |x| 
    (x..(a.length-1)).map do |y| 
      fs.push a[x..y]  
    end
  end
  fs.sort
end
