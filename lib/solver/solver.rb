class Solver
  # %w[ask_char tell_current].each do |name|
  #   define_method(name) {raise "abstract Solver"}
  # end
  def tell_tries(tries)
    puts "Total tries: #{tries}"
    puts '-'*50
  end
end