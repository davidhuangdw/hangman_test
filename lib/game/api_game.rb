require_relative 'game'
class ApiGame < Game
  def initialize(*args,connection:)
    @conn = connection
    super
  end

  private
  def update_current_after_guess(char)
  end
  def first_current
  end
end