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

    move Rook.make_black, {0, 0}
    move Knight.make_black, {0, 1}
    move Bishop.make_black, {0, 2}
    move Queen.make_black, {0, 3}
    move King.make_black, {0, 4}
    move Bishop.make_black, {0, 5}
    move Knight.make_black, {0, 6}
    move Rook.make_black, {0, 7}
    8.times { |col| move Pawn.make_black, {1, col} }

    8.times { |col| move Pawn.make_white, {6, col} }
    move Rook.make_white, {7, 0}
    move Knight.make_white, {7, 1}
    move Bishop.make_white, {7, 2}
    move Queen.make_white, {7, 3}
    move King.make_white, {7, 4}
    move Bishop.make_white, {7, 5}
    move Knight.make_white, {7, 6}
    move Rook.make_white, {7, 7}
  end

  def valid_move?(piece : Piece, position : Position) : Bool
    return false unless in_bounds?(position)
    target = get(position)

    return true if target.nil? || target.not_nil!.color != piece.color
    false
  end

  def empty?(position : Position) : Bool
    get(position).nil?
  end

  def in_bounds?(position : Position) : Bool
    row, col = position
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end
end
