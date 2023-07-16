alias Chess::Position = Tuple(Int32, Int32)

abstract class Chess::Piece
  getter color : Color
  property position : Position

  private RELATIVE_MOVES_UP = [
    {-1, 0},
    {-2, 0},
    {-3, 0},
    {-4, 0},
    {-5, 0},
    {-6, 0},
    {-7, 0},
  ]
  private RELATIVE_MOVES_UP_RIGHT = [
    {1, 1},
    {2, 2},
    {3, 3},
    {4, 4},
    {5, 5},
    {6, 6},
    {7, 7},
  ]
  private RELATIVE_MOVES_RIGHT = [
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4},
    {0, 5},
    {0, 6},
    {0, 7},
  ]
  private RELATIVE_MOVES_DOWN_RIGHT = [
    {1, -1},
    {2, -2},
    {3, -3},
    {4, -4},
    {5, -5},
    {6, -6},
    {7, -7},
  ]
  private RELATIVE_MOVES_DOWN = [
    {1, 0},
    {2, 0},
    {3, 0},
    {4, 0},
    {5, 0},
    {6, 0},
    {7, 0},
  ]
  private RELATIVE_MOVES_DOWN_LEFT = [
    {-1, -1},
    {-2, -2},
    {-3, -3},
    {-4, -4},
    {-5, -5},
    {-6, -6},
    {-7, -7},
  ]
  private RELATIVE_MOVES_LEFT = [
    {0, -1},
    {0, -2},
    {0, -3},
    {0, -4},
    {0, -5},
    {0, -6},
    {0, -7},
  ]
  private RELATIVE_MOVES_UP_LEFT = [
    {-1, 1},
    {-2, 2},
    {-3, 3},
    {-4, 4},
    {-5, 5},
    {-6, 6},
    {-7, 7},
  ]

  def initialize(@color : Color, @position : Position = {-1, -1})
  end

  def self.make_white : Piece
    new(Color::White)
  end

  def self.make_black : Piece
    new(Color::Black)
  end

  def white? : Bool
    self.color == Color::White
  end

  def black? : Bool
    self.color == Color::Black
  end

  def captured? : Bool
    self.position == {-1, -1}
  end

  def possible_moves(board : Board) : Array(Position)
    moves = [] of Position
    initial_pos = self.position

    directions.each do |direction|
      direction.each do |relative_pos|
        move = {initial_pos[0] + relative_pos[0], initial_pos[1] + relative_pos[1]}

        if board.valid_move?(self, move)
          moves << move
          break if !board.empty?(move)  # do not allow jump over pieces
        else
          break  # do not allow jump over pieces
        end
      end
    end

    moves
  end

  abstract def directions : Array(Array(Position))
  abstract def value : Int32
end


require "./pieces/*"
