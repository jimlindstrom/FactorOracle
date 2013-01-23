# factor_oracle_spec.rb

require 'spec_helper'

describe FactorOracle::FactorOracle do

  describe ".new" do
    it "should return a new FactorOracle" do
      FactorOracle::FactorOracle.new.should be_an_instance_of FactorOracle::FactorOracle
    end
    it "should return a subclass of FiniteStateAutomaton" do
      FactorOracle::FactorOracle.new.should be_a_kind_of FactorOracle::FiniteStateAutomaton
    end
    it "should have one state: 0" do 
      f = FactorOracle::FactorOracle.new
      f.states.should == [0]
    end
    it "should have an initial state of 0" do 
      f = FactorOracle::FactorOracle.new
      f.initial_state.should == 0
    end
    it "should have an empty alphabet" do
      f = FactorOracle::FactorOracle.new
      f.alphabet.should == []
    end
  end

  describe ".add_letter" do
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.states.should == [0, 1]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.transitions[0]['a'].should == 1
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.alphabet.should == ['a']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.back_link[1].should == 0
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.add_letter(['a'],'b')
      f.states.should == [0, 1, 2]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.add_letter(['a'],'b')
      f.transitions[1]['b'].should == 2
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.add_letter(['a'],'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.add_letter(['a'],'b')
      f.back_link[2].should == 0
    end
    it "should add jump forward links" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([], 'a')
      f.add_letter(['a'],'b')
      f.transitions[0]['b'].should == 2
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],  'a')
      f.add_letter(['a'], 'b')
      f.add_letter(['a','b'],'b')
      f.states.should == [0, 1, 2, 3]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],  'a')
      f.add_letter(['a'], 'b')
      f.add_letter(['a','b'],'b')
      f.transitions[2]['b'].should == 3
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],  'a')
      f.add_letter(['a'], 'b')
      f.add_letter(['a','b'],'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],  'a')
      f.add_letter(['a'], 'b')
      f.add_letter(['a','b'],'b')
      f.back_link[3].should == 2
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],    'a')
      f.add_letter(['a'],   'b')
      f.add_letter(['a','b'],  'b')
      f.add_letter(['a','b','b'], 'b')
      f.states.should == [0, 1, 2, 3, 4]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],    'a')
      f.add_letter(['a'],   'b')
      f.add_letter(['a','b'],  'b')
      f.add_letter(['a','b','b'], 'b')
      f.transitions[3]['b'].should == 4
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],    'a')
      f.add_letter(['a'],   'b')
      f.add_letter(['a','b'],  'b')
      f.add_letter(['a','b','b'], 'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],    'a')
      f.add_letter(['a'],   'b')
      f.add_letter(['a','b'],  'b')
      f.add_letter(['a','b','b'], 'b')
      f.back_link[4].should == 3
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],      'a')
      f.add_letter(['a'],     'b')
      f.add_letter(['a','b'],    'b')
      f.add_letter(['a','b','b'],   'b')
      f.add_letter(['a','b','b','b'],  'a')
      f.add_letter(['a','b','b','b','a'], 'a')
      f.states.should == [0, 1, 2, 3, 4, 5, 6]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],      'a')
      f.add_letter(['a'],     'b')
      f.add_letter(['a','b'],    'b')
      f.add_letter(['a','b','b'],   'b')
      f.add_letter(['a','b','b','b'],  'a')
      f.add_letter(['a','b','b','b','a'], 'a')
      f.transitions[5]['a'].should == 6
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],      'a')
      f.add_letter(['a'],     'b')
      f.add_letter(['a','b'],    'b')
      f.add_letter(['a','b','b'],   'b')
      f.add_letter(['a','b','b','b'],  'a')
      f.add_letter(['a','b','b','b','a'], 'a')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],      'a')
      f.add_letter(['a'],     'b')
      f.add_letter(['a','b'],    'b')
      f.add_letter(['a','b','b'],   'b')
      f.add_letter(['a','b','b','b'],  'a')
      f.add_letter(['a','b','b','b','a'], 'a')
      f.back_link[6].should == 1
    end
    it "should add jump forward links" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],      'a')
      f.add_letter(['a'],     'b')
      f.add_letter(['a','b'],    'b')
      f.add_letter(['a','b','b'],   'b')
      f.add_letter(['a','b','b','b'],  'a')
      f.add_letter(['a','b','b','b','a'], 'a')
      f.transitions[1]['a'].should == 6
    end
    ############################################################################
    it "should add a new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],       'a')
      f.add_letter(['a'],      'b')
      f.add_letter(['a','b'],     'b')
      f.add_letter(['a','b','b'],    'b')
      f.add_letter(['a','b','b','b'],   'a')
      f.add_letter(['a','b','b','b','a'],  'a')
      f.add_letter(['a','b','b','b','a','a'], 'b')
      f.states.should == [0, 1, 2, 3, 4, 5, 6, 7]
    end
    it "should add transition to the new state" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],       'a')
      f.add_letter(['a'],      'b')
      f.add_letter(['a','b'],     'b')
      f.add_letter(['a','b','b'],    'b')
      f.add_letter(['a','b','b','b'],   'a')
      f.add_letter(['a','b','b','b','a'],  'a')
      f.add_letter(['a','b','b','b','a','a'], 'b')
      f.transitions[6]['b'].should == 7
    end
    it "should add a new symbol when the symbol isn't in the alphabet" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],       'a')
      f.add_letter(['a'],      'b')
      f.add_letter(['a','b'],     'b')
      f.add_letter(['a','b','b'],    'b')
      f.add_letter(['a','b','b','b'],   'a')
      f.add_letter(['a','b','b','b','a'],  'a')
      f.add_letter(['a','b','b','b','a','a'], 'b')
      f.alphabet.should == ['a', 'b']
    end
    it "should add back link" do
      f = FactorOracle::FactorOracle.new
      f.add_letter([],       'a')
      f.add_letter(['a'],      'b')
      f.add_letter(['a','b'],     'b')
      f.add_letter(['a','b','b'],    'b')
      f.add_letter(['a','b','b','b'],   'a')
      f.add_letter(['a','b','b','b','a'],  'a')
      f.add_letter(['a','b','b','b','a','a'], 'b')
      f.back_link[7].should == 2
    end
    ############################################################################
  end

  describe ".accepts?" do
    before(:each) do
      @f = FactorOracle::FactorOracle.new
      @f.add_letter([],       'a')
      @f.add_letter(['a'],      'b')
      @f.add_letter(['a','b'],     'b')
      @f.add_letter(['a','b','b'],    'b')
      @f.add_letter(['a','b','b','b'],   'a')
      @f.add_letter(['a','b','b','b','a'],  'a')
      @f.add_letter(['a','b','b','b','a','a'], 'b')
    end

    it "should return true if the given string was a factor of the original " do
      def factors(arr) 
        factor_arr = []
        1.upto(arr.length) do |len1|
          arr2 = arr.first(len1)
          1.upto(arr2.length) do |len2|
            factor_arr << arr2.last(len2)
          end
        end
        factor_arr.sort.uniq
      end

      fs = factors(['a','b','b','b','a','a','b'])
      fs.each do |factor|
        raise RuntimeError.new("didn't recognize #{factor}") if !@f.accepts?(factor)
        @f.accepts?(factor).should == true
      end
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = ["a","a","b","a"]
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = ["a","b","a","b","a"]
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = ["b","a","a","a"]
      @f.accepts?(non_factor).should == false
    end
    it "should return true if the given string was a factor of the original " do
      non_factor = ["a","a","a","a","a","a","a"]
      @f.accepts?(non_factor).should == false
    end
  end

  describe ".next_letters_for" do
    before(:each) do
      @f = FactorOracle::FactorOracle.new
      @f.add_letter([],       'a')
      @f.add_letter(['a'],      'b')
      @f.add_letter(['a','b'],     'b')
      @f.add_letter(['a','b','b'],    'b')
      @f.add_letter(['a','b','b','b'],   'a')
      @f.add_letter(['a','b','b','b','a'],  'a')
      @f.add_letter(['a','b','b','b','a','a'], 'b')
    end

    context "given a prefix that isn't accepted" do
      let(:prefix) { ["b","a","a","a"] }
      subject { @f.next_letters_for(prefix) }
      it { should be_an Array }
      it { should == [] }
    end

    context "given a prefix that is accepted" do
      let(:prefix) { ["b","b"] }
      subject { @f.next_letters_for(prefix) }
      it { should be_an Array }
      it { should == ['a', 'b'] }
    end
  end

end
