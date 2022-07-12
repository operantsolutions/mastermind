class Game
  attr_accessor :player, :is_over

  def initialize(player)
    self.player = player
    self.is_over = false
  end

end