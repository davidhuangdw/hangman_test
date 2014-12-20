require_relative 'solver'
class HumanSolver < Solver
  def ask_char
    puts 'Your guess:'
    gets.downcase.each_char.first
  end
  def tell_current(current)
    puts current.join
  end
end