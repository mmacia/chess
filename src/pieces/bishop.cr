class Chess::Bishop < Chess::Piece
  def directions : Array(Array(Position))
    [
      RELATIVE_MOVES_UP_RIGHT,
      RELATIVE_MOVES_DOWN_RIGHT,
      RELATIVE_MOVES_UP_LEFT,
      RELATIVE_MOVES_DOWN_LEFT,
    ]
  end

  def value : Int32
    3
  end
end
