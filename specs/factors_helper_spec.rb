# factors_helper_spec.rb

require 'spec_helper'

describe FactorsHelper do

  before (:all) do
    @p = "abbaabbaabbababb"
    @alphabet = ["a", "b"]
    @f = FactorsHelper.new(@p, @alphabet)

    @known_factor = "aabba"
    @known_nonfactor = "bbb"

    @known_repeated_factor = "aabba"
    @known_nonrepeated_factor = "baabbaabbaba"

    @known_prefix = "abbaa"
    @known_nonprefix = "bbaa"

    @known_suffix = "ababb"
    @known_nonsuffix = "abab"


    @p2 = "abbbaab"
    @alphabet = ["a", "b"]
    @f2 = FactorsHelper.new(@p2, @alphabet)
  end

  describe ".new" do
    it "returns a new FactorsHelper" do
      FactorsHelper.new(@p, @alphabet).should be_an_instance_of FactorsHelper
    end
  end

  describe ".factor" do
    it "returns true if the given string is a factor (substring) of 'p'" do
      @f.factor(@known_factor).should be_true
    end
    it "returns false if the given string is not a factor (substring) of 'p'" do
      @f.factor(@known_nonfactor).should be_false
    end
    it "returns true if the given string is the entire 'p'" do
      @f.factor(@p).should be_true
    end
    it "returns true if the given string is the empty string" do
      @f.factor("").should be_true
    end
  end

  describe ".factor_occurrence" do
    it "returns the empty set if the given string is not a factor" do
      @f.factor_occurrence(@known_nonfactor).empty?.should be_true
    end
    it "returns the index of the last character of all occurrences of the given factor" do
      @f.factor_occurrence(@known_factor).should == [7, 11]
    end
    it "returns [p.length-1] if the given string is the entire 'p'" do
      @f.factor_occurrence(@p).should == [@p.length-1]
    end
    it "returns [0..(p.length-1)] if the given string is the empty string" do
      @f.factor_occurrence("").should == Array(0..(@p.length-1))
    end
  end

  describe ".repeated_factor" do
    it "returns true when given a factor with two or more occurrences" do
      @f.repeated_factor(@known_repeated_factor).should be_true
    end
    it "returns false when given a factor with only one occurrence" do
      @f.repeated_factor(@known_nonrepeated_factor).should be_false
    end
    it "returns false when given a nonfactor" do
      @f.repeated_factor(@known_nonfactor).should be_false
    end
  end

  describe ".prefix" do
    it "returns true if the given string is a prefix (initial substring) of 'p'" do
      @f.prefix(@known_prefix).should be_true
    end
    it "returns false if the given string is not a prefix (initial substring) of 'p'" do
      @f.prefix(@known_nonprefix).should be_false
    end
    it "returns true if the given string is the entire 'p'" do
      @f.prefix(@p).should be_true
    end
    it "returns true if the given string is the empty string" do
      @f.prefix("").should be_true
    end
  end

  describe ".suffix" do
    it "returns true if the given string is a suffix (final substring) of 'p'" do
      @f.suffix(@known_suffix).should be_true
    end
    it "returns false if the given string is not a suffix (final substring) of 'p'" do
      @f.suffix(@known_nonsuffix).should be_false
    end
    it "returns true if the given string is the entire 'p'" do
      @f.suffix(@p).should be_true
    end
    it "returns true if the given string is the empty string" do
      @f.suffix("").should be_true
    end
  end

  describe ".longest_repeated_suffix" do
    it "returns the empty string if no suffix is repeated" do
      # @p = "abbaabbaabbababb"
      #        $
      @f.longest_repeated_suffix(2).should == ""
    end
    it "returns the longest repeated suffix of p's prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #         $
      @f.longest_repeated_suffix(3).should == "b"
    end
    it "returns the longest repeated suffix of p's prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #             $
      @f.longest_repeated_suffix(7).should == "abb"
    end
  end

  describe ".last_occurrence_within_prefix" do
    it "returns nil if the given string does not occur in the prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #            $
      @f.last_occurrence_within_prefix("bbb", 6).should be_nil
    end
    it "returns the last occurrence of a given string within the prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #            $
      @f.last_occurrence_within_prefix("ab", 6).should == 5
    end
    it "returns the last occurrence of a given string within the prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #            $
      @f.last_occurrence_within_prefix("aa", 6).should == 4
    end
    it "returns the last occurrence of a given string within the prefix of the given length" do
      # @p = "abbaabbaabbababb"
      #            $
      @f.last_occurrence_within_prefix("ba", 6).should == 3
    end
  end

end
