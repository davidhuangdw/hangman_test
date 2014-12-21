# get results
require_relative '../lib/word'

class Word
  def self.parse_raw(line)
    columns = to_columns(line)
    word,freq = [columns[0], columns[-3]]
    word = columns[2] if word == '@'
    raise "not all digits: #{freq}" unless freq =~ /\A\d+\z/
    new(word.downcase,freq.to_i)
  end
end


raw_file = 'word_freq.txt'
trim_file = 'trimed.txt'
@result = Hash.new(0)

def parse(line)
  Word.parse_raw(line)
end

def save(word)
  @result[word.word] += word.freq
end


File.foreach(raw_file) do |line|
  word = parse(line)
  save(word) if word.valid?
end

File.open(trim_file, 'w') do |f|
  @result.each do |word, count|
    f.puts "#{word}\t#{count.to_i}"
  end
end
