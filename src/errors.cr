class Chess::OutOfBounds < Exception
  getter position : Position

  def initialize(@position : Position)
  end

  def message : String?
    "Position #{position} is out of board bounds"
  end
end
