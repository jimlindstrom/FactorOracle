# finite_state_automaton_spec.rb

describe FiniteStateAutomaton do

  before (:each) do
    @alphabet = ["0", "1"]
    @states = [1, 2]
    @initial_state = 1
    @transitions = { 1 => { "0" => 2, "1" => 1 }, 2 => { "0" => 1, "1" => 2 } }
    @fsa = FiniteStateAutomaton.new(@alphabet, @states, @initial_state, @transitions)
  end

  describe ".new" do
    it "returns a new FiniteStateAutomaton" do
      FiniteStateAutomaton.new(@alphabet, @states, @initial_state, @transitions).should be_an_instance_of FiniteStateAutomaton
    end
    it "puts the FSA in its initial state" do
      @fsa.current_state.should == @initial_state
    end
  end

  describe ".reset" do
    it "sets the FSA to its initial state" do
      @fsa.reset
      @fsa.current_state.should == @initial_state
    end
  end

  describe ".initial_state" do
    it "returns the given initial state" do
      @fsa.initial_state.should == @initial_state
    end
  end

  describe ".transitions" do
    it "returns the given transitions" do
      @fsa.transitions.should == @transitions
    end
    it "returns the given transitions, plus any added through modify_transitions" do
      #pending
    end
  end

  describe ".current_state" do
    it "returns the initial state of the FSA, after reset" do
      @fsa.reset
      @fsa.current_state.should == @initial_state
    end
    it "returns the current state, after receiving and input and transitioning to a new state" do
      @fsa.handle_input("0")
      @fsa.current_state.should == 2
    end
  end

  describe ".modify_transitions" do
    it "modifies an existing transition" do
      old_state = 1
      symbol    = "0"
      new_state = 1
      @fsa.modify_transitions(old_state, symbol, new_state)
      @fsa.reset
      @fsa.handle_input(symbol)
      @fsa.current_state.should == new_state
    end
    it "allows new symbols" do
      old_state = 1
      symbol    = "3"
      new_state = 1
      @fsa.modify_transitions(old_state, symbol, new_state)
      @fsa.reset
      @fsa.handle_input(symbol)
      @fsa.current_state.should == new_state
    end
    it "allows new states" do
      old_state = 1
      symbol    = "0"
      new_state = 3
      @fsa.modify_transitions(old_state, symbol, new_state)
      @fsa.reset
      @fsa.handle_input(symbol)
      @fsa.current_state.should == new_state
    end
  end

  describe ".handle_input" do
    it "follows the given transition function" do
      @fsa.handle_input("0")
      @fsa.current_state.should == 2
    end
    it "follows the given transition function" do
      @fsa.handle_input("0")
      @fsa.handle_input("0")
      @fsa.current_state.should == 1
    end
    it "follows the given transition function" do
      @fsa.handle_input("0")
      @fsa.handle_input("0")
      @fsa.handle_input("1")
      @fsa.current_state.should == 1
    end
  end

  describe ".alphabet" do
    it "returns the given alphabet if no symbols have been added" do
      @fsa.alphabet.should == @alphabet
    end
    it "returns the given alphabet plus any symbols added through 'modify_transitions'" do
      old_state = 1
      symbol    = "3"
      new_state = 1
      @fsa.modify_transitions(old_state, symbol, new_state)
      @fsa.alphabet.should == (@alphabet + [symbol])
    end
  end

  describe ".states" do
    it "returns the given states if no states have been added" do
      @fsa.states.should == @states
    end
    it "returns the given states plus any states added through 'modify_transitions'" do
      old_state = 1
      symbol    = "0"
      new_state = 4
      @fsa.modify_transitions(old_state, symbol, new_state)
      @fsa.states.should == (@states + [new_state])
    end
  end

end
