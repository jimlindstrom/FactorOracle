#!/usr/bin/env ruby

module FactorOracle
  class FactorOracle < FiniteStateAutomaton
  
    attr_reader :back_link
  
    def initialize
      @alphabet = []
      @states = [0]
      @initial_state = 0
      @transitions = { }
      super(@alphabet, @states, @initial_state, @transitions)
  
      @back_link = {}
    end
  
    def add_letter(prefix, symbol)
      # first make sure that prefix is the set of symbols needed to transition through each state
      reset
      prefix.each do |cur_symbol|
        handle_input(cur_symbol)
      end
      raise Argument.new("can't yet add letters with prefixes that don't match what's been seen so far") if @current_state != @states.last
  
      # now add the transition to the the new letter
      old_state = @states.last
      new_state = old_state + 1
      @states.push new_state
      modify_transitions(old_state, symbol, new_state)
  
      # now the back link and jump-forward links
      k = s_sub_x_of_y(prefix, prefix.length)
      while k>-1 and state_x_has_no_transition_labeled_y(k, symbol)
        modify_transitions(k, symbol, new_state)
        k = s_sub_x_of_y(prefix, k)
      end
      if k == -1
        s = 0
      else
        s = @transitions[k][symbol]
      end
      @back_link[new_state] = s
    end
  
    def accepts?(arr)
      reset
      begin
        arr.each do |letter|
         handle_input(letter)
        end
      rescue
        return false
      end
      return true
    end
  
    def next_letters_for(arr)
      @alphabet.select{ |letter| accepts?(arr + [letter]) }
    end
  
  private
  
    def s_sub_x_of_y(x, y)
      return -1 if y==0
      @back_link[y]
    end
  
    def state_x_has_no_transition_labeled_y(x, y)
      !@transitions[x].keys.include?(y)
    end
  end
end

