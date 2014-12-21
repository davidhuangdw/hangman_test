require_relative 'lib/game/terminal_game'
require_relative 'lib/solver/human_solver'
require_relative 'lib/solver/ai_solver'
require_relative 'lib/game/api_game'

def solver_factory
  # HumanSolver
  Word.all_words
  AISolver
end
def game_factory
  # TerminalGame
  ApiGame
end

def new_game
  game_factory.new(solver_factory)
end

game = new_game
80.times do
  game.run
end
# puts game.submit_result
