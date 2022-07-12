class Game
  attr_accessor :player, :board, :is_over

  def initialize(player)
    self.player = player
    self.board = []
    self.is_over = false
  end

end