#!/usr/bin/env ruby

require 'factor-oracle'

midi_pitches = [67, 67, 69, 69, 71, 71, 72, 74, 74, 72, 72, 71, 69, 71, 72, 69, 67, 
                67, 67, 69, 69, 67, 65, 64, 67, 67, 65, 65, 64, 62, 64, 65, 62, 60, 
                72, 72, 71, 71, 69, 69, 67, 67, 67, 65, 64, 62, 62, 60]

f = FactorOracle::FactorOracle.new

1.upto(midi_pitches.length) do |x|
  prefix = midi_pitches.first(x-1)
  next_char = midi_pitches[x-1]

  expected = []
  1.upto(prefix.length) do |prefix_len|
    cur_expected = f.next_letters_for(prefix.last(prefix_len))
    expected += cur_expected.map{ |expected_letter| expected_letter.to_s+"(#{prefix_len})" }
  end
  puts "actual: #{next_char}, expected: " + expected.join(', ')

  f.add_letter(prefix, next_char)
end

