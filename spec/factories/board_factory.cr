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
end
