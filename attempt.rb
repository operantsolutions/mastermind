class Attempt 
  attr_accessor :guess

  def initialize(guess)
    self.guess = guess.split("")
  end

end