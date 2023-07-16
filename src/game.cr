class Chess::Game
  getter player_white : Player
  getter player_black : Player
  getter turn : Color = Color::White

  private getter board : Board
  private getter presenter : Presenter
  private getter whites : Array(Piece) = Array(Piece).new
  private getter blacks : Array(Piece) = Array(Piece).new

  def initialize(@presenter : Presenter, @player_white : Player, @player_black : Player)
    @board = Board.new
    @board.setup_new_game
    store_pieces_references
  end

  def start
    finished = false
    finish_detector = FinishDetector.new
    turn_count = 1

    while !finished
      print "Turn #{turn_count}\n"
      print presenter.draw(board)

      if turn == Color::White
        piece, target = player_white.play(board, playable_pieces(Color::White))
      else
        piece, target = player_black.play(board, playable_pieces(Color::Black))
      end

      print message(piece, target)
      board.move(piece, target)

      toggle_turn
      turn_count += 1

      setup_finish_detector finish_detector
      finished = finish_detector.finished?
    end

    print "\nWinner is: #{finish_detector.winner}, #{finish_detector.reason}\n"
  end

  private def setup_finish_detector(finish_detector : FinishDetector) : Nil
    finish_detector.playable_pieces_white = playable_pieces(Color::White)
    finish_detector.playable_pieces_black = playable_pieces(Color::Black)
    finish_detector.player_white = player_white
    finish_detector.player_black = player_black
    nil
  end

  private def toggle_turn
    new_turn = @turn == Color::White ? Color::Black : Color::White
    @turn = new_turn
  end

  private def message(piece : Piece, target : Position) : String
    captured = board.get(target).nil? ? "" : "CAPTURES #{board.get(target)}"
    "#{turn} moves #{piece} -> #{target} #{captured}\n"
  end

  private def playable_pieces(color : Color) : Array(Piece)
    if color == Color::White
      whites.select { |x| !x.captured? }
    else
      blacks.select { |x| !x.captured? }
    end
  end

  private def store_pieces_references
    8.times do |row|
      8.times do |col|
        piece = board.get({row, col})

        if !piece.nil?
          piece = piece.not_nil!

          if piece.white?
            whites << piece
          else
            blacks << piece
          end
        end
      end
    end
  end
end
