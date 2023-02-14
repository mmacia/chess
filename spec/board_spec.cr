require "./spec_helper"


describe Chess::Board do
  subject = Chess::Board.new

  it "should set a piece in a desired position" do
    piece = Chess::Piece.make_black
    new_position = {1, 2}

    subject.reset
    subject.move(piece, new_position)
    subject.get(new_position).should eq(piece)
  end

  it "should reset the board and get nil on every position in empty board" do
    piece = Chess::Piece.make_white
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
    piece = Chess::Piece.make_white
    new_position = {8, 5}

    expect_raises Chess::OutOfBounds do
      subject.move(piece, new_position)
    end
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
end
