# FactorOracle

Factor oracles are a data structure / algorithm introduced in the string 
indexing/matching community in 1999.  They have since been applied to lossy data 
compression and (of interest to me) computer-generated music.

See the original 1999 article introducing them: <http://www.lsi.upc.edu/~marias/teaching/bom.pdf>

Read up on them here: <http://en.wikipedia.org/wiki/Factor_oracle>

Check out the online (aka incremental) generation algorithm here: <http://www.lsi.upc.edu/~marias/teaching/bom.pdf>

## Installation

Add this line to your application's Gemfile:

    gem 'factor-oracle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factor-oracle

## Usage (Simple case)

To build the factor oracle:

    f = FactorOracle::FactorOracle.new
    f.add_letter([],                        'a')
    f.add_letter(['a'],                     'b')
    f.add_letter(['a','b'],                 'b')
    f.add_letter(['a','b','b'],             'b')
    f.add_letter(['a','b','b','b'],         'a')
    f.add_letter(['a','b','b','b','a'],     'a')
    f.add_letter(['a','b','b','b','a','a'], 'b')

To then see if strings match:

    is_accepted = f.accepts?(['a','b','b','b'])         # true
    is_accepted = f.accepts?(['a','b','a','a','a','a']) # false

## Usage (More realistic case)

Suppose you had a melody (a set of MIDI pitches) and you wanted to predict the next pitch at each step:

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

That melody is actually one of the Bach 4-part chorales. Because it contains self-similarity, the factor oracle is often able to predict the next pitch with some degree of success:
    
    $ bundle exec ./examples/bach_chorale.rb 
    actual: 67, expected: 
    actual: 67, expected: 
    actual: 69, expected: 67(1)
    actual: 69, expected: 
    actual: 71, expected: 69(1)
    actual: 71, expected: 
    actual: 72, expected: 71(1)
    actual: 74, expected: 
    actual: 74, expected: 
    actual: 72, expected: 74(1)
    actual: 72, expected: 74(1)
    actual: 71, expected: 72(1), 74(1)
    actual: 69, expected: 71(1), 72(1)
    actual: 71, expected: 69(1), 71(1)
    actual: 72, expected: 69(1), 71(1), 72(1), 69(2), 71(2), 72(2)
    actual: 69, expected: 71(1), 72(1), 74(1), 71(2), 72(2), 74(2), 71(3), 72(3), 74(3)
    actual: 67, expected: 69(1), 71(1)
    actual: 67, expected: 67(1), 69(1)
    actual: 67, expected: 67(1), 69(1), 69(2)
    actual: 69, expected: 67(1), 69(1), 67(2), 69(2)
    actual: 69, expected: 67(1), 69(1), 71(1), 67(2), 69(2), 71(2), 67(3), 69(3), 71(3)
    actual: 67, expected: 67(1), 69(1), 71(1), 71(2), 71(3), 71(4)
    actual: 65, expected: 67(1), 69(1), 67(2)
    actual: 64, expected: 
    actual: 67, expected: 
    actual: 67, expected: 67(1), 69(1), 65(1)
    actual: 65, expected: 67(1), 69(1), 65(1), 67(2), 69(2)
    actual: 65, expected: 64(1), 64(2)
    actual: 64, expected: 65(1), 64(1)
    actual: 62, expected: 67(1), 67(2)
    actual: 64, expected: 
    actual: 65, expected: 67(1), 62(1)
    actual: 62, expected: 65(1), 64(1)
    actual: 60, expected: 64(1)
    actual: 72, expected: 
    actual: 72, expected: 69(1), 71(1), 72(1), 74(1)
    actual: 71, expected: 69(1), 71(1), 72(1), 74(1), 71(2)
    actual: 71, expected: 69(1), 71(1), 72(1), 69(2), 69(3)
    actual: 69, expected: 69(1), 71(1), 72(1), 72(2)
    actual: 69, expected: 67(1), 69(1), 71(1), 71(2)
    actual: 67, expected: 67(1), 69(1), 71(1), 67(2), 71(2)
    actual: 67, expected: 67(1), 69(1), 65(1), 67(2), 65(2), 65(3)
    actual: 67, expected: 67(1), 69(1), 65(1), 67(2), 69(2), 65(2), 67(3)
    actual: 65, expected: 67(1), 69(1), 65(1), 67(2), 69(2), 65(2), 69(3), 69(4)
    actual: 64, expected: 65(1), 64(1), 62(1), 65(2), 64(2), 62(2), 65(3)
    actual: 62, expected: 67(1), 65(1), 62(1), 67(2), 65(2), 62(2), 67(3), 65(3), 62(3)
    actual: 62, expected: 64(1), 60(1), 64(2), 60(2), 64(3), 60(3), 64(4), 60(4)
    actual: 60, expected: 64(1), 62(1), 60(1)
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



