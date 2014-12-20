require 'delegate'
class Word < SimpleDelegator
  attr_reader :word, :freq
  def initialize(word,freq)
    @word = word
    @freq = freq
    @size = word.size
    super(word)
  end

  def uniq_chars
    @uniq_chars ||=
        each_char.sort.join.squeeze.each_char
  end

  def valid?
    word =~ /\A[a-zA-Z]+\z/
  end

  def to_s
    "#{word} : #{freq}"
  end
end


class << Word
  def all_words
    @all_words ||= collect_all_words
  end
  def parse(line)
    word,count = to_columns(line)
    new(word, [count.to_f, 0.2].max)
  end
  private
  def to_columns(line)
    line.strip.split(/\s+/)
  end

  def collect_all_words
    puts 'collecting all_words'
    @all_words = Hash.new{|h,k| h[k] = []}
    File.foreach('dict/trimed.txt') do |line|
      word = parse(line)
      @all_words[word.size] << word
    end
    puts 'finish'+'-'*50
    @all_words
  end
end
