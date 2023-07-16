module PieceFactory
  def self.random_class
    Chess::PIECES.sample
  end

  def self.random(color : Chess::Color? = nil) : Chess::Piece
    color = color.nil? ? [Chess::Color::White, Chess::Color::Black].sample : color
    random_class.new(color)
  end

  def self.random_list(
    count : Int32,
    color : Chess::Color,
    skip : Chess::Piece.class | Nil = nil
  ) : Array(Chess::Piece)
    ret = [] of Chess::Piece

    while ret.size < count
      new_piece = PieceFactory.random(color)
      new_piece.position = {rand(0..7), rand(0..7)}

      if skip
        ret << new_piece if new_piece.class != skip
      else
        ret << new_piece
      end
    end

    ret
  end
end
