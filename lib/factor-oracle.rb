files = ['version',
         'factors_helper',
         'finite_state_automaton',
         'factor_oracle']

files.each do |file|
  require File.join('factor-oracle', file)
end

