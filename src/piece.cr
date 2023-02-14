alias Chess::Position = Tuple(Int32, Int32)

class Chess::Piece
  getter color : Color
  property position : Position

  def initialize(@color : Color, @position : Position = {-1, -1})
  end

  def self.make_white : Piece
    new(Color::White)
  end

  def self.make_black : Piece
    new(Color::Black)
  end
end
