class ImpossibleMove < Exception; end


class Chess::RandomPlayer < Chess::Player
  def initialize(@color : Color)
    @plays_since_last_capture = 0
  end

  def play(board : Board, pieces : Array(Piece)) : Tuple(Piece, Position)
    pieces.shuffle.each do |piece|
      movements = piece.possible_moves(board)

      unless movements.empty?
        movement = movements.sample

        if board.get(movement).nil?
          @plays_since_last_capture += 1
        else
          @plays_since_last_capture = 0
        end

        return {piece, movement}
      end
    end

    raise ImpossibleMove.new
  end

  def yield? : Bool
    @plays_since_last_capture >= 40
  end
end
