require 'forwardable'

# Game's template_methods: first_current, update_current_after_guess(char)
class Game
  attr_accessor :answer, :current, :tries, :solver
  def initialize(solver_klass,**option)
    @solver_klass = solver_klass
  end

  def run
    reset
    tell_current
    until all_matched?
      update
      break if fail?
      tell_current
    end
    tell_tries
    after_run
  end

  private

  def reset
    @tries = 0
    @current = first_current
    @solver = @solver_klass.new
  end

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
  def fail?; @fail end
  def after_run; end
end