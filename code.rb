class Code
  attr_accessor :secret_code

  def initialize
    dict = ["B", "Y", "G", "R", "W", "P"]
    self.secret_code = []
    4.times do 
      self.secret_code.push(dict[Random.rand(0..5)])
    end
  end
  
end