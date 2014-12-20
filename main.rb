require_relative 'lib/game/terminal_game'
require_relative 'lib/solver/human_solver'
require_relative 'lib/solver/ai_solver'

def solver_factory
  # HumanSolver
  Word.all_words
  AISolver
end
def game_factory
  TerminalGame
end

def new_game
  game_factory.new(solver_factory.new)
end

100.times {new_game.run}
