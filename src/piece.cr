alias Chess::Position = Tuple(Int32, Int32)

abstract class Chess::Piece
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

  def possible_moves(board : Board) : Array(Position)
    moves = [] of Position
    initial_pos = self.position

    directions.each do |direction|
      direction.each do |relative_pos|
        move = {initial_pos[0] + relative_pos[0], initial_pos[1] + relative_pos[1]}

        if board.valid_move?(self, move)
          moves << move
        end
      end
    end

    moves
  end

  abstract def directions : Array(Array(Position))
  abstract def value : Int32
end


require "./pieces/*"
