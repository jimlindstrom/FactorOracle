#!/usr/bin/env ruby

class FiniteStateAutomaton

  attr_reader :alphabet, :states, :initial_state, :transitions, :current_state

  def initialize(alphabet, states, initial_state, transitions)
    @alphabet      = alphabet.dup
    @states        = states.dup
    @initial_state = initial_state
    @transitions   = transitions.dup

    reset
  end

  def reset
    @current_state = @initial_state
  end

  def modify_transitions(old_state, symbol, new_state)
    @states.push old_state if !@states.include?(old_state)
    @states.push new_state if !@states.include?(new_state)
    @alphabet.push symbol if !@alphabet.include?(symbol)

    @transitions[old_state] = {} if !@transitions.keys.include?(old_state)
    @transitions[old_state][symbol] = new_state
  end

  def handle_input(symbol)
    raise ArgumentError.new("current state (#{@current_state}) not among those with outgoing transitions (#{@transitions.keys})") if !@transitions.keys.include?(@current_state)
    cur_transitions = @transitions[@current_state]
    raise ArgumentError.new("symbol (#{symbol}) not among valid symbols in state (#{cur_transitions.keys})") if !cur_transitions.keys.include?(symbol)
    @current_state = cur_transitions[symbol]
  end

end
