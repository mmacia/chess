require "../spec_helper"


describe Chess::Pawn do
  context "black in start position board" do
    pawn = Chess::Pawn.make_black
    board = BoardFactory.pawn_in_start_position(pawn)

    expected_target_positions = [
      {2, 3},
      {3, 3}
    ]

    expected_target_positions.each do |expected|
      it "should move to #{expected}" do
        pawn.possible_moves(board).should contain(expected)
      end
    end

    it "should not capture a piece in front" do
      piece = PieceFactory.random(Chess::Color::White)
      board.move piece, {pawn.position[0] + 1, pawn.position[1]}

      pawn.possible_moves(board).should be_empty
    end
  end

  context "white in start position board" do
    pawn = Chess::Pawn.make_white
    board = BoardFactory.pawn_in_start_position(pawn)

    expected_target_positions = [
      {5, 3},
      {4, 3}
    ]

    expected_target_positions.each do |expected|
      it "should move to #{expected}" do
        pawn.possible_moves(board).should contain(expected)
      end
    end

    it "should not capture a piece in front" do
      piece = PieceFactory.random(Chess::Color::Black)
      board.move piece, {pawn.position[0] - 1, pawn.position[1]}

      pawn.possible_moves(board).should be_empty
    end
  end

  context "black in non-start position" do
    pawn = Chess::Pawn.make_black
    board = BoardFactory.pawn_in_non_start_position(pawn)

    it "should move 1 square forward" do
      moves = pawn.possible_moves(board)

      moves.size.should eq(1)
      moves.first.should eq({3, 3})
    end

    it "should not capture a piece in front" do
      piece = PieceFactory.random(Chess::Color::White)
      board.move piece, {pawn.position[0] + 1, pawn.position[1]}

      pawn.possible_moves(board).should be_empty
    end
  end

  context "white in non-start position" do
    pawn = Chess::Pawn.make_white
    board = BoardFactory.pawn_in_non_start_position(pawn)

    it "should move 1 square forward" do
      moves = pawn.possible_moves(board)

      moves.size.should eq(1)
      moves.first.should eq({4, 3})
    end

    it "should not capture a piece in front" do
      piece = PieceFactory.random(Chess::Color::Black)
      board.move piece, {pawn.position[0] - 1, pawn.position[1]}

      pawn.possible_moves(board).should be_empty
    end
  end

  context "black in capture" do
    pawn = Chess::Pawn.make_black

    it "should capture both pieces" do
      board = BoardFactory.pawn_in_attack(pawn)
      pawn.possible_moves(board).size.should eq(3)
    end

    it "should not capture pieces of the same color" do
      board = BoardFactory.pawn_in_attack(pawn, same_color: true)
      pawn.possible_moves(board).size.should eq(1)
    end
  end

  context "white in capture" do
    pawn = Chess::Pawn.make_white

    it "should capture both pieces" do
      board = BoardFactory.pawn_in_attack(pawn)
      pawn.possible_moves(board).size.should eq(3)
    end

    it "should not capture pieces of the same color" do
      board = BoardFactory.pawn_in_attack(pawn, same_color: true)
      pawn.possible_moves(board).size.should eq(1)
    end
  end

  it "should return a value of 1" do
    pawn = Chess::Pawn.make_black
    pawn.value.should eq(1)
  end
end
