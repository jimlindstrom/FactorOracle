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

    f = FactorOracle.new
    f.add_letter('',       'a')
    f.add_letter('a',      'b')
    f.add_letter('ab',     'b')
    f.add_letter('abb',    'b')
    f.add_letter('abbb',   'a')
    f.add_letter('abbba',  'a')
    f.add_letter('abbbaa', 'b')

To then see if strings match:

    is_accepted = f.accepts?('abbb')   # true
    is_accepted = f.accepts?('abaaaa') # false

## Usage (More realistic case)

Suppose you had a melody (a set of MIDI pitches) and you wanted to predict the next pitch at each step:

    require 'factor-oracle'
    
    midi_pitches = [67, 67, 69, 69, 71, 71, 72, 74, 74, 72, 72, 71, 69, 71, 72, 69, 67,
                    67, 67, 69, 69, 67, 65, 64, 67, 67, 65, 65, 64, 62, 64, 65, 62, 60,
                    72, 72, 71, 71, 69, 69, 67, 67, 67, 65, 64, 62, 62, 60]
    midi_pitches_as_letters = midi_pitches.map{ |x| (x+38).chr }
    
    f = FactorOracle.new
    
    1.upto(midi_pitches_as_letters.length) do |x|
      prefix = midi_pitches_as_letters.first(x-1).join
      next_char = midi_pitches_as_letters[x-1]
    
      expected = []
      1.upto(prefix.length) do |prefix_len|
        cur_expected = f.next_letters_for(prefix.split(//).last(prefix_len).join())
        expected += cur_expected.map{ |expected_letter| expected_letter+"(#{prefix_len})" }
      end
      puts "actual: #{next_char}, expected: " + expected.join(', ')
    
      f.add_letter(prefix, next_char)
    end

That melody is actually one of the Bach 4-part chorales. Because it contains self-similarity, the factor oracle is often able to predict the next pitch with some degree of success:

    $ bundle exec examples/bach_chorale.rb 
    actual: i, expected: 
    actual: i, expected: 
    actual: k, expected: i(1)
    actual: k, expected: 
    actual: m, expected: k(1)
    actual: m, expected: 
    actual: n, expected: m(1)
    actual: p, expected: 
    actual: p, expected: 
    actual: n, expected: p(1)
    actual: n, expected: p(1)
    actual: m, expected: n(1), p(1)
    actual: k, expected: m(1), n(1)
    actual: m, expected: k(1), m(1)
    actual: n, expected: k(1), m(1), n(1), k(2), m(2), n(2)
    actual: k, expected: m(1), n(1), p(1), m(2), n(2), p(2), m(3), n(3), p(3)
    actual: i, expected: k(1), m(1)
    actual: i, expected: i(1), k(1)
    actual: i, expected: i(1), k(1), k(2)
    actual: k, expected: i(1), k(1), i(2), k(2)
    actual: k, expected: i(1), k(1), m(1), i(2), k(2), m(2), i(3), k(3), m(3)
    actual: i, expected: i(1), k(1), m(1), m(2), m(3), m(4)
    actual: g, expected: i(1), k(1), i(2)
    actual: f, expected: 
    actual: i, expected: 
    actual: i, expected: i(1), k(1), g(1)
    actual: g, expected: i(1), k(1), g(1), i(2), k(2)
    actual: g, expected: f(1), f(2)
    actual: f, expected: g(1), f(1)
    actual: d, expected: i(1), i(2)
    actual: f, expected: 
    actual: g, expected: i(1), d(1)
    actual: d, expected: g(1), f(1)
    actual: b, expected: f(1)
    actual: n, expected: 
    actual: n, expected: k(1), m(1), n(1), p(1)
    actual: m, expected: k(1), m(1), n(1), p(1), m(2)
    actual: m, expected: k(1), m(1), n(1), k(2), k(3)
    actual: k, expected: k(1), m(1), n(1), n(2)
    actual: k, expected: i(1), k(1), m(1), m(2)
    actual: i, expected: i(1), k(1), m(1), i(2), m(2)
    actual: i, expected: i(1), k(1), g(1), i(2), g(2), g(3)
    actual: i, expected: i(1), k(1), g(1), i(2), k(2), g(2), i(3)
    actual: g, expected: i(1), k(1), g(1), i(2), k(2), g(2), k(3), k(4)
    actual: f, expected: g(1), f(1), d(1), g(2), f(2), d(2), g(3)
    actual: d, expected: i(1), g(1), d(1), i(2), g(2), d(2), i(3), g(3), d(3)
    actual: d, expected: f(1), b(1), f(2), b(2), f(3), b(3), f(4), b(4)
    actual: b, expected: f(1), d(1), b(1)
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



