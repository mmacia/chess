require "./chess"


game = Chess::Game.new(
  Chess::CLIPresenter.new,
  Chess::RandomPlayer.new(Chess::Color::White),
  Chess::RandomPlayer.new(Chess::Color::Black),
)

game.start
