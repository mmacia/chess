class Chess::Knight < Chess::Piece
  def directions : Array(Array(Position))
    [
      [ {-2, 1} ],
      [ {-1, 2} ],
      [ {1, 2} ],
      [ {2, 1} ],
      [ {2, -1} ],
      [ {1, -2} ],
      [ {-1, -2} ],
      [ {-2, -1} ]
    ]
  end

  def value : Int32
    3
  end
end
