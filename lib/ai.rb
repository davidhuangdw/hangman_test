require 'set'
require_relative 'word'
class AI
  attr_reader :current, :len, :candidates, :excluded, :guess
  FREQUENT_LETTERS = %w[e t a o i n s h r d l c u m w f g y p b v k j x q z]

  def guess_next_char
    raise "no current" unless current && current.any?
    @guess = most_frequent_char.tap{|c| excluded << c}
  end

  def current=(current)
    raise "different length: #{current}, #{len}" if len && len != current.size
    unless len
      @len = current.size
      @candidates = all_words[@len]
    end
    @current = current
  end

  private
  def excluded
    @excluded ||= Set.new
  end
  def excluded_char?(char)
    excluded.include?(char)
  end

  def filter_candidates
    @candidates = @candidates.select(&method(:candidate?))
  end

  def candidate?(word)
    word.each_char.zip(current).each do |word_char,current_char|
      return false if
          (current_char != '*' && current_char != word_char) ||
          (current_char == '*' && excluded_char?(word_char))
    end
    true
  end

  def most_frequent_char
    filter_candidates

    pair = compute_freqs.max_by(&:last).tap do |pair|
      p current.join, excluded, pair
      p candidates.size, candidates.first(10)
    end
    if pair
      pair.first
    else
      (FREQUENT_LETTERS - excluded.to_a).first
    end
  end

  def compute_freqs
    freqs = Hash.new(0)
    candidates.each do |word|
      word.uniq_chars.each do |char|
        freqs[char] += word.freq unless excluded_char?(char)
      end
    end
    freqs
  end

  def all_words; Word.all_words end
end