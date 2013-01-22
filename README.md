# Factor::Oracle

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

## Usage

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



