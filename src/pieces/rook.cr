class Chess::Rook < Chess::Piece
  def directions : Array(Array(Position))
    [
      RELATIVE_MOVES_RIGHT,
      RELATIVE_MOVES_LEFT,
      RELATIVE_MOVES_UP,
      RELATIVE_MOVES_DOWN,
    ]
  end

  def value : Int32
    5
  end
end
