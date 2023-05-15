class Chess::Pawn < Chess::Piece
  def directions : Array(Array(Position))
    [
      forward_moves,
      attack_moves
    ]
  end

  def value : Int32
    1
  end

  def possible_moves(board : Board) : Array(Position)
    moves = [] of Position
    row, col = self.position

    # check forward movements
    forward_moves.each do |relative_pos|
      move = {row + relative_pos[0], col + relative_pos[1]}

      if board.in_bounds?(move) && board.empty?(move)
        moves << move
      else
        break
      end
    end

    # check attack movements
    attack_moves.each do |relative_pos|
      move = {row + relative_pos[0], col + relative_pos[1]}
      moves << move if valid_capture?(board, move)
    end

    moves
  end

  private def valid_capture?(board : Board, move : Position) : Bool
    board.in_bounds?(move) && !board.empty?(move) && board.get(move).not_nil!.color != self.color
  end

  private def first_move? : Bool
    row, _ = position
    (white? && row == 6) || (black? && row == 1)
  end

  private def forward_moves : Array(Position)
    moves = [] of Position

    moves << (white? ? {-1, 0} : {1, 0})

    if first_move?
      moves << (white? ? {-2, 0} : {2, 0})
    end

    moves
  end

  private def attack_moves : Array(Position)
    if white?
      [
        {-1, -1},
        {1, -1},
      ]
    else
      [
        {1, 1},
        {-1, 1},
      ]
    end
  end
end
