module BoardFactory
  def self.empty_with_piece_in_the_middle_of_board(piece : Chess::Piece)
    board = Chess::Board.new
    initial_pos = {3, 3}

    board.move piece, initial_pos
    board
  end

  def self.piece_completely_surrounded(piece : Chess::Piece)
    board = Chess::Board.new

    board.move piece, {0, 3}
    board.move PieceFactory.random(piece.color), {0, 2}
    board.move PieceFactory.random(piece.color), {1, 2}
    board.move PieceFactory.random(piece.color), {1, 3}
    board.move PieceFactory.random(piece.color), {1, 4}
    board.move PieceFactory.random(piece.color), {0, 4}

    board
  end

  def self.piece_surrounded_with_different_colors(piece : Chess::Piece)
    board = Chess::Board.new

    board.move piece, {0, 3}
    board.move PieceFactory.random(Chess::Color::White), {0, 2}
    board.move PieceFactory.random(Chess::Color::Black), {1, 2}
    board.move PieceFactory.random(Chess::Color::White), {1, 3}
    board.move PieceFactory.random(Chess::Color::Black), {1, 4}
    board.move PieceFactory.random(Chess::Color::White), {0, 4}

    board
  end

  def self.piece_with_several_possible_moves(piece : Chess::Piece)
    board = Chess::Board.new

    board.move piece, {2, 3}
    board.move PieceFactory.random(Chess::Color::White), {0, 1}
    board.move PieceFactory.random(Chess::Color::Black), {1, 3}
    board.move PieceFactory.random(Chess::Color::White), {2, 2}
    board.move PieceFactory.random(Chess::Color::Black), {5, 3}
    board.move PieceFactory.random(Chess::Color::White), {1, 5}

    board
  end

  def self.pawn_in_start_position(pawn : Chess::Pawn)
    board = Chess::Board.new

    if pawn.white?
      board.move pawn, {6, 3}
    else
      board.move pawn, {1, 3}
    end

    board
  end

  def self.pawn_in_non_start_position(pawn : Chess::Pawn)
    board = Chess::Board.new

    if pawn.white?
      board.move pawn, {5, 3}
    else
      board.move pawn, {2, 3}
    end

    board
  end

  def self.pawn_in_attack(pawn : Chess::Pawn, same_color : Bool = false)
    board = Chess::Board.new

    color =
      if same_color
        pawn.color
      else
        pawn.color == Chess::Color::White ? Chess::Color::Black : Chess::Color::White
      end

    other1, other2 = [PieceFactory.random(color), PieceFactory.random(color)]

    board.move pawn, {4, 3}

    if pawn.white?
      board.move other1, {pawn.position[0] - 1, pawn.position[1] - 1}
      board.move other2, {pawn.position[0] + 1, pawn.position[1] - 1}
    else
      board.move other1, {pawn.position[0] + 1, pawn.position[1] + 1}
      board.move other2, {pawn.position[0] - 1, pawn.position[1] + 1}
    end

    board
  end
end
