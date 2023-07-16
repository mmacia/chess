abstract class Chess::Player
  abstract def play(board : Board, pieces : Array(Piece)) : Tuple(Piece, Position)
  abstract def yield? : Bool
end


require "./players/*"
