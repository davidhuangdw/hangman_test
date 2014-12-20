require_relative 'game'
class TerminalGame < Game
  private

  def update_current_after_guess(char)
    answer.each_with_index do |c,i|
      current[i] = c if c == char && c!='*'
    end
  end

  def first_current
    @answer = ask_answer
    @current = answer.map{'*'}
  end

  def ask_answer
    puts 'Word to guess:'
    gets.split(/\s+/).first.downcase.each_char.to_a
  end
end
