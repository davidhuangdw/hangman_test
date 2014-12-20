require_relative 'solver'
require_relative '../ai'

class AISolver < Solver
  def ask_char
    ai.guess_next_char
  end
  def tell_current(current)
    ai.current=current
  end
  private
  def ai
    @ai ||= AI.new
  end
end