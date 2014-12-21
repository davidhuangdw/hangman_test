require_relative 'game'
require_relative 'api_connection'
class ApiGame < Game

  def initialize(*args)
    conn.start_game
    super
  end

  private
  def update_current_after_guess(char)
    @fail = false
    word = conn.guess_word(char.upcase)
    if word =~ /\A[\w*]+\z/
      @current = to_current(word)
    else
      @fail = true
    end
  end
  def first_current
    to_current conn.next_word
  end

  def after_run
    puts "Score: #{conn.get_result}"
  end

  def to_current(word)
    word.downcase.each_char.to_a
  end

  def conn
    @conn ||= ApiConnection.new
  end
end