class Chess::King < Chess::Piece
  def directions : Array(Array(Position))
    [
      [ {0, 1} ],
      [ {1, 1} ],
      [ {1, 0} ],
      [ {1, -1} ],
      [ {0, -1} ],
      [ {-1, -1} ],
      [ {-1, 0} ],
      [ {-1, 1} ],
    ]
  end

  def value : Int32
    0
  end
end
