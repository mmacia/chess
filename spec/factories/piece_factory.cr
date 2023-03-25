module PieceFactory
  def self.random_class
    Chess::PIECES.sample
  end

  def self.random(color : Chess::Color? = nil) : Chess::Piece
    color = color.nil? ? [Chess::Color::White, Chess::Color::Black].sample : color
    random_class.new(color)
  end
end
