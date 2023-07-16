class Chess::FinishDetector
  getter winner : Color? = nil
  getter reason : String = ""
  property playable_pieces_white : Array(Piece) = [] of Piece
  property playable_pieces_black : Array(Piece) = [] of Piece
  property player_white : Player?
  property player_black : Player?


  def finished? : Bool
    king_captured? || player_demands_yield?
  end

  def reset! : Nil
    @winner = nil
    @reason = ""
    @playable_pieces_white = [] of Piece
    @playable_pieces_black = [] of Piece
    @player_white = nil
    @player_black = nil
    nil
  end

  def king_captured? : Bool
    w_captured = playable_pieces_white.none?(King)
    b_captured = playable_pieces_black.none?(King)

    if w_captured
      @winner = Color::Black
      @reason = "White King captured"
    end

    if b_captured
      @winner = Color::White
      @reason = "Black King captured"
    end

    w_captured || b_captured
  end

  def player_demands_yield? : Bool
    w_yield = player_white.not_nil!.yield?
    b_yield = player_black.not_nil!.yield?

    if w_yield
      @winner = Color::Black
      @reason = "White yields"
    end

    if b_yield
      @winner = Color::White
      @reason = "Black yields"
    end

    w_yield || b_yield
  end
end
