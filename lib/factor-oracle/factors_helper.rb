#!/usr/bin/env ruby

class FactorsHelper 

  def initialize(p, alphabet)
    @p = p
    @alphabet = alphabet
  end

  def factor(w)
    !factor_occurrence(w).empty?
  end

  def factor_occurrence(w)
    return [] if w.length > @p.length
    return Array(0..(@p.length-1)) if w.length == 0

    occurrences = []
    ((w.length-1)..(@p.length-1)).each do |idx|
      occurrences.push(idx) if @p[(idx-w.length+1)..idx] == w
    end
    return occurrences
  end

  def repeated_factor(w)
    factor_occurrence(w).length > 1
  end

  def prefix(w)
    return true if w==""
    return false if w.length > @p.length
    return @p[0..(w.length-1)] == w
  end

  def suffix(w)
    return true if w==""
    return false if w.length > @p.length
    return @p[(-w.length)..-1] == w
  end

  def longest_repeated_suffix(prefix_len)
    prefix = @p[0..(prefix_len-1)]
    f = FactorsHelper.new(prefix, @alphabet)
    suffix=prefix.dup
    while suffix.length > 0
      if f.factor_occurrence(suffix).length > 1
        return suffix
      end
      suffix = suffix[1..-1]
    end
    return suffix
  end

  def last_occurrence_within_prefix(w, prefix_len)
    prefix = @p[0..(prefix_len-1)]
    f = FactorsHelper.new(prefix, @alphabet)
    occurrences = f.factor_occurrence(w)
    return nil if occurrences.length == 0
    return occurrences.last
  end

end
