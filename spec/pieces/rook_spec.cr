require "../spec_helper"


describe Chess::Rook do
  context "in an empty board" do
    rook = Chess::Rook.make_white
    board = BoardFactory.empty_with_piece_in_the_middle_of_board(rook)

    expected_target_positions = [
      {0, 3},
      {1, 3},
      {2, 3},
      {4, 3},
      {5, 3},
      {6, 3},
      {7, 3},
      {3, 0},
      {3, 1},
      {3, 2},
      {3, 4},
      {3, 5},
      {3, 6},
      {3, 7},
    ]

    expected_target_positions.each do |expected|
      it "should move to #{expected}" do
        rook.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces of the same color" do
    rook = Chess::Rook.make_white
    board = BoardFactory.piece_completely_surrounded(rook)

    it "should not move at all" do
      rook.possible_moves(board).should be_empty
    end
  end

  context "completely surrounded by pieces (different colors)" do
    rook = Chess::Rook.make_white
    board = BoardFactory.piece_surrounded_with_different_colors(rook)

    it "should not move at all" do
      rook.possible_moves(board).should be_empty
    end
  end

  context "with different possible moves" do
    rook = Chess::Rook.make_white
    board = BoardFactory.piece_with_several_possible_moves(rook)

    it "should have 8 possible movements" do
      rook.possible_moves(board).size.should eq(8)
    end
  end

  it "should return a value of 5" do
    rook = Chess::Rook.make_white
    rook.value.should eq(5)
  end
end
