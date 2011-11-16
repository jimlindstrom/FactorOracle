# factor_oracle_spec.rb

require 'spec_helper'

describe FactorOracle do

  describe ".new" do
    it "should return a new FactorOracle" do
      FactorOracle.new.should be_an_instance_of FactorOracle
    end
    it "should return a subclass of FiniteStateAutomaton" do
      FactorOracle.new.should be_a_kind_of FiniteStateAutomaton
    end
    it "should have one state: 0" do 
      f = FactorOracle.new
      f.states.should == [0]
    end
    it "should have an initial state of 0" do 
      f = FactorOracle.new
      f.initial_state.should == 0
    end
    it "should have an empty alphabet" do
      f = FactorOracle.new
      f.alphabet.should == []
    end
  end

  describe ".add_letter" do
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.states.should == [0, 1]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.transitions[0]['a'].should == 1
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.alphabet.should == ['a']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.back_link[1].should == 0
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.add_letter('a','b')
      f.states.should == [0, 1, 2]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.add_letter('a','b')
      f.transitions[1]['b'].should == 2
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.add_letter('a','b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.add_letter('a','b')
      f.back_link[2].should == 0
    end
    it "should add jump forward links" do
      f = FactorOracle.new
      f.add_letter('', 'a')
      f.add_letter('a','b')
      f.transitions[0]['b'].should == 2
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('',  'a')
      f.add_letter('a', 'b')
      f.add_letter('ab','b')
      f.states.should == [0, 1, 2, 3]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('',  'a')
      f.add_letter('a', 'b')
      f.add_letter('ab','b')
      f.transitions[2]['b'].should == 3
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('',  'a')
      f.add_letter('a', 'b')
      f.add_letter('ab','b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('',  'a')
      f.add_letter('a', 'b')
      f.add_letter('ab','b')
      f.back_link[3].should == 2
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('',    'a')
      f.add_letter('a',   'b')
      f.add_letter('ab',  'b')
      f.add_letter('abb', 'b')
      f.states.should == [0, 1, 2, 3, 4]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('',    'a')
      f.add_letter('a',   'b')
      f.add_letter('ab',  'b')
      f.add_letter('abb', 'b')
      f.transitions[3]['b'].should == 4
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('',    'a')
      f.add_letter('a',   'b')
      f.add_letter('ab',  'b')
      f.add_letter('abb', 'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('',    'a')
      f.add_letter('a',   'b')
      f.add_letter('ab',  'b')
      f.add_letter('abb', 'b')
      f.back_link[4].should == 3
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('',      'a')
      f.add_letter('a',     'b')
      f.add_letter('ab',    'b')
      f.add_letter('abb',   'b')
      f.add_letter('abbb',  'a')
      f.add_letter('abbba', 'a')
      f.states.should == [0, 1, 2, 3, 4, 5, 6]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('',      'a')
      f.add_letter('a',     'b')
      f.add_letter('ab',    'b')
      f.add_letter('abb',   'b')
      f.add_letter('abbb',  'a')
      f.add_letter('abbba', 'a')
      f.transitions[5]['a'].should == 6
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('',      'a')
      f.add_letter('a',     'b')
      f.add_letter('ab',    'b')
      f.add_letter('abb',   'b')
      f.add_letter('abbb',  'a')
      f.add_letter('abbba', 'a')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('',      'a')
      f.add_letter('a',     'b')
      f.add_letter('ab',    'b')
      f.add_letter('abb',   'b')
      f.add_letter('abbb',  'a')
      f.add_letter('abbba', 'a')
      f.back_link[6].should == 1
    end
    it "should add jump forward links" do
      f = FactorOracle.new
      f.add_letter('',      'a')
      f.add_letter('a',     'b')
      f.add_letter('ab',    'b')
      f.add_letter('abb',   'b')
      f.add_letter('abbb',  'a')
      f.add_letter('abbba', 'a')
      f.transitions[1]['a'].should == 6
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle.new
      f.add_letter('',       'a')
      f.add_letter('a',      'b')
      f.add_letter('ab',     'b')
      f.add_letter('abb',    'b')
      f.add_letter('abbb',   'a')
      f.add_letter('abbba',  'a')
      f.add_letter('abbbaa', 'b')
      f.states.should == [0, 1, 2, 3, 4, 5, 6, 7]
    end
    it "should add transition to the new state" do
      f = FactorOracle.new
      f.add_letter('',       'a')
      f.add_letter('a',      'b')
      f.add_letter('ab',     'b')
      f.add_letter('abb',    'b')
      f.add_letter('abbb',   'a')
      f.add_letter('abbba',  'a')
      f.add_letter('abbbaa', 'b')
      f.transitions[6]['b'].should == 7
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle.new
      f.add_letter('',       'a')
      f.add_letter('a',      'b')
      f.add_letter('ab',     'b')
      f.add_letter('abb',    'b')
      f.add_letter('abbb',   'a')
      f.add_letter('abbba',  'a')
      f.add_letter('abbbaa', 'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle.new
      f.add_letter('',       'a')
      f.add_letter('a',      'b')
      f.add_letter('ab',     'b')
      f.add_letter('abb',    'b')
      f.add_letter('abbb',   'a')
      f.add_letter('abbba',  'a')
      f.add_letter('abbbaa', 'b')
      f.back_link[7].should == 2
    end
    ############################################################################
  end

  describe ".accepts?" do
    before(:each) do
      @f = FactorOracle.new
      @f.add_letter('',       'a')
      @f.add_letter('a',      'b')
      @f.add_letter('ab',     'b')
      @f.add_letter('abb',    'b')
      @f.add_letter('abbb',   'a')
      @f.add_letter('abbba',  'a')
      @f.add_letter('abbbaa', 'b')
    end

    it "should return true if the given string was a factor of the original " do
      def factors(a) ; (0..(a.length-1)).map {|x| (x..(a.length-1)).map {|y| a[x..y] } }.flatten.sort ; end

      fs = factors('abbbaab')
      fs.each do |factor|
        @f.accepts?(factor).should == true
      end
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = "aaba"
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = "ababa"
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = "baaa"
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = "aaaaaaa"
      @f.accepts?(non_factor).should == false
    end

  end

end
