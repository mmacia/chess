class Chess::Board
  getter cells : StaticArray(StaticArray(Piece?, 8), 8)

  def initialize
    @cells = StaticArray(StaticArray(Piece?, 8), 8).new(
      StaticArray(Piece?, 8).new(nil)
    )
  end

  def move(piece : Piece, position : Position)
    raise OutOfBounds.new(position) unless in_bounds?(position)

    piece.position = position
    row, col = position
    cells.update(row) { |row_| row_[col] = piece; row_ }
  end

  def get(position : Position) : Piece?
    raise OutOfBounds.new(position) unless in_bounds?(position)

    row, col = position
    cells[row][col]
  end

  def reset : Nil
    @cells = StaticArray(StaticArray(Piece?, 8), 8).new(
      StaticArray(Piece?, 8).new(nil)
    )
    nil
  end

  def setup_new_game
    reset

    8.times { |col| move Piece.make_black, {0, col} }
    8.times { |col| move Piece.make_black, {1, col} }

    8.times { |col| move Piece.make_white, {6, col} }
    8.times { |col| move Piece.make_white, {7, col} }
  end

  private def in_bounds?(position : Position) : Bool
    row, col = position
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end
end
