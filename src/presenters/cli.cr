class Chess::CLIPresenter < Chess::Presenter
  def draw(board : Board) : String
    str = String.build do |str|
      board.cells.each_with_index do |rows, row_idx|
        str << "  |---|---|---|---|---|---|---|---|\n"
        rows.each_with_index do |piece, col_idx|
          str << "#{row_idx + 1} " if col_idx == 0

          case piece
            when  Pawn
              str << "| ♟ " if piece.black?
              str << "| ♙ " if piece.white?
            when Rook
              str << "| ♜ " if piece.black?
              str << "| ♖ " if piece.white?
            when Knight
              str << "| ♞ " if piece.black?
              str << "| ♘ " if piece.white?
            when Bishop
              str << "| ♝ " if piece.black?
              str << "| ♗ " if piece.white?
            when Queen
              str << "| ♛ " if piece.black?
              str << "| ♕ " if piece.white?
            when King
              str << "| ♚ " if piece.black?
              str << "| ♔ " if piece.white?
          else
            str << "|   "
          end

          str << "|\n" if col_idx == 7
        end
      end
        str << "  |---|---|---|---|---|---|---|---|\n"
        str << "    a   b   c   d   e   f   g   h\n"
    end

    str
  end
end
