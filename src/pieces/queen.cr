class Chess::Queen < Chess::Piece
  def directions : Array(Array(Position))
    [
      RELATIVE_MOVES_UP,
      RELATIVE_MOVES_UP_RIGHT,
      RELATIVE_MOVES_RIGHT,
      RELATIVE_MOVES_DOWN_RIGHT,
      RELATIVE_MOVES_DOWN,
      RELATIVE_MOVES_DOWN_LEFT,
      RELATIVE_MOVES_LEFT,
      RELATIVE_MOVES_UP_LEFT,
    ]
  end

  def value : Int32
    9
  end
end
