require "../spec_helper"


describe Chess::Bishop do
  context "in an empty board" do
    bishop = Chess::Bishop.make_white
    board = BoardFactory.empty_with_piece_in_the_middle_of_board(bishop)

    expected_target_positions = [
      {2, 4},
      {1, 5},
      {0, 6},
      {4, 4},
      {5, 5},
      {6, 6},
      {7, 7},
      {4, 2},
      {5, 1},
      {6, 0},
      {2, 2},
      {1, 1},
      {0, 0},
    ]

    expected_target_positions.each do |expected|
      it "should move to #{expected}" do
        bishop.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces of the same color" do
    bishop = Chess::Bishop.make_white
    board = BoardFactory.piece_completely_surrounded(bishop)

    it "should not move at all" do
      bishop.possible_moves(board).should be_empty
    end
  end

  context "completely surrounded by pieces (different colors)" do
    bishop = Chess::Bishop.make_white
    board = BoardFactory.piece_surrounded_with_different_colors(bishop)

    it "should capture 2 pieces" do
      bishop.possible_moves(board).size.should eq(2)
    end
  end

  context "with different possible moves" do
    bishop = Chess::Bishop.make_white
    board = BoardFactory.piece_with_several_possible_moves(bishop)

    it "should have 10 possible movements" do
      bishop.possible_moves(board).size.should eq(10)
    end
  end

  it "should return a value of 3" do
    bishop = Chess::Bishop.make_black
    bishop.value.should eq(3)
  end
end
