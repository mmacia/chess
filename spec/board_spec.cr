require "./spec_helper"


describe Chess::Board do
  subject = Chess::Board.new

  it "should set a piece in a desired position" do
    piece = PieceFactory.random
    new_position = {1, 2}

    subject.reset
    subject.move(piece, new_position)
    subject.get(new_position).should eq(piece)
  end

  it "should reset the board and get nil on every position in empty board" do
    piece = PieceFactory.random
    new_position = {1, 2}
    subject.move(piece, new_position)

    subject.reset

    8.times do |x|
      8.times do |y|
        subject.get({x, y}).should be_nil
      end
    end
  end

  it "should not move a piece out of bounds" do
    piece = PieceFactory.random
    new_position = {8, 5}

    expect_raises Chess::OutOfBounds do
      subject.move(piece, new_position)
    end
  end

  it "should set to nil the initial position after move" do
    piece = PieceFactory.random
    orig_position = {3, 5}

    subject.reset
    subject.move(piece, orig_position)

    new_position = {2, 5}
    subject.move(piece, new_position)

    subject.get(orig_position).should be_nil
    subject.get(new_position).should_not be_nil
  end

  it "should not get a position out of bounds" do
    new_position = {4, 9}

    expect_raises Chess::OutOfBounds do
      subject.get(new_position)
    end
  end

  it "should setup a new board" do
    subject.setup_new_game

    8.times do |col|
      cell = subject.get({0, col}).not_nil!
      cell.should be_a(Chess::Piece)
      cell.color.should eq(Chess::Color::Black)
    end

    8.times do |col|
      cell = subject.get({1, col}).not_nil!
      cell.should be_a(Chess::Piece)
      cell.color.should eq(Chess::Color::Black)
    end

    8.times do |col|
      cell = subject.get({6, col}).not_nil!
      cell.should be_a(Chess::Piece)
      cell.color.should eq(Chess::Color::White)
    end

    8.times do |col|
      cell = subject.get({7, col}).not_nil!
      cell.should be_a(Chess::Piece)
      cell.color.should eq(Chess::Color::White)
    end
  end

  describe "#valid_move?" do
    it "should return true if the piece is moved to an empty square" do
      piece = PieceFactory.random
      board = BoardFactory.empty_with_piece_in_the_middle_of_board(piece)
      initial_pos = piece.position
      target_pos = {initial_pos[0], initial_pos[1] + 1}

      board.valid_move?(piece, target_pos).should be_true
    end

    it "should return true if the piece is moved to a square with a piece of other color" do
      piece = PieceFactory.random(Chess::Color::White)
      board = BoardFactory.empty_with_piece_in_the_middle_of_board(piece)
      initial_pos = piece.position
      target_pos = {initial_pos[0], initial_pos[1] + 1}

      other_piece = PieceFactory.random(Chess::Color::Black)
      board.move other_piece, target_pos

      board.valid_move?(piece, target_pos).should be_true
    end

    it "should return false if the piece is moved to a square with a piece of same color" do
      piece = PieceFactory.random(Chess::Color::White)
      board = BoardFactory.piece_completely_surrounded(piece)
      initial_pos = piece.position
      target_pos = {initial_pos[0], initial_pos[1] + 1}

      board.valid_move?(piece, target_pos).should be_false
    end

    it "should return false when target is out of bounds" do
      piece = PieceFactory.random(Chess::Color::White)
      board = BoardFactory.empty_with_piece_in_the_middle_of_board(piece)
      initial_pos = piece.position
      target_pos = {initial_pos[0], initial_pos[1] + 7}

      board.valid_move?(piece, target_pos).should be_false
    end
  end

  describe "#empty?" do
    it "should return true if the position is empty" do
      board = Chess::Board.new
      board.empty?({0, 0}).should be_true
    end

    it "should return false if the position is not empty" do
      piece = PieceFactory.random
      board = BoardFactory.empty_with_piece_in_the_middle_of_board(piece)

      board.empty?({3, 3}).should be_false
    end
  end

  describe "#in_bounds?" do
    board = Chess::Board.new

    it "should return false when row is negative" do
      move = {-1, rand(0..7)}
      board.in_bounds?(move).should be_falsey
    end

    it "should return false when col is negative" do
      move = {rand(0..7), -1}
      board.in_bounds?(move).should be_falsey
    end

    it "should return false when row is greater than 7" do
      move = {8, rand(0..7)}
      board.in_bounds?(move).should be_falsey
    end

    it "should return false when col is greater than 7" do
      move = {rand(0..7), 8}
      board.in_bounds?(move).should be_falsey
    end

    it "should return true when row is between 0 and 7" do
      move = {rand(0..7), 3}
      board.in_bounds?(move).should be_truthy
    end

    it "should return true when col is between 0 and 7" do
      move = {3, rand(0..7)}
      board.in_bounds?(move).should be_truthy
    end
  end
end
