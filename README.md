### Problem: hangman

1. the game tells you a word fully masked by `'*'` (e.g. `'happy' -> '*****'`)
2. each round,
    1. you provide a guessed char (e.g. `'p'`)
    2. the game responds with a new word, which
      * unmask `'*'` if it matches (e.g. `'**pp*'`)
3. keeps going until all of the word are unmasked

### Algorithm

```ruby
# pseudo_code:
def init
  read_and_save(frequency_dictionary)
end

def each_run
  current = first_response
  candidates = dict[current.length]
  until current.all_matched?
    guess = most_frequent_char
    current = ask_response_by(guess)
    excluded_chars << guess
    filter_candidates
  end
end

def filter_candidates
  candidate.reject do |word|
    # '*' && in excluded_chars
    # (not '*') && word_char != current_char
  end
end

def most_frequent_char
  freqs = Hash.new(0)
  candidates_after_filter.each do |word|
    word.each_uniq_and_not_excluded_char do |char|
      freqs[char] += word.freq
    end
  end
  freq.char_with_max_value
end

```

### Run

`ruby main.rb`

