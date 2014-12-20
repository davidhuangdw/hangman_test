require 'forwardable'

# Game's template_methods: first_current, update_current_after_guess(char)
class Game
  attr_accessor :answer, :current, :tries, :solver
  def initialize(solver,**option)
    @solver = solver
    @tries = 0
    @current = first_current
  end

  def run
    tell_current
    until all_matched?
      update
      tell_current
    end
    tell_tries
  end

  private

  def update
    char = ask_char
    puts "your char: #{char}"
    update_current_after_guess(char)
    @tries += 1
    puts "current: #{current}"
  end

  def all_matched?
    !current.include?('*')
  end

  def tell_current
    @solver.tell_current(current)
  end
  def tell_tries
    @solver.tell_tries(tries)
  end
  def ask_char
    @solver.ask_char
  end
end