require "../spec_helper"


EMPTY_BOARD = <<-BOARD
  |---|---|---|---|---|---|---|---|
1 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
2 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
3 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
4 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
5 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
6 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
7 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
8 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
    a   b   c   d   e   f   g   h

BOARD


NEW_GAME = <<-BOARD
  |---|---|---|---|---|---|---|---|
1 | ♜ | ♞ | ♝ | ♛ | ♚ | ♝ | ♞ | ♜ |
  |---|---|---|---|---|---|---|---|
2 | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ | ♟ |
  |---|---|---|---|---|---|---|---|
3 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
4 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
5 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
6 |   |   |   |   |   |   |   |   |
  |---|---|---|---|---|---|---|---|
7 | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ | ♙ |
  |---|---|---|---|---|---|---|---|
8 | ♖ | ♘ | ♗ | ♕ | ♔ | ♗ | ♘ | ♖ |
  |---|---|---|---|---|---|---|---|
    a   b   c   d   e   f   g   h

BOARD


describe Chess::CLIPresenter do
  presenter = Chess::CLIPresenter.new

  describe "#draw" do
    it "should draw an empty board" do
      board = Chess::Board.new

      repr = presenter.draw(board)
      repr.should eq(EMPTY_BOARD)
    end

    it "should draw a new game board" do
      board = Chess::Board.new
      board.setup_new_game

      repr = presenter.draw(board)
      repr.should eq(NEW_GAME)
    end
  end
end
