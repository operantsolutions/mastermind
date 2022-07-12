class Code
  attr_accessor :secret_code

  def initialize(code_string)
    self.secret_code = []
    if code_string == "computer"
      dict = ["B", "Y", "G", "R", "W", "P"]
      4.times do 
        self.secret_code.push(dict[Random.rand(0..5)])
      end
    else self.secret_code = code_string.split("")
    end
  end
  
end